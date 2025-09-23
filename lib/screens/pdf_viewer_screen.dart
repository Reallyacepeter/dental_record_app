import 'dart:io';
import 'package:flutter/foundation.dart'; // ✅ consolidateHttpClientResponseBytes
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/file_cache_service.dart';

class PdfViewerScreen extends StatefulWidget {
  final String url;
  final String? title;

  const PdfViewerScreen({super.key, required this.url, this.title});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  PdfControllerPinch? _controller;
  String? _localPath;

  @override
  void initState() {
    super.initState();
    _warm();
  }

  Future<void> _warm() async {
    // 1) 캐시/로컬 파일로 열기
    try {
      final path = await FileCacheService.I.getOrDownload(widget.url);
      _localPath = path;
      _controller = PdfControllerPinch(
        document: PdfDocument.openFile(path),
      );
      if (mounted) setState(() {});
      return; // ✅ 성공 시 바로 종료
    } catch (_) {
      // fall through to network
    }

    // 2) 네트워크에서 바이트로 받아 openData
    try {
      final req = await HttpClient().getUrl(Uri.parse(widget.url));
      final resp = await req.close();
      final bytes = await consolidateHttpClientResponseBytes(resp);

      _controller = PdfControllerPinch(
        document: PdfDocument.openData(bytes),
      );
      if (mounted) setState(() {});
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF 로드 실패: $e')),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _openExternal() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('외부 앱으로 열 수 없습니다.')),
      );
    }
  }

  String get _title {
    try {
      return widget.title ?? Uri.decodeComponent(Uri.parse(widget.url).pathSegments.last);
    } catch (_) {
      return widget.title ?? 'PDF';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ready = _controller != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(_title, overflow: TextOverflow.ellipsis),
        actions: [
          if (_localPath != null && File(_localPath!).existsSync())
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Cached', style: TextStyle(color: Colors.green)),
                ),
              ),
            ),
          IconButton(icon: const Icon(Icons.open_in_new), onPressed: _openExternal),
        ],
      ),
      body: ready
          ? PdfViewPinch(
        controller: _controller!,
        onDocumentError: (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('PDF 오류: $e')),
          );
        },
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

