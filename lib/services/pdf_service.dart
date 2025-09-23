// // lib/services/pdf_service.dart
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart'; // networkImage
// import 'package:flutter_file_dialog/flutter_file_dialog.dart';
// import 'package:path_provider/path_provider.dart';
//
// /// SAF로 안드로이드 Downloads에 저장. (iOS/웹 등은 공유로 우회)
// Future<void> savePdfToDownloads(Uint8List bytes, String filename) async {
//   if (Platform.isAndroid) {
//     // 1) 임시 파일로 저장
//     final tempDir = await getTemporaryDirectory();
//     final tempPath = '${tempDir.path}/$filename';
//     final tempFile = File(tempPath);
//     await tempFile.writeAsBytes(bytes);
//
//     // 2) SAF 다이얼로그로 "다운로드" 제안 + 저장
//     final params = SaveFileDialogParams(
//       sourceFilePath: tempPath,
//       fileName: filename,
//       // directory:  지정 필드는 없지만, Android가 일반적으로 "다운로드"를 기본 후보로 보여줍니다.
//       // (사용자는 다른 퍼블릭 폴더도 선택 가능)
//     );
//     final resultPath = await FlutterFileDialog.saveFile(params: params);
//
//     if (resultPath == null) {
//       throw Exception('사용자가 저장을 취소했습니다.');
//     }
//   } else {
//     // 안드 외 플랫폼은 공유로 처리(필요 시 플랫폼별 분기 확장)
//     throw UnsupportedError('Android 외 플랫폼은 SAF 저장을 지원하지 않습니다.');
//   }
// }
//
// class PdfService {
//   // ---------- 유틸 ----------
//   static String _ymd(DateTime d) =>
//       '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
//
//   static String _dateStrFromIso(String? iso) {
//     if (iso == null || iso.isEmpty) return '없음';
//     return iso.split('T').first;
//   }
//
//   static String _yn(dynamic v) => v == true ? '예' : (v == false ? '아니오' : '');
//
//   static pw.Widget _line(String label, String value) {
//     return pw.Padding(
//       padding: const pw.EdgeInsets.symmetric(vertical: 2),
//       child: pw.Row(
//         crossAxisAlignment: pw.CrossAxisAlignment.start,
//         children: [
//           pw.Container(width: 140, child: pw.Text(label, style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
//           pw.Expanded(child: pw.Text(value)),
//         ],
//       ),
//     );
//   }
//
//   static pw.Widget _bulletSection(String title, List<String> items) {
//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//         pw.SizedBox(height: 6),
//         if (items.isEmpty) pw.Text('없음')
//         else pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: items.map((e) => pw.Bullet(text: e)).toList(),
//         ),
//         pw.SizedBox(height: 8),
//       ],
//     );
//   }
//
//   static String buildFileName(Map<String, dynamic> data, {DateTime? when}) {
//     final isPm = data['recordType'] == 'PM';
//     final no = isPm ? (data['pmNumber'] ?? '') : (data['amNumber'] ?? '');
//     final label = isPm ? 'PM' : 'AM';
//     final date = _ymd(when ?? DateTime.now());
//     final noStr = no.toString().trim();
//     final safeNo = noStr.isEmpty ? 'NO' : noStr;  // ✅ 변수명 safeNo
//     return '$label-$safeNo-$date.pdf';            // ✅ 언더스코어 없는 safeNo 사용
//   }
//
//   /// 최종검토 PDF 생성 (썸네일 클릭 → 원본 이미지 페이지 이동, 푸터 포함)
//   static Future<Uint8List> buildFinalReviewPdf(Map<String, dynamic> data) async {
//
//     final ttf = await rootBundle.load("assets/fonts/NotoSansKR-Regular.otf");
//     final font = pw.Font.ttf(ttf);
//
//     final doc = pw.Document();
//     final generatedAt = DateTime.now();
//
//     final isPm = data['recordType'] == 'PM';
//     final recordLabel = isPm ? 'Post-mortem (PM)' : 'Ante-mortem (AM)';
//     final idLabel = isPm ? 'PM 번호' : 'AM 번호';
//     final idValue = isPm ? (data['pmNumber'] ?? '') : (data['amNumber'] ?? '');
//
//     // ---------- Odontogram spans ----------
//     final spans = (data['spans'] as List?) ?? const [];
//     final spansLines = <String>[];
//     for (final raw in spans) {
//       final m = (raw as Map).map((k, v) => MapEntry(k.toString(), v));
//       final type = (m['type'] ?? '').toString();
//       final code = (m['code'] ?? '').toString();
//       final teeth = ((m['teeth'] as List?) ?? const []).map((e) => e.toString()).toList()..sort();
//       final abut  = ((m['abutments'] as List?) ?? const []).map((e) => e.toString()).toList()..sort();
//       final pont  = ((m['pontics'] as List?) ?? const []).map((e) => e.toString()).toList()..sort();
//       final parts = <String>[];
//       if (type.isNotEmpty) parts.add(type);
//       if (code.isNotEmpty) parts.add('code:$code');
//       if (teeth.isNotEmpty) parts.add('teeth:${teeth.join(",")}');
//       if (abut.isNotEmpty)  parts.add('abut:${abut.join(",")}');
//       if (pont.isNotEmpty)  parts.add('pontic:${pont.join(",")}');
//       if (parts.isNotEmpty) spansLines.add(parts.join(' · '));
//     }
//
//     // ---------- 635 요약 ----------
//     String _build635Line(Map<String, dynamic> toothJson) {
//       const surfKeys = ['O','M','D','L','B'];
//       const globalKeys = ['bite','crown','root','status','position'];
//       final out = <String>[];
//
//       final surface = (toothJson['surface'] as Map?)?.cast<String, dynamic>() ?? const {};
//       for (final s in surfKeys) {
//         final map = (surface[s] as Map?)?.cast<String, dynamic>() ?? const {};
//         final fillings = (map['fillings'] as List?)?.map((e) => e.toString()).toList() ?? const <String>[];
//         final perio    = (map['periodontium'] as List?)?.map((e) => e.toString()).toList() ?? const <String>[];
//         if (fillings.isNotEmpty) out.add('${fillings.join(",")}($s)');
//         if (perio.isNotEmpty)    out.add('${perio.join(",")}($s)');
//       }
//       final global = (toothJson['global'] as Map?)?.cast<String, dynamic>() ?? const {};
//       for (final g in globalKeys) {
//         final list = (global[g] as List?)?.map((e) => e.toString()).toList() ?? const <String>[];
//         if (list.isNotEmpty) out.add(list.join(','));
//       }
//       final note = (toothJson['toothNote'] ?? '').toString().trim();
//       if (note.isNotEmpty) out.add('note:$note');
//       return out.join(' · ');
//     }
//
//     final spec635 = (data['spec635'] as Map?)?.cast<String, dynamic>() ?? const {};
//     final specLines = <String>[];
//     final specKeys = spec635.keys.toList()..sort((a,b) => int.parse(a).compareTo(int.parse(b)));
//     for (final k in specKeys) {
//       final line = _build635Line((spec635[k] as Map).cast<String, dynamic>());
//       if (line.trim().isNotEmpty) specLines.add('Tooth $k · $line');
//     }
//
//     // ---------- 업로드된 이미지 ----------
//     final uploadedUrls = (data['uploadedFiles'] as List?)?.cast<String>() ?? const <String>[];
//     final urlsForPdf = uploadedUrls.take(48).toList(); // 과도한 페이지 증가 방지
//
//     // 네트워크 이미지 미리 로드
//     final images = <pw.ImageProvider>[];
//     for (final url in urlsForPdf) {
//       try {
//         final img = await networkImage(url);
//         images.add(img);
//       } catch (_) {
//         // 실패한 이미지는 스킵
//       }
//     }
//
//     // ---------- 본문 페이지 (요약 + 썸네일 그리드) ----------
//     doc.addPage(
//       pw.MultiPage(
//         theme: pw.ThemeData.withFont(
//           base: font,
//           bold: font,
//           italic: font,
//           boldItalic: font,
//         ),
//
//         pageFormat: PdfPageFormat.a4,
//         margin: const pw.EdgeInsets.fromLTRB(28, 28, 28, 36),
//         footer: (context) => pw.Container(
//           alignment: pw.Alignment.centerRight,
//           padding: const pw.EdgeInsets.only(top: 4),
//           child: pw.Text(
//             'Page ${context.pageNumber}/${context.pagesCount}   •   Generated: ${_ymd(generatedAt)}',
//             style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
//           ),
//         ),
//         build: (ctx) => [
//           pw.Header(
//             level: 0,
//             child: pw.Text('Final Review', style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold)),
//           ),
//           pw.Text('기록 검토 PDF', style: const pw.TextStyle(fontSize: 12)),
//           pw.SizedBox(height: 12),
//
//           pw.Text('📍 기본 정보', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//           _line('기록 유형', recordLabel),
//           _line('재난 장소', (data['placeOfDisaster'] ?? (data['placeForUi'] ?? '')).toString()),
//           _line('재난 유형', (data['natureOfDisaster'] ?? (data['natureForUi'] ?? '')).toString()),
//           _line(idLabel, idValue.toString().trim().isEmpty ? '없음' : idValue.toString().trim()),
//           _line('재난 날짜', _dateStrFromIso((data['dateOfDisaster'] ?? data['dateOfDisasterIso'])?.toString())),
//           _line('성별', (data['gender'] ?? '').toString()),
//           pw.SizedBox(height: 8),
//
//           pw.Divider(),
//           pw.Text('🦷 구강 정보', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//           _line('640 기타 소견', (data['otherFindings'] ?? '').toString()),
//           _line('645 치열 유형', (data['dentitionType'] ?? '').toString()),
//           _line('647 나이 추정', '${data['ageMin'] ?? '?'} ~ ${data['ageMax'] ?? '?'}'),
//           _line('650 품질 확인', '서명: ${(data['qualityCheckSignature'] ?? '').toString()}, 날짜: ${_dateStrFromIso(data['qualityCheckDate']?.toString())}'),
//           pw.SizedBox(height: 8),
//
//           pw.Divider(),
//           pw.Text('🏷️ Interpol 코드 선택', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//           pw.SizedBox(height: 6),
//           pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
//             if ((data['codeSelectionCompact'] ?? data['currentSelectionCompact']) != null)
//               pw.Text('축소뷰: ${(data['codeSelectionCompact'] ?? data['currentSelectionCompact']).toString()}'),
//             if ((data['codeSelectionZoom'] ?? data['currentSelectionZoom']) != null)
//               pw.Text('확대뷰: ${(data['codeSelectionZoom'] ?? data['currentSelectionZoom']).toString()}'),
//             if ((data['codeSelectionCompact'] ?? data['currentSelectionCompact']) == null &&
//                 (data['codeSelectionZoom'] ?? data['currentSelectionZoom']) == null)
//               pw.Text('선택 없음'),
//           ]),
//           pw.SizedBox(height: 8),
//
//           pw.Divider(),
//           pw.Text('🧩 Odontogram Spans', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//           pw.SizedBox(height: 6),
//           _bulletSection('Spans', spansLines),
//
//           pw.Divider(),
//           pw.Text('🧾 635 Specific 요약', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//           pw.SizedBox(height: 6),
//           _bulletSection('Teeth', specLines),
//
//           pw.Divider(),
//           pw.Text('🦷 Materials Available', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//           pw.SizedBox(height: 6),
//           pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
//             pw.Text('상악(치아 있음): ${_yn(data['upperJawWithTeeth'])}'),
//             pw.Text('하악(치아 있음): ${_yn(data['lowerJawWithTeeth'])}'),
//             pw.Text('상악(치아 없음): ${_yn(data['upperJawWithoutTeeth'])}'),
//             pw.Text('하악(치아 없음): ${_yn(data['lowerJawWithoutTeeth'])}'),
//             pw.Text('조각 있음: ${_yn(data['fragments'])}'),
//             pw.Text('치아만: ${(data['teethOnly'] ?? '').toString()}'),
//             pw.Text('기타: ${(data['otherMaterials'] ?? '').toString()}'),
//           ]),
//           pw.SizedBox(height: 8),
//
//           pw.Divider(),
//           pw.Text('🩻 Radiographs', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//           pw.SizedBox(height: 6),
//           pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
//             pw.Text('PA: Digital-${_yn(data['paDigital'])}, Non-Digital-${_yn(data['paNonDigital'])}'),
//             pw.Text('BW: Digital-${_yn(data['bwDigital'])}, Non-Digital-${_yn(data['bwNonDigital'])}'),
//             pw.Text('OPG: Digital-${_yn(data['opgDigital'])}, Non-Digital-${_yn(data['opgNonDigital'])}'),
//             pw.Text('CT: Digital-${_yn(data['ctDigital'])}, Non-Digital-${_yn(data['ctNonDigital'])}'),
//             pw.Text('Other: Digital-${_yn(data['otherDigital'])}, Non-Digital-${_yn(data['otherNonDigital'])}'),
//             pw.Text('Photographs: Digital-${_yn(data['photographsDigital'])}, Non-Digital-${_yn(data['photographsNonDigital'])}'),
//             pw.Text('기타 영상 자료: ${(data['otherRadiographs'] ?? '').toString()}'),
//           ]),
//           pw.SizedBox(height: 10),
//
//           pw.Divider(),
//           pw.Text('📂 업로드된 파일 (썸네일: 클릭하면 원본 페이지로 이동)', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//           pw.SizedBox(height: 6),
//
//           // 썸네일 그리드 (내부 링크)
//           if (images.isEmpty) pw.Text('파일 없음')
//           else pw.Wrap(
//             spacing: 6,
//             runSpacing: 6,
//             children: [
//               for (int i = 0; i < images.length; i++)
//                 pw.Link(
//                   destination: 'img_$i', // 아래 원본 섹션의 앵커로 점프
//                   child: pw.Container(
//                     width: 90,
//                     height: 90,
//                     decoration: pw.BoxDecoration(
//                       border: pw.Border.all(color: PdfColors.grey300, width: 0.5),
//                     ),
//                     child: pw.FittedBox(
//                       fit: pw.BoxFit.cover,
//                       child: pw.Image(images[i]),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//
//     for (int i = 0; i < images.length; i++) {
//       doc.addPage(
//         pw.Page(
//           pageFormat: PdfPageFormat.a4,
//           margin: const pw.EdgeInsets.fromLTRB(28, 28, 28, 36),
//           build: (context) => pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.stretch,
//             children: [
//               // 앵커: 썸네일에서 여기로 점프
//               pw.Anchor(
//                 name: 'img_$i',
//                 child: pw.Text(
//                   '원본 이미지 ${i + 1}',
//                   style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
//                 ),
//               ),
//               pw.SizedBox(height: 8),
//
//               // 본문(이미지)
//               pw.Expanded(
//                 child: pw.Container(
//                   decoration: pw.BoxDecoration(
//                     border: pw.Border.all(color: PdfColors.grey300, width: 0.5),
//                   ),
//                   child: pw.FittedBox(
//                     fit: pw.BoxFit.contain, // ✅ 비율 유지
//                     child: pw.Image(images[i]),
//                   ),
//                 ),
//               ),
//
//               // ✅ 하단 푸터(수동)
//               pw.SizedBox(height: 6),
//               pw.Align(
//                 alignment: pw.Alignment.centerRight,
//                 child: pw.Text(
//                   'Generated: ${_ymd(generatedAt)}',
//                   style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
//                 ),
//               ),
//             ],
//           ),
//           // ❌ footer: (...)  <-- 이 줄은 제거!
//         ),
//       );
//     }
//
//
//     return doc.save();
//   }
// }

