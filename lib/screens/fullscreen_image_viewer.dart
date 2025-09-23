import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/file_cache_service.dart';

class FullscreenImageViewer extends StatefulWidget {
  final String url;
  final String? title;

  const FullscreenImageViewer({
    super.key,
    required this.url,
    this.title,
  });

  @override
  State<FullscreenImageViewer> createState() => _FullscreenImageViewerState();
}

class _FullscreenImageViewerState extends State<FullscreenImageViewer> {
  final TransformationController _controller = TransformationController();
  String? _localPath;

  @override
  void initState() {
    super.initState();
    _warm();
  }

  Future<void> _warm() async {
    try {
      final path = await FileCacheService.I.getOrDownload(widget.url);
      if (mounted) setState(() => _localPath = path);
    } catch (_) {
      if (mounted) setState(() => _localPath = null);
    }
  }

  TapDownDetails? _doubleTapDetails;
  void _handleDoubleTap() {
    final pos = _doubleTapDetails?.localPosition;
    if (pos == null) return;
    const double zoom = 2.5;
    final current = _controller.value;
    if (current.getMaxScaleOnAxis() > 1.01) {
      _controller.value = Matrix4.identity();
    } else {
      final x = -pos.dx * (zoom - 1);
      final y = -pos.dy * (zoom - 1);
      _controller.value = Matrix4.identity()..translate(x, y)..scale(zoom);
    }
  }

  Future<void> _openExternal() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('외부 앱으로 열 수 없습니다.')),
        );
      }
    }
  }

  String get _title {
    try {
      return widget.title ?? Uri.decodeComponent(Uri.parse(widget.url).pathSegments.last);
    } catch (_) {
      return widget.title ?? 'Image';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLocalReady = _localPath != null && File(_localPath!).existsSync();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(_title, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white)),
        actions: [
          IconButton(icon: const Icon(Icons.open_in_new), onPressed: _openExternal),
        ],
      ),
      body: Center(
        child: GestureDetector(
          onTapDown: (d) => _doubleTapDetails = d,
          onDoubleTap: _handleDoubleTap,
          child: InteractiveViewer(
            transformationController: _controller,
            minScale: 1,
            maxScale: 5,
            clipBehavior: Clip.none,
            child: Hero(
              tag: widget.url,
              child: isLocalReady
                  ? Image.file(File(_localPath!), fit: BoxFit.contain)
                  : Image.network(
                widget.url,
                fit: BoxFit.contain,
                loadingBuilder: (c, child, progress) {
                  if (progress == null) return child;
                  final v = progress.expectedTotalBytes != null
                      ? progress.cumulativeBytesLoaded / (progress.expectedTotalBytes!)
                      : null;
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      const SizedBox(height: 200, width: 200),
                      CircularProgressIndicator(value: v),
                    ],
                  );
                },
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, color: Colors.white54, size: 64),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
