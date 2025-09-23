// lib/screens/pdf_preview_screen.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import '../services/pdf_service.dart';

class PdfPreviewScreen extends StatelessWidget {
  const PdfPreviewScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  Future<Uint8List> _buildPdf(_) => PdfService.buildFinalReviewPdf(data);

  @override
  Widget build(BuildContext context) {
    final fileName = PdfService.buildFileName(data);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF 미리보기'),
        actions: [
          IconButton(
            tooltip: '다운로드 폴더에 저장',
            icon: const Icon(Icons.download_outlined),
            onPressed: () async {
              try {
                final bytes = await PdfService.buildFinalReviewPdf(data);
                await savePdfToDownloads(bytes, fileName); // Android SAF 저장
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('다운로드 폴더에 저장 완료')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('저장 실패: $e')),
                  );
                }
              }
            },
          ),
        ],
      ),
      body: PdfPreview(
        build: _buildPdf,                 // <- PDF 생성 함수
        pdfFileName: fileName,            // 공유/인쇄 시 파일명
        canChangePageFormat: true,        // A4 등 포맷 변경 허용
        canChangeOrientation: true,       // 세/가로 전환 허용
        canDebug: false,
        allowPrinting: true,              // 시스템 인쇄(=PDF 저장/공유 UI) 허용
        allowSharing: true,               // 공유 허용 (카톡/이메일/Drive 등)
        maxPageWidth: 800,                // 미리보기 너비
      ),
    );
  }
}