// lib/services/pdf_service.dart
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart'; // networkImage

/// SAF로 안드로이드 Downloads에 저장. (iOS/웹 등은 공유로 우회)
Future<void> savePdfToDownloads(Uint8List bytes, String filename) async {
  if (Platform.isAndroid) {
    // 1) 임시 파일로 저장
    final tempDir = await getTemporaryDirectory();
    final tempPath = '${tempDir.path}/$filename';
    final tempFile = File(tempPath);
    await tempFile.writeAsBytes(bytes);

    // 2) SAF 저장 다이얼로그 (Downloads 제안)
    final params = SaveFileDialogParams(
      sourceFilePath: tempPath,
      fileName: filename,
    );
    final resultPath = await FlutterFileDialog.saveFile(params: params);
    if (resultPath == null) {
      throw Exception('사용자가 저장을 취소했습니다.');
    }
  } else {
    // 다른 플랫폼은 공유/별도 분기 사용 권장
    throw UnsupportedError('Android 외 플랫폼은 SAF 저장을 지원하지 않습니다.');
  }
}

class PdfService {
  // ---------- 유틸 ----------
  static String _ymd(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static String _dateStrFromIso(String? iso) {
    if (iso == null || iso.isEmpty) return '없음';
    return iso.split('T').first;
    // Firestore Timestamp라면 toDate().toIso8601String() 형태로 넘겨주세요.
  }

  static String _yn(dynamic v) => v == true ? '예' : (v == false ? '아니오' : '');

  static pw.Widget _line(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: 140,
            child: pw.Text(label, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ),
          pw.Expanded(child: pw.Text(value)),
        ],
      ),
    );
  }

  static pw.Widget _bulletSection(String title, List<String> items) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 6),
        if (items.isEmpty)
          pw.Text('없음')
        else
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: items.map((e) => pw.Bullet(text: e)).toList(),
          ),
        pw.SizedBox(height: 8),
      ],
    );
  }

  static String buildFileName(Map<String, dynamic> data, {DateTime? when, bool addTimestamp = false}) {
    final isPm = data['recordType'] == 'PM';
    final rawNo = isPm ? (data['pmNumber'] ?? '') : (data['amNumber'] ?? '');
    final label = isPm ? 'PM' : 'AM';
    final date = _ymd(when ?? DateTime.now());

    // 안전화: 파일시스템에 문제되는 문자들 모두 언더바로 치환
    String sanitize(String s) {
      var out = s.trim();
      // 허용: 영문/숫자/하이픈/언더바/마침표; 나머지 전부 '_'로
      out = out.replaceAll(RegExp(r'[^A-Za-z0-9\-_\.]'), '_');
      // 연속된 '_'는 하나로 줄이기 (선택적)
      out = out.replaceAll(RegExp(r'_+'), '_');
      // 너무 길면 잘라냄 (선택적)
      if (out.length > 64) out = out.substring(0, 64);
      return out;
    }

    final noStr = rawNo.toString();
    final safeNo = noStr.isEmpty ? 'NO' : sanitize(noStr);

    final base = '${label}_${safeNo}_$date.pdf';
    if (addTimestamp) {
      final ts = DateTime.now().millisecondsSinceEpoch;
      return '${label}_${safeNo}_${date}_$ts.pdf';
    }
    return base;
  }


  // /// 최종검토 PDF 생성 (썸네일 클릭 → 원본 이미지 페이지 이동, 푸터 포함, 한글 폰트)
  // static Future<Uint8List> buildFinalReviewPdf(Map<String, dynamic> data, {
  //   bool includeContactSheet = false,
  //   int contactSheetMax = 12,
  // }) async {
  //   // ----- 한글 폰트 로드 + 테마 -----
  //   final ttf = await rootBundle.load("assets/fonts/NotoSansKR-Regular.ttf");
  //   final font = pw.Font.ttf(ttf);
  //   final krTheme = pw.ThemeData.withFont(
  //     base: font,
  //     bold: font,
  //     italic: font,
  //     boldItalic: font,
  //   );
  //
  //   final doc = pw.Document();
  //   final generatedAt = DateTime.now();
  //
  //   final isPm = data['recordType'] == 'PM';
  //   final recordLabel = isPm ? 'Post-mortem (PM)' : 'Ante-mortem (AM)';
  //   final idLabel = isPm ? 'PM 번호' : 'AM 번호';
  //   final idValue = isPm ? (data['pmNumber'] ?? '') : (data['amNumber'] ?? '');
  //
  //   // ---------- Odontogram spans ----------
  //   final spans = (data['spans'] as List?) ?? const [];
  //   final spansLines = <String>[];
  //   for (final raw in spans) {
  //     final m = (raw as Map).map((k, v) => MapEntry(k.toString(), v));
  //     final type = (m['type'] ?? '').toString();
  //     final code = (m['code'] ?? '').toString();
  //     final teeth = ((m['teeth'] as List?) ?? const []).map((e) => e.toString()).toList()..sort();
  //     final abut  = ((m['abutments'] as List?) ?? const []).map((e) => e.toString()).toList()..sort();
  //     final pont  = ((m['pontics'] as List?) ?? const []).map((e) => e.toString()).toList()..sort();
  //     final parts = <String>[];
  //     if (type.isNotEmpty) parts.add(type);
  //     if (code.isNotEmpty) parts.add('code:$code');
  //     if (teeth.isNotEmpty) parts.add('teeth:${teeth.join(",")}');
  //     if (abut.isNotEmpty)  parts.add('abut:${abut.join(",")}');
  //     if (pont.isNotEmpty)  parts.add('pontic:${pont.join(",")}');
  //     if (parts.isNotEmpty) spansLines.add(parts.join(' · '));
  //   }
  //
  //   // ---------- 635 요약 ----------
  //   String _build635Line(Map<String, dynamic> toothJson) {
  //     const surfKeys = ['O','M','D','L','B'];
  //     const globalKeys = ['bite','crown','root','status','position'];
  //     final out = <String>[];
  //
  //     final surface = (toothJson['surface'] as Map?)?.cast<String, dynamic>() ?? const {};
  //     for (final s in surfKeys) {
  //       final map = (surface[s] as Map?)?.cast<String, dynamic>() ?? const {};
  //       final fillings = (map['fillings'] as List?)?.map((e) => e.toString()).toList() ?? const <String>[];
  //       final perio    = (map['periodontium'] as List?)?.map((e) => e.toString()).toList() ?? const <String>[];
  //       if (fillings.isNotEmpty) out.add('${fillings.join(",")}($s)');
  //       if (perio.isNotEmpty)    out.add('${perio.join(",")}($s)');
  //     }
  //     final global = (toothJson['global'] as Map?)?.cast<String, dynamic>() ?? const {};
  //     for (final g in globalKeys) {
  //       final list = (global[g] as List?)?.map((e) => e.toString()).toList() ?? const <String>[];
  //       if (list.isNotEmpty) out.add(list.join(','));
  //     }
  //     final note = (toothJson['toothNote'] ?? '').toString().trim();
  //     if (note.isNotEmpty) out.add('note:$note');
  //     return out.join(' · ');
  //   }
  //
  //   final spec635 = (data['spec635'] as Map?)?.cast<String, dynamic>() ?? const {};
  //   final specLines = <String>[];
  //   final specKeys = spec635.keys.toList()..sort((a,b) => int.parse(a).compareTo(int.parse(b)));
  //   for (final k in specKeys) {
  //     final line = _build635Line((spec635[k] as Map).cast<String, dynamic>());
  //     if (line.trim().isNotEmpty) specLines.add('Tooth $k · $line');
  //   }
  //
  //   // ---------- 업로드된 이미지 ----------
  //   final uploadedUrls = (data['uploadedFiles'] as List?)?.cast<String>() ?? const <String>[];
  //   final urlsForPdf = uploadedUrls.take(48).toList(); // 페이지 급증 방지
  //
  //   // 네트워크 이미지 미리 로드(실패는 스킵)
  //   final images = <pw.ImageProvider>[];
  //   for (final url in urlsForPdf) {
  //     try {
  //       final img = await networkImage(url);
  //       images.add(img);
  //     } catch (_) {}
  //   }
  //
  //   // ---------- 본문 페이지 (요약 + 썸네일 그리드) ----------
  //   doc.addPage(
  //     pw.MultiPage(
  //       theme: krTheme,
  //       pageFormat: PdfPageFormat.a4,
  //       margin: const pw.EdgeInsets.fromLTRB(28, 28, 28, 36),
  //       footer: (context) => pw.Container(
  //         alignment: pw.Alignment.centerRight,
  //         padding: const pw.EdgeInsets.only(top: 4),
  //         child: pw.Text(
  //           'Page ${context.pageNumber}/${context.pagesCount}   •   Generated: ${_ymd(generatedAt)}',
  //           style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
  //         ),
  //       ),
  //       build: (ctx) => [
  //         pw.Header(
  //           level: 0,
  //           child: pw.Text('Final Review', style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold)),
  //         ),
  //         pw.Text('기록 검토 PDF', style: const pw.TextStyle(fontSize: 12)),
  //         pw.SizedBox(height: 12),
  //
  //         pw.Text('기본 정보', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //         _line('기록 유형', recordLabel),
  //         _line('재난 장소', (data['placeOfDisaster'] ?? (data['placeForUi'] ?? '')).toString()),
  //         _line('재난 유형', (data['natureOfDisaster'] ?? (data['natureForUi'] ?? '')).toString()),
  //         _line(idLabel, idValue.toString().trim().isEmpty ? '없음' : idValue.toString().trim()),
  //         _line('재난 날짜', _dateStrFromIso((data['dateOfDisaster'] ?? data['dateOfDisasterIso'])?.toString())),
  //         _line('성별', (data['gender'] ?? '').toString()),
  //         pw.SizedBox(height: 8),
  //
  //         pw.Divider(),
  //         pw.Text('구강 정보', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //         _line('640 기타 소견', (data['otherFindings'] ?? '').toString()),
  //         _line('645 치열 유형', (data['dentitionType'] ?? '').toString()),
  //         _line('647 나이 추정', '${data['ageMin'] ?? '?'} ~ ${data['ageMax'] ?? '?'}'),
  //         _line('650 품질 확인', '서명: ${(data['qualityCheckSignature'] ?? '').toString()}, 날짜: ${_dateStrFromIso(data['qualityCheckDate']?.toString())}'),
  //         pw.SizedBox(height: 8),
  //
  //         pw.Divider(),
  //         pw.Text('Interpol 코드 선택', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //         pw.SizedBox(height: 6),
  //         pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
  //           if ((data['codeSelectionCompact'] ?? data['currentSelectionCompact']) != null)
  //             pw.Text('축소뷰: ${(data['codeSelectionCompact'] ?? data['currentSelectionCompact']).toString()}'),
  //           if ((data['codeSelectionZoom'] ?? data['currentSelectionZoom']) != null)
  //             pw.Text('확대뷰: ${(data['codeSelectionZoom'] ?? data['currentSelectionZoom']).toString()}'),
  //           if ((data['codeSelectionCompact'] ?? data['currentSelectionCompact']) == null &&
  //               (data['codeSelectionZoom'] ?? data['currentSelectionZoom']) == null)
  //             pw.Text('선택 없음'),
  //         ]),
  //         pw.SizedBox(height: 8),
  //
  //         pw.Divider(),
  //         pw.Text('Odontogram Spans', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //         pw.SizedBox(height: 6),
  //         _bulletSection('Spans', spansLines),
  //
  //         pw.Divider(),
  //         pw.Text('635 Specific 요약', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //         pw.SizedBox(height: 6),
  //         _bulletSection('Teeth', specLines),
  //
  //         pw.Divider(),
  //         pw.Text('Materials Available', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //         pw.SizedBox(height: 6),
  //         pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
  //           pw.Text('상악(치아 있음): ${_yn(data['upperJawWithTeeth'])}'),
  //           pw.Text('하악(치아 있음): ${_yn(data['lowerJawWithTeeth'])}'),
  //           pw.Text('상악(치아 없음): ${_yn(data['upperJawWithoutTeeth'])}'),
  //           pw.Text('하악(치아 없음): ${_yn(data['lowerJawWithoutTeeth'])}'),
  //           pw.Text('조각 있음: ${_yn(data['fragments'])}'),
  //           pw.Text('치아만: ${(data['teethOnly'] ?? '').toString()}'),
  //           pw.Text('기타: ${(data['otherMaterials'] ?? '').toString()}'),
  //         ]),
  //         pw.SizedBox(height: 8),
  //
  //         pw.Divider(),
  //         pw.Text('Radiographs', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //         pw.SizedBox(height: 6),
  //         pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
  //           pw.Text('PA: Digital-${_yn(data['paDigital'])}, Non-Digital-${_yn(data['paNonDigital'])}'),
  //           pw.Text('BW: Digital-${_yn(data['bwDigital'])}, Non-Digital-${_yn(data['bwNonDigital'])}'),
  //           pw.Text('OPG: Digital-${_yn(data['opgDigital'])}, Non-Digital-${_yn(data['opgNonDigital'])}'),
  //           pw.Text('CT: Digital-${_yn(data['ctDigital'])}, Non-Digital-${_yn(data['ctNonDigital'])}'),
  //           pw.Text('Other: Digital-${_yn(data['otherDigital'])}, Non-Digital-${_yn(data['otherNonDigital'])}'),
  //           pw.Text('Photographs: Digital-${_yn(data['photographsDigital'])}, Non-Digital-${_yn(data['photographsNonDigital'])}'),
  //           pw.Text('기타 영상 자료: ${(data['otherRadiographs'] ?? '').toString()}'),
  //         ]),
  //         pw.SizedBox(height: 10),
  //
  //       widgets.addAll([
  //         pw.Divider(),
  //         pw.Text('업로드된 파일', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //         pw.SizedBox(height: 6),
  //       ])
  //
  //         if (images.isEmpty)
  //           pw.Text('파일 없음')
  //         else
  //           pw.Wrap(
  //             spacing: 6,
  //             runSpacing: 6,
  //             children: [
  //               for (int i = 0; i < images.length; i++)
  //                 pw.Link(
  //                   destination: 'img_$i',
  //                   child: pw.Container(
  //                     width: 90,
  //                     height: 90,
  //                     decoration: pw.BoxDecoration(
  //                       border: pw.Border.all(color: PdfColors.grey300, width: 0.5),
  //                     ),
  //                     child: pw.FittedBox(
  //                       fit: pw.BoxFit.cover,
  //                       child: pw.Image(images[i]),
  //                     ),
  //                   ),
  //                 ),
  //             ],
  //           ),
  //       ],
  //     ),
  //   );
  //
  //   // ---------- 원본 이미지 섹션: 각 이미지 1페이지 (비율 유지) ----------
  //   for (int i = 0; i < images.length; i++) {
  //     doc.addPage(
  //       pw.Page(
  //         pageFormat: PdfPageFormat.a4,
  //         margin: const pw.EdgeInsets.fromLTRB(28, 28, 28, 36),
  //         build: (context) => pw.Theme(
  //           data: krTheme, // ✅ Page에도 폰트 테마 적용
  //           child: pw.Column(
  //             crossAxisAlignment: pw.CrossAxisAlignment.stretch,
  //             children: [
  //               pw.Anchor(
  //                 name: 'img_$i',
  //                 child: pw.Text(
  //                   '원본 이미지 ${i + 1}',
  //                   style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
  //                 ),
  //               ),
  //               pw.SizedBox(height: 8),
  //               pw.Expanded(
  //                 child: pw.Container(
  //                   decoration: pw.BoxDecoration(
  //                     border: pw.Border.all(color: PdfColors.grey300, width: 0.5),
  //                   ),
  //                   child: pw.FittedBox(
  //                     fit: pw.BoxFit.contain,
  //                     child: pw.Image(images[i]),
  //                   ),
  //                 ),
  //               ),
  //               pw.SizedBox(height: 6),
  //               pw.Align(
  //                 alignment: pw.Alignment.centerRight,
  //                 child: pw.Text(
  //                   'Generated: ${_ymd(generatedAt)}',
  //                   style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //
  //   return doc.save();
  // }
  /// 최종검토 PDF 생성 (썸네일은 옵션)
  static Future<Uint8List> buildFinalReviewPdf(
      Map<String, dynamic> data, {
        bool includeContactSheet = false,
        int contactSheetMax = 12,
      }) async {
    // ----- 한글 폰트 로드 + 테마 -----
    final ttf = await rootBundle.load("assets/fonts/NotoSansKR-Regular.ttf");
    final font = pw.Font.ttf(ttf);
    final krTheme = pw.ThemeData.withFont(
      base: font,
      bold: font,
      italic: font,
      boldItalic: font,
    );

    final doc = pw.Document();
    final generatedAt = DateTime.now();

    final isPm = data['recordType'] == 'PM';
    final recordLabel = isPm ? 'Post-mortem (PM)' : 'Ante-mortem (AM)';
    final idLabel = isPm ? 'PM 번호' : 'AM 번호';
    final idValue = isPm ? (data['pmNumber'] ?? '') : (data['amNumber'] ?? '');

    // ---------- Odontogram spans ----------
    final spans = (data['spans'] as List?) ?? const [];
    final spansLines = <String>[];
    for (final raw in spans) {
      final m = (raw as Map).map((k, v) => MapEntry(k.toString(), v));
      final type = (m['type'] ?? '').toString();
      final code = (m['code'] ?? '').toString();
      final teeth = ((m['teeth'] as List?) ?? const []).map((e) => e.toString()).toList()..sort();
      final abut  = ((m['abutments'] as List?) ?? const []).map((e) => e.toString()).toList()..sort();
      final pont  = ((m['pontics'] as List?) ?? const []).map((e) => e.toString()).toList()..sort();
      final parts = <String>[];
      if (type.isNotEmpty) parts.add(type);
      if (code.isNotEmpty) parts.add('code:$code');
      if (teeth.isNotEmpty) parts.add('teeth:${teeth.join(",")}');
      if (abut.isNotEmpty)  parts.add('abut:${abut.join(",")}');
      if (pont.isNotEmpty)  parts.add('pontic:${pont.join(",")}');
      if (parts.isNotEmpty) spansLines.add(parts.join(' · '));
    }

    // ---------- 635 요약 ----------
    String _build635Line(Map<String, dynamic> toothJson) {
      const surfKeys = ['O','M','D','L','B'];
      const globalKeys = ['bite','crown','root','status','position'];
      final out = <String>[];

      final surface = (toothJson['surface'] as Map?)?.cast<String, dynamic>() ?? const {};
      for (final s in surfKeys) {
        final map = (surface[s] as Map?)?.cast<String, dynamic>() ?? const {};
        final fillings = (map['fillings'] as List?)?.map((e) => e.toString()).toList() ?? const <String>[];
        final perio    = (map['periodontium'] as List?)?.map((e) => e.toString()).toList() ?? const <String>[];
        if (fillings.isNotEmpty) out.add('${fillings.join(",")}($s)');
        if (perio.isNotEmpty)    out.add('${perio.join(",")}($s)');
      }
      final global = (toothJson['global'] as Map?)?.cast<String, dynamic>() ?? const {};
      for (final g in globalKeys) {
        final list = (global[g] as List?)?.map((e) => e.toString()).toList() ?? const <String>[];
        if (list.isNotEmpty) out.add(list.join(','));
      }
      final note = (toothJson['toothNote'] ?? '').toString().trim();
      if (note.isNotEmpty) out.add('note:$note');
      return out.join(' · ');
    }

    final spec635 = (data['spec635'] as Map?)?.cast<String, dynamic>() ?? const {};
    final specLines = <String>[];
    final specKeys = spec635.keys.toList()..sort((a,b) => int.parse(a).compareTo(int.parse(b)));
    for (final k in specKeys) {
      final line = _build635Line((spec635[k] as Map).cast<String, dynamic>());
      if (line.trim().isNotEmpty) specLines.add('Tooth $k · $line');
    }

    // ---------- 업로드된 이미지 ----------
    final uploadedUrls = (data['uploadedFiles'] as List?)?.cast<String>() ?? const <String>[];
    final urlsForPdf = uploadedUrls.take(48).toList(); // 페이지 급증 방지

    // 네트워크 이미지 미리 로드(실패는 스킵)
    final images = <pw.ImageProvider>[];
    for (final url in urlsForPdf) {
      try {
        final img = await networkImage(url);
        images.add(img);
      } catch (_) {}
    }

    // 썸네일 개수(옵션)
    final int thumbCount = images.length > contactSheetMax ? contactSheetMax : images.length;

    // ---------- 본문 페이지 (요약 + 업로드 파일 섹션) ----------
    doc.addPage(
      pw.MultiPage(
        theme: krTheme,
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(28, 28, 28, 36),
        footer: (context) => pw.Container(
          alignment: pw.Alignment.centerRight,
          padding: const pw.EdgeInsets.only(top: 4),
          child: pw.Text(
            'Page ${context.pageNumber}/${context.pagesCount}   •   Generated: ${_ymd(generatedAt)}',
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
          ),
        ),
        build: (ctx) => [
          pw.Header(
            level: 0,
            child: pw.Text('Final Review', style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Text('기록 검토 PDF', style: const pw.TextStyle(fontSize: 12)),
          pw.SizedBox(height: 12),

          pw.Text('기본 정보', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          _line('기록 유형', recordLabel),
          _line('재난 장소', (data['placeOfDisaster'] ?? (data['placeForUi'] ?? '')).toString()),
          _line('재난 유형', (data['natureOfDisaster'] ?? (data['natureForUi'] ?? '')).toString()),
          _line(idLabel, idValue.toString().trim().isEmpty ? '없음' : idValue.toString().trim()),
          _line('재난 날짜', _dateStrFromIso((data['dateOfDisaster'] ?? data['dateOfDisasterIso'])?.toString())),
          _line('성별', (data['gender'] ?? '').toString()),
          pw.SizedBox(height: 8),

          pw.Divider(),
          pw.Text('구강 정보', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          _line('640 기타 소견', (data['otherFindings'] ?? '').toString()),
          _line('645 치열 유형', (data['dentitionType'] ?? '').toString()),
          _line('647 나이 추정', '${data['ageMin'] ?? '?'} ~ ${data['ageMax'] ?? '?'}'),
          _line('650 품질 확인', '서명: ${(data['qualityCheckSignature'] ?? '').toString()}, 날짜: ${_dateStrFromIso(data['qualityCheckDate']?.toString())}'),
          pw.SizedBox(height: 8),

          pw.Divider(),
          pw.Text('Interpol 코드 선택', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 6),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            if ((data['codeSelectionCompact'] ?? data['currentSelectionCompact']) != null)
              pw.Text('축소뷰: ${(data['codeSelectionCompact'] ?? data['currentSelectionCompact']).toString()}'),
            if ((data['codeSelectionZoom'] ?? data['currentSelectionZoom']) != null)
              pw.Text('확대뷰: ${(data['codeSelectionZoom'] ?? data['currentSelectionZoom']).toString()}'),
            if ((data['codeSelectionCompact'] ?? data['currentSelectionCompact']) == null &&
                (data['codeSelectionZoom'] ?? data['currentSelectionZoom']) == null)
              pw.Text('선택 없음'),
          ]),
          pw.SizedBox(height: 8),

          pw.Divider(),
          pw.Text('Odontogram Spans', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 6),
          _bulletSection('Spans', spansLines),

          pw.Divider(),
          pw.Text('635 Specific 요약', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 6),
          _bulletSection('Teeth', specLines),

          pw.Divider(),
          pw.Text('Materials Available', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 6),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Text('상악(치아 있음): ${_yn(data['upperJawWithTeeth'])}'),
            pw.Text('하악(치아 있음): ${_yn(data['lowerJawWithTeeth'])}'),
            pw.Text('상악(치아 없음): ${_yn(data['upperJawWithoutTeeth'])}'),
            pw.Text('하악(치아 없음): ${_yn(data['lowerJawWithoutTeeth'])}'),
            pw.Text('조각 있음: ${_yn(data['fragments'])}'),
            pw.Text('치아만: ${(data['teethOnly'] ?? '').toString()}'),
            pw.Text('기타: ${(data['otherMaterials'] ?? '').toString()}'),
          ]),
          pw.SizedBox(height: 8),

          pw.Divider(),
          pw.Text('Radiographs', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 6),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Text('PA: Digital-${_yn(data['paDigital'])}, Non-Digital-${_yn(data['paNonDigital'])}'),
            pw.Text('BW: Digital-${_yn(data['bwDigital'])}, Non-Digital-${_yn(data['bwNonDigital'])}'),
            pw.Text('OPG: Digital-${_yn(data['opgDigital'])}, Non-Digital-${_yn(data['opgNonDigital'])}'),
            pw.Text('CT: Digital-${_yn(data['ctDigital'])}, Non-Digital-${_yn(data['ctNonDigital'])}'),
            pw.Text('Other: Digital-${_yn(data['otherDigital'])}, Non-Digital-${_yn(data['otherNonDigital'])}'),
            pw.Text('Photographs: Digital-${_yn(data['photographsDigital'])}, Non-Digital-${_yn(data['photographsNonDigital'])}'),
            pw.Text('기타 영상 자료: ${(data['otherRadiographs'] ?? '').toString()}'),
          ]),
          pw.SizedBox(height: 10),

          // ========== 업로드된 파일 섹션 (컬렉션-if 사용) ==========
          pw.Divider(),
          pw.Text('업로드된 파일', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 6),

          if (images.isEmpty)
            pw.Text('파일 없음')
          else ...[
            // 텍스트 TOC (항상 가볍게 제공)
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < images.length; i++)
                  pw.Link(
                    destination: 'img_$i',
                    child: pw.Text(
                      '원본 이미지 ${i + 1}',
                      style: const pw.TextStyle(decoration: pw.TextDecoration.underline),
                    ),
                  ),
              ],
            ),
            pw.SizedBox(height: 8),

            // 옵션: 라이트 컨택트 시트(썸네일)
            if (includeContactSheet && thumbCount > 0) ...[
              pw.Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (int i = 0; i < thumbCount; i++)
                    pw.Link(
                      destination: 'img_$i',
                      child: pw.Container(
                        width: 70,
                        height: 70,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: PdfColors.grey300, width: 0.5),
                        ),
                        child: pw.FittedBox(
                          fit: pw.BoxFit.cover,
                          child: pw.Image(images[i]),
                        ),
                      ),
                    ),
                ],
              ),
              if (images.length > thumbCount)
                pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 4),
                  child: pw.Text('… 외 ${images.length - thumbCount}개 (부록에서 확인)'),
                ),
            ],
          ],
        ],
      ),
    );

    // ---------- 원본 이미지 섹션: 각 이미지 1페이지 (비율 유지) ----------
    for (int i = 0; i < images.length; i++) {
      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.fromLTRB(28, 28, 28, 36),
          build: (context) => pw.Theme(
            data: krTheme, // ✅ Page에도 폰트 테마 적용
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Anchor(
                  name: 'img_$i',
                  child: pw.Text(
                    '원본 이미지 ${i + 1}',
                    style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Expanded(
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.grey300, width: 0.5),
                    ),
                    child: pw.FittedBox(
                      fit: pw.BoxFit.contain,
                      child: pw.Image(images[i]),
                    ),
                  ),
                ),
                pw.SizedBox(height: 6),
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    'Generated: ${_ymd(generatedAt)}',
                    style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return doc.save();
  }
}
