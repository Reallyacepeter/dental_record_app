// import 'package:flutter/material.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
//
// class FinalReviewScreenReadOnly extends StatelessWidget {
//   final Map<String, dynamic> data;
//
//   const FinalReviewScreenReadOnly({super.key, required this.data});
//
//   String getDate(String? isoString) {
//     if (isoString == null) return "없음";
//     return isoString.split("T")[0];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("상세 보기"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             const Text("📍 기본 정보", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("재난 장소: ${data['placeOfDisaster'] ?? ''}"),
//             Text("재난 유형: ${data['natureOfDisaster'] ?? ''}"),
//             Text("PM 번호: ${data['pmNumber'] ?? ''}"),
//             Text("재난 날짜: ${getDate(data['dateOfDisaster'])}"),
//             Text("성별: ${data['gender'] ?? ''}"),
//             const Divider(),
//
//             const Text("🦷 구강 정보", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("640: 기타 소견 - ${data['otherFindings'] ?? ''}"),
//             Text("645: 치열 유형 - ${data['dentitionType'] ?? ''}"),
//             Text("647: 나이 추정 - ${data['ageMin'] ?? '?'} ~ ${data['ageMax'] ?? '?'}"),
//             Text("650: 품질 확인 - 서명: ${data['qualityCheckSignature'] ?? ''}, 날짜: ${getDate(data['qualityCheckDate'])}"),
//             const Divider(),
//
//             const Text("🦷 Materials Available", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("상악 (치아 있음): ${data['upperJawWithTeeth'] ?? false}"),
//             Text("하악 (치아 있음): ${data['lowerJawWithTeeth'] ?? false}"),
//             Text("상악 (치아 없음): ${data['upperJawWithoutTeeth'] ?? false}"),
//             Text("하악 (치아 없음): ${data['lowerJawWithoutTeeth'] ?? false}"),
//             Text("조각 있음: ${data['fragments'] ?? false}"),
//             Text("치아만: ${data['teethOnly'] ?? ''}"),
//             Text("기타: ${data['otherMaterials'] ?? ''}"),
//             const Divider(),
//
//             const Text("🩻 Radiographs", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("PA: Digital - ${data['paDigital']}, Non-Digital - ${data['paNonDigital']}"),
//             Text("BW: Digital - ${data['bwDigital']}, Non-Digital - ${data['bwNonDigital']}"),
//             Text("OPG: Digital - ${data['opgDigital']}, Non-Digital - ${data['opgNonDigital']}"),
//             Text("CT: Digital - ${data['ctDigital']}, Non-Digital - ${data['ctNonDigital']}"),
//             Text("Other: Digital - ${data['otherDigital']}, Non-Digital - ${data['otherNonDigital']}"),
//             Text("Photographs: Digital - ${data['photographsDigital']}, Non-Digital - ${data['photographsNonDigital']}"),
//             Text("기타 영상 자료: ${data['otherRadiographs'] ?? ''}"),
//             const Divider(),
//
//             Text("업로드 파일 수: ${(data['uploadedFiles'] as List?)?.length ?? 0}"),
//             const Divider(),
//
//             const Text("💀 턱 상태 및 기타", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("턱 상태: ${data['conditionOfJaws'] ?? ''}"),
//             Text("기타 세부 사항: ${data['otherDetails'] ?? ''}"),
//             const Divider(),
//
//             const Text("🦷 FDI 치아 정보", style: TextStyle(fontWeight: FontWeight.bold)),
//             ...((data['fdiToothData'] as Map?)?.entries.map((entry) {
//               return Text("Tooth ${entry.key}: ${(entry.value as Map)['detail'] ?? ''}");
//             }) ?? [const Text("없음")]),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(currentIndex: 1),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
// import 'package:photo_view/photo_view.dart';
// //
// //
// // class FinalReviewScreenReadOnly extends StatelessWidget {
// //   final Map<String, dynamic> data;
// //
// //   const FinalReviewScreenReadOnly({super.key, required this.data});
// //
// //   String getDate(String? isoString) {
// //     if (isoString == null) return "없음";
// //     return isoString.split("T")[0];
// //   }
// //
// //   String boolToText(dynamic val) => val == true ? '예' : '아니오';
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final uploadedFiles = (data['uploadedFiles'] as List?) ?? [];
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("상세 보기"),
// //         automaticallyImplyLeading: false, // ✅ 상단 뒤로가기 버튼 제거
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: ListView(
// //           children: [
// //             const Text("📍 기본 정보", style: TextStyle(fontWeight: FontWeight.bold)),
// //             Text("재난 장소: ${data['placeOfDisaster'] ?? ''}"),
// //             Text("재난 유형: ${data['natureOfDisaster'] ?? ''}"),
// //             Text("PM 번호: ${data['pmNumber'] ?? ''}"),
// //             Text("재난 날짜: ${getDate(data['dateOfDisaster'])}"),
// //             Text("성별: ${data['gender'] ?? ''}"),
// //             const Divider(),
// //
// //             const Text("🦷 구강 정보", style: TextStyle(fontWeight: FontWeight.bold)),
// //             Text("640: 기타 소견 - ${data['otherFindings'] ?? ''}"),
// //             Text("645: 치열 유형 - ${data['dentitionType'] ?? ''}"),
// //             Text("647: 나이 추정 - ${data['ageMin'] ?? '?'} ~ ${data['ageMax'] ?? '?'}"),
// //             Text("650: 품질 확인 - 서명: ${data['qualityCheckSignature'] ?? ''}, 날짜: ${getDate(data['qualityCheckDate'])}"),
// //             const Divider(),
// //
// //             const Text("🦷 Materials Available", style: TextStyle(fontWeight: FontWeight.bold)),
// //             Text("상악 (치아 있음): ${boolToText(data['upperJawWithTeeth'])}"),
// //             Text("하악 (치아 있음): ${boolToText(data['lowerJawWithTeeth'])}"),
// //             Text("상악 (치아 없음): ${boolToText(data['upperJawWithoutTeeth'])}"),
// //             Text("하악 (치아 없음): ${boolToText(data['lowerJawWithoutTeeth'])}"),
// //             Text("조각 있음: ${boolToText(data['fragments'])}"),
// //             Text("치아만: ${data['teethOnly'] ?? ''}"),
// //             Text("기타: ${data['otherMaterials'] ?? ''}"),
// //             const Divider(),
// //
// //             const Text("🩻 Radiographs", style: TextStyle(fontWeight: FontWeight.bold)),
// //             Text("PA: Digital - ${boolToText(data['paDigital'])}, Non-Digital - ${boolToText(data['paNonDigital'])}"),
// //             Text("BW: Digital - ${boolToText(data['bwDigital'])}, Non-Digital - ${boolToText(data['bwNonDigital'])}"),
// //             Text("OPG: Digital - ${boolToText(data['opgDigital'])}, Non-Digital - ${boolToText(data['opgNonDigital'])}"),
// //             Text("CT: Digital - ${boolToText(data['ctDigital'])}, Non-Digital - ${boolToText(data['ctNonDigital'])}"),
// //             Text("Other: Digital - ${boolToText(data['otherDigital'])}, Non-Digital - ${boolToText(data['otherNonDigital'])}"),
// //             Text("Photographs: Digital - ${boolToText(data['photographsDigital'])}, Non-Digital - ${boolToText(data['photographsNonDigital'])}"),
// //             Text("기타 영상 자료: ${data['otherRadiographs'] ?? ''}"),
// //             const Divider(),
// //
// //             const Text("📂 업로드된 파일", style: TextStyle(fontWeight: FontWeight.bold)),
// //             if (uploadedFiles.isEmpty)
// //               const Text("파일 없음")
// //             else
// //               // ...uploadedFiles.map((url) => InkWell(
// //               //   onTap: () async {
// //               //     final uri = Uri.parse(url);
// //               //     if (await canLaunchUrl(uri)) {
// //               //       await launchUrl(uri, mode: LaunchMode.externalApplication);
// //               //     } else {
// //               //       ScaffoldMessenger.of(context).showSnackBar(
// //               //         const SnackBar(content: Text("파일 열기 실패")),
// //               //       );
// //               //     }
// //               //   },
// //               //   child: Padding(
// //               //     padding: const EdgeInsets.symmetric(vertical: 4.0),
// //               //     child: Text(url, style: const TextStyle(color: Colors.blue)),
// //               //   ),
// //               // )),
// //               ...uploadedFiles.map((url) => InkWell(
// //                 onTap: () => _openImage(context, url),
// //                 child: Padding(
// //                   padding: const EdgeInsets.symmetric(vertical: 4.0),
// //                   child: Text(url, style: const TextStyle(color: Colors.blue)),
// //                 ),
// //               )),
// //             const Divider(),
// //
// //             const Text("💀 턱 상태 및 기타", style: TextStyle(fontWeight: FontWeight.bold)),
// //             Text("턱 상태: ${data['conditionOfJaws'] ?? ''}"),
// //             Text("기타 세부 사항: ${data['otherDetails'] ?? ''}"),
// //             const Divider(),
// //
// //             const Text("🦷 FDI 치아 정보", style: TextStyle(fontWeight: FontWeight.bold)),
// //             ...((data['fdiToothData'] as Map?)?.entries.map((entry) {
// //               return Text("Tooth ${entry.key}: ${(entry.value as Map)['detail'] ?? ''}");
// //             }) ?? [const Text("없음")]),
// //
// //             const SizedBox(height: 20),
// //
// //             // ✅ 하단 뒤로가기 버튼
// //             Center(
// //               child: ElevatedButton.icon(
// //                 icon: const Icon(Icons.arrow_back),
// //                 label: const Text("뒤로가기"),
// //                 onPressed: () => Navigator.pop(context),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //       bottomNavigationBar: CustomBottomNavBar(currentIndex: 1),
// //     );
// //   }
// //
// //   void _openImage(BuildContext context, String url) {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //         builder: (_) => Scaffold(
// //           appBar: AppBar(title: const Text('파일 보기')),
// //           body: Center(
// //             child: PhotoView(
// //               imageProvider: NetworkImage(url),
// //               errorBuilder: (context, error, stackTrace) => const Text("이미지를 불러올 수 없습니다."),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // 조회 화면용: 635 한 줄 요약 빌더(직렬화 JSON에서 바로 생성)
// const List<String> _surfKeys = ['O','M','D','L','B'];
// const List<String> _globalKeys = ['bite','crown','root','status','position'];
//
// String _build635LineFromJson(Map<String, dynamic> toothJson) {
//   final out = <String>[];
//
//   final surface = (toothJson['surface'] as Map?)?.cast<String, dynamic>() ?? const {};
//   for (final s in _surfKeys) {
//     final map = (surface[s] as Map?)?.cast<String, dynamic>() ?? const {};
//     final fillings = (map['fillings'] as List?)?.map((e) => e.toString()).toList() ?? const <String>[];
//     final perio    = (map['periodontium'] as List?)?.map((e) => e.toString()).toList() ?? const <String>[];
//     if (fillings.isNotEmpty) out.add('${fillings.join(",")}($s)');
//     if (perio.isNotEmpty)    out.add('${perio.join(",")}($s)');
//   }
//
//   final global = (toothJson['global'] as Map?)?.cast<String, dynamic>() ?? const {};
//   for (final g in _globalKeys) {
//     final list = (global[g] as List?)?.map((e) => e.toString()).toList() ?? const <String>[];
//     if (list.isNotEmpty) out.add(list.join(','));
//   }
//
//   final note = (toothJson['toothNote'] ?? '').toString().trim();
//   if (note.isNotEmpty) out.add('note:$note');
//
//   return out.join(' · ');
// }
//
// class FinalReviewScreenReadOnly extends StatelessWidget {
//   final Map<String, dynamic> data;
//
//   const FinalReviewScreenReadOnly({super.key, required this.data});
//
//   String getDate(String? isoString) {
//     if (isoString == null) return "없음";
//     return isoString.split("T")[0];
//   }
//
//   String boolToText(dynamic val) => val == true ? '예' : '아니오';
//
//   @override
//   Widget build(BuildContext context) {
//     final uploadedFiles = (data['uploadedFiles'] as List?) ?? [];
//
//     // ✅ AM/PM 구분 처리
//     final isPm = data['recordType'] == 'PM';
//     final recordLabel = isPm ? 'Post-mortem (PM)' : 'Ante-mortem (AM)';
//     final idLabel = isPm ? 'PM 번호' : 'AM 번호';
//     final idValue = isPm ? (data['pmNumber'] ?? '') : (data['amNumber'] ?? '');
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("상세 보기"),
//         automaticallyImplyLeading: false, // ✅ 상단 뒤로가기 버튼 제거
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             const Text("📍 기본 정보", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("기록 유형: $recordLabel"),
//             Text("재난 장소: ${data['placeOfDisaster'] ?? ''}"),
//             Text("재난 유형: ${data['natureOfDisaster'] ?? ''}"),
//             Text("$idLabel: ${idValue.isEmpty ? '없음' : idValue}"),
//             Text("재난 날짜: ${getDate(data['dateOfDisaster'])}"),
//             Text("성별: ${data['gender'] ?? ''}"),
//             const Divider(),
//
//             const Text("🦷 구강 정보", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("640: 기타 소견 - ${data['otherFindings'] ?? ''}"),
//             Text("645: 치열 유형 - ${data['dentitionType'] ?? ''}"),
//             Text("647: 나이 추정 - ${data['ageMin'] ?? '?'} ~ ${data['ageMax'] ?? '?'}"),
//             Text("650: 품질 확인 - 서명: ${data['qualityCheckSignature'] ?? ''}, 날짜: ${getDate(data['qualityCheckDate'])}"),
//             const Divider(),
//
//             const Text("🦷 Materials Available", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("상악 (치아 있음): ${boolToText(data['upperJawWithTeeth'])}"),
//             Text("하악 (치아 있음): ${boolToText(data['lowerJawWithTeeth'])}"),
//             Text("상악 (치아 없음): ${boolToText(data['upperJawWithoutTeeth'])}"),
//             Text("하악 (치아 없음): ${boolToText(data['lowerJawWithoutTeeth'])}"),
//             Text("조각 있음: ${boolToText(data['fragments'])}"),
//             Text("치아만: ${data['teethOnly'] ?? ''}"),
//             Text("기타: ${data['otherMaterials'] ?? ''}"),
//             const Divider(),
//
//             const Text("🩻 Radiographs", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("PA: Digital - ${boolToText(data['paDigital'])}, Non-Digital - ${boolToText(data['paNonDigital'])}"),
//             Text("BW: Digital - ${boolToText(data['bwDigital'])}, Non-Digital - ${boolToText(data['bwNonDigital'])}"),
//             Text("OPG: Digital - ${boolToText(data['opgDigital'])}, Non-Digital - ${boolToText(data['opgNonDigital'])}"),
//             Text("CT: Digital - ${boolToText(data['ctDigital'])}, Non-Digital - ${boolToText(data['ctNonDigital'])}"),
//             Text("Other: Digital - ${boolToText(data['otherDigital'])}, Non-Digital - ${boolToText(data['otherNonDigital'])}"),
//             Text("Photographs: Digital - ${boolToText(data['photographsDigital'])}, Non-Digital - ${boolToText(data['photographsNonDigital'])}"),
//             Text("기타 영상 자료: ${data['otherRadiographs'] ?? ''}"),
//             const Divider(),
//
//             // ===================== Odontogram Spans 요약 =====================
//             const Text("🧩 Odontogram Spans", style: TextStyle(fontWeight: FontWeight.bold)),
//             Builder(builder: (context) {
//               final list = (data['spans'] as List?) ?? const [];
//               if (list.isEmpty) return const Text('스팬 없음');
//               return Column(
//                 children: list.map((raw) {
//                   final sp = (raw as Map).map((k, v) => MapEntry(k.toString(), v));
//                   final type = (sp['type'] ?? '').toString();
//                   final code = (sp['code'] ?? '').toString();
//                   final teeth = ((sp['teeth'] as List?) ?? const []).map((e) => e.toString()).toList()..sort();
//                   final abut  = ((sp['abutments'] as List?) ?? const []).map((e) => e.toString()).toList()..sort();
//                   final pont  = ((sp['pontics'] as List?) ?? const []).map((e) => e.toString()).toList()..sort();
//
//                   return Card(
//                     margin: const EdgeInsets.only(top: 8),
//                     child: Padding(
//                       padding: const EdgeInsets.all(12),
//                       child: Wrap(
//                         spacing: 8, runSpacing: 6, crossAxisAlignment: WrapCrossAlignment.center,
//                         children: [
//                           Chip(label: Text(type)),
//                           if (code.isNotEmpty) Chip(label: Text('code: $code')),
//                           Chip(label: Text('teeth: ${teeth.join(", ")}')),
//                           if (abut.isNotEmpty) Chip(label: Text('abut: ${abut.join(", ")}')),
//                           if (pont.isNotEmpty) Chip(label: Text('pontic: ${pont.join(", ")}')),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               );
//             }),
//             const Divider(),
//
// // ===================== 635 Specific 요약 =====================
//             const Text("🧾 635 Specific 요약", style: TextStyle(fontWeight: FontWeight.bold)),
//             Builder(builder: (context) {
//               final spec = (data['spec635'] as Map?)?.cast<String, dynamic>() ?? const {};
//               if (spec.isEmpty) return const Text('입력 없음');
//
//               final items = <Widget>[];
//               final keys = spec.keys.toList()..sort((a, b) => int.parse(a).compareTo(int.parse(b)));
//               for (final k in keys) {
//                 final toothJson = (spec[k] as Map).map((kk, vv) => MapEntry(kk.toString(), vv));
//                 final line = _build635LineFromJson(toothJson);
//                 if (line.trim().isEmpty) continue;
//                 items.add(Padding(
//                   padding: const EdgeInsets.only(top: 6),
//                   child: Text('Tooth $k · $line'),
//                 ));
//               }
//               if (items.isEmpty) return const Text('입력 없음');
//               return Column(crossAxisAlignment: CrossAxisAlignment.start, children: items);
//             }),
//             const Divider(),
//
//             const Text("📂 업로드된 파일", style: TextStyle(fontWeight: FontWeight.bold)),
//             if (uploadedFiles.isEmpty)
//               const Text("파일 없음")
//             else
//               ...uploadedFiles.map((url) => InkWell(
//                 onTap: () => _openImage(context, url),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 4.0),
//                   child: Text(url, style: const TextStyle(color: Colors.blue)),
//                 ),
//               )),
//             const Divider(),
//
//             const Text("💀 턱 상태 및 기타", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("턱 상태: ${data['conditionOfJaws'] ?? ''}"),
//             Text("기타 세부 사항: ${data['otherDetails'] ?? ''}"),
//             const Divider(),
//
//             const Text("🦷 FDI 치아 정보", style: TextStyle(fontWeight: FontWeight.bold)),
//             ...((data['fdiToothData'] as Map?)?.entries.map((entry) {
//               return Text("Tooth ${entry.key}: ${(entry.value as Map)['detail'] ?? ''}");
//             }) ?? [const Text("없음")]),
//
//             const SizedBox(height: 20),
//
//             // ✅ 하단 뒤로가기 버튼
//             Center(
//               child: ElevatedButton.icon(
//                 icon: const Icon(Icons.arrow_back),
//                 label: const Text("뒤로가기"),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(currentIndex: 1),
//     );
//   }
//
//   void _openImage(BuildContext context, String url) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => Scaffold(
//           appBar: AppBar(title: const Text('파일 보기')),
//           body: Center(
//             child: PhotoView(
//               imageProvider: NetworkImage(url),
//               errorBuilder: (context, error, stackTrace) => const Text("이미지를 불러올 수 없습니다."),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
// import 'package:photo_view/photo_view.dart';
//
// // 조회 화면용: 635 한 줄 요약 빌더(직렬화 JSON에서 바로 생성)
// const List<String> _surfKeys = ['O','M','D','L','B'];
// const List<String> _globalKeys = ['bite','crown','root','status','position'];
//
// String _build635LineFromJson(Map<String, dynamic> toothJson) {
//   final out = <String>[];
//
//   final surface = (toothJson['surface'] as Map?)?.cast<String, dynamic>() ?? const {};
//   for (final s in _surfKeys) {
//     final map = (surface[s] as Map?)?.cast<String, dynamic>() ?? const {};
//     final fillings = (map['fillings'] as List?)?.map((e) => e.toString()).toList() ?? const <String>[];
//     final perio    = (map['periodontium'] as List?)?.map((e) => e.toString()).toList() ?? const <String>[];
//     if (fillings.isNotEmpty) out.add('${fillings.join(",")}($s)');
//     if (perio.isNotEmpty)    out.add('${perio.join(",")}($s)');
//   }
//
//   final global = (toothJson['global'] as Map?)?.cast<String, dynamic>() ?? const {};
//   for (final g in _globalKeys) {
//     final list = (global[g] as List?)?.map((e) => e.toString()).toList() ?? const <String>[];
//     if (list.isNotEmpty) out.add(list.join(','));
//   }
//
//   final note = (toothJson['toothNote'] ?? '').toString().trim();
//   if (note.isNotEmpty) out.add('note:$note');
//
//   return out.join(' · ');
// }
//
// class FinalReviewScreenReadOnly extends StatelessWidget {
//   final Map<String, dynamic> data;
//
//   const FinalReviewScreenReadOnly({super.key, required this.data});
//
//   String getDate(String? isoString) {
//     if (isoString == null) return "없음";
//     return isoString.split("T")[0];
//   }
//
//   String boolToText(dynamic val) => val == true ? '예' : '아니오';
//
//   @override
//   Widget build(BuildContext context) {
//     final uploadedFiles = (data['uploadedFiles'] as List?) ?? [];
//
//     // ✅ AM/PM 구분 처리
//     final isPm = data['recordType'] == 'PM';
//     final recordLabel = isPm ? 'Post-mortem (PM)' : 'Ante-mortem (AM)';
//     final idLabel = isPm ? 'PM 번호' : 'AM 번호';
//     final idValue = isPm ? (data['pmNumber'] ?? '') : (data['amNumber'] ?? '');
//
//     // ▼ helper: 선택 포맷팅(Map → 문자열)
//     String? _fmtSel(dynamic m) {
//       if (m is! Map) return null;
//       final map = m.map((k, v) => MapEntry(k.toString(), v));
//       final category = (map['category'] ?? '').toString();
//       final pathList = (map['path'] as List?)?.map((e) => e.toString()).toList() ?? const <String>[];
//       if (category.isEmpty && pathList.isEmpty) return null;
//       final tail = pathList.isEmpty ? '' : ' · ${pathList.join(" > ")}';
//       return '$category$tail';
//     }
//
//     final compSelText = _fmtSel(data['codeSelectionCompact']);
//     final zoomSelText = _fmtSel(data['codeSelectionZoom']);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("상세 보기"),
//         automaticallyImplyLeading: false, // ✅ 상단 뒤로가기 버튼 제거
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             const Text("📍 기본 정보", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("기록 유형: $recordLabel"),
//             Text("재난 장소: ${data['placeOfDisaster'] ?? ''}"),
//             Text("재난 유형: ${data['natureOfDisaster'] ?? ''}"),
//             Text("$idLabel: ${idValue.isEmpty ? '없음' : idValue}"),
//             Text("재난 날짜: ${getDate(data['dateOfDisaster'])}"),
//             Text("성별: ${data['gender'] ?? ''}"),
//             const Divider(),
//
//             const Text("🦷 구강 정보", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("640: 기타 소견 - ${data['otherFindings'] ?? ''}"),
//             Text("645: 치열 유형 - ${data['dentitionType'] ?? ''}"),
//             Text("647: 나이 추정 - ${data['ageMin'] ?? '?'} ~ ${data['ageMax'] ?? '?'}"),
//             Text("650: 품질 확인 - 서명: ${data['qualityCheckSignature'] ?? ''}, 날짜: ${getDate(data['qualityCheckDate'])}"),
//             const Divider(),
//
//             // ===================== Interpol 코드 선택 (축소/확대) =====================
//             const Text("🏷️ Interpol 코드 선택", style: TextStyle(fontWeight: FontWeight.bold)),
//             if (compSelText == null && zoomSelText == null)
//               const Text("선택 없음")
//             else ...[
//               if (compSelText != null) Text("축소뷰(Bridge/Denture): $compSelText"),
//               if (zoomSelText != null) Text("확대뷰(기타 카테고리): $zoomSelText"),
//             ],
//             const Divider(),
//
//             const Text("🦷 Materials Available", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("상악 (치아 있음): ${boolToText(data['upperJawWithTeeth'])}"),
//             Text("하악 (치아 있음): ${boolToText(data['lowerJawWithTeeth'])}"),
//             Text("상악 (치아 없음): ${boolToText(data['upperJawWithoutTeeth'])}"),
//             Text("하악 (치아 없음): ${boolToText(data['lowerJawWithoutTeeth'])}"),
//             Text("조각 있음: ${boolToText(data['fragments'])}"),
//             Text("치아만: ${data['teethOnly'] ?? ''}"),
//             Text("기타: ${data['otherMaterials'] ?? ''}"),
//             const Divider(),
//
//             const Text("🩻 Radiographs", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("PA: Digital - ${boolToText(data['paDigital'])}, Non-Digital - ${boolToText(data['paNonDigital'])}"),
//             Text("BW: Digital - ${boolToText(data['bwDigital'])}, Non-Digital - ${boolToText(data['bwNonDigital'])}"),
//             Text("OPG: Digital - ${boolToText(data['opgDigital'])}, Non-Digital - ${boolToText(data['opgNonDigital'])}"),
//             Text("CT: Digital - ${boolToText(data['ctDigital'])}, Non-Digital - ${boolToText(data['ctNonDigital'])}"),
//             Text("Other: Digital - ${boolToText(data['otherDigital'])}, Non-Digital - ${boolToText(data['otherNonDigital'])}"),
//             Text("Photographs: Digital - ${boolToText(data['photographsDigital'])}, Non-Digital - ${boolToText(data['photographsNonDigital'])}"),
//             Text("기타 영상 자료: ${data['otherRadiographs'] ?? ''}"),
//             const Divider(),
//
//             // ===================== Odontogram Spans 요약 =====================
//             const Text("🧩 Odontogram Spans", style: TextStyle(fontWeight: FontWeight.bold)),
//             Builder(builder: (context) {
//               final list = (data['spans'] as List?) ?? const [];
//               if (list.isEmpty) return const Text('스팬 없음');
//               return Column(
//                 children: list.map((raw) {
//                   final sp = (raw as Map).map((k, v) => MapEntry(k.toString(), v));
//                   final type = (sp['type'] ?? '').toString();
//                   final code = (sp['code'] ?? '').toString();
//                   final teeth = ((sp['teeth'] as List?) ?? const []).map((e) => e.toString()).toList()..sort();
//                   final abut  = ((sp['abutments'] as List?) ?? const []).map((e) => e.toString()).toList()..sort();
//                   final pont  = ((sp['pontics'] as List?) ?? const []).map((e) => e.toString()).toList()..sort();
//
//                   return Card(
//                     margin: const EdgeInsets.only(top: 8),
//                     child: Padding(
//                       padding: const EdgeInsets.all(12),
//                       child: Wrap(
//                         spacing: 8, runSpacing: 6, crossAxisAlignment: WrapCrossAlignment.center,
//                         children: [
//                           Chip(label: Text(type)),
//                           if (code.isNotEmpty) Chip(label: Text('code: $code')),
//                           Chip(label: Text('teeth: ${teeth.join(", ")}')),
//                           if (abut.isNotEmpty) Chip(label: Text('abut: ${abut.join(", ")}')),
//                           if (pont.isNotEmpty) Chip(label: Text('pontic: ${pont.join(", ")}')),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               );
//             }),
//             const Divider(),
//
//             // ===================== 635 Specific 요약 =====================
//             const Text("🧾 635 Specific 요약", style: TextStyle(fontWeight: FontWeight.bold)),
//             Builder(builder: (context) {
//               final spec = (data['spec635'] as Map?)?.cast<String, dynamic>() ?? const {};
//               if (spec.isEmpty) return const Text('입력 없음');
//
//               final items = <Widget>[];
//               final keys = spec.keys.toList()..sort((a, b) => int.parse(a).compareTo(int.parse(b)));
//               for (final k in keys) {
//                 final toothJson = (spec[k] as Map).map((kk, vv) => MapEntry(kk.toString(), vv));
//                 final line = _build635LineFromJson(toothJson);
//                 if (line.trim().isEmpty) continue;
//                 items.add(Padding(
//                   padding: const EdgeInsets.only(top: 6),
//                   child: Text('Tooth $k · $line'),
//                 ));
//               }
//               if (items.isEmpty) return const Text('입력 없음');
//               return Column(crossAxisAlignment: CrossAxisAlignment.start, children: items);
//             }),
//             const Divider(),
//
//             const Text("📂 업로드된 파일", style: TextStyle(fontWeight: FontWeight.bold)),
//             if (uploadedFiles.isEmpty)
//               const Text("파일 없음")
//             else
//               ...uploadedFiles.map((url) => InkWell(
//                 onTap: () => _openImage(context, url),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 4.0),
//                   child: Text(url, style: const TextStyle(color: Colors.blue)),
//                 ),
//               )),
//             const Divider(),
//
//             const Text("💀 턱 상태 및 기타", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("턱 상태: ${data['conditionOfJaws'] ?? ''}"),
//             Text("기타 세부 사항: ${data['otherDetails'] ?? ''}"),
//             const Divider(),
//
//             const Text("🦷 FDI 치아 정보", style: TextStyle(fontWeight: FontWeight.bold)),
//             ...((data['fdiToothData'] as Map?)?.entries.map((entry) {
//               return Text("Tooth ${entry.key}: ${(entry.value as Map)['detail'] ?? ''}");
//             }) ?? [const Text("없음")]),
//
//             const SizedBox(height: 20),
//
//             // ✅ 하단 뒤로가기 버튼
//             Center(
//               child: ElevatedButton.icon(
//                 icon: const Icon(Icons.arrow_back),
//                 label: const Text("뒤로가기"),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(currentIndex: 1),
//     );
//   }
//
//   void _openImage(BuildContext context, String url) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => Scaffold(
//           appBar: AppBar(title: const Text('파일 보기')),
//           body: Center(
//             child: PhotoView(
//               imageProvider: NetworkImage(url),
//               errorBuilder: (context, error, stackTrace) => const Text("이미지를 불러올 수 없습니다."),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// lib/screens/final_review_readonly_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:printing/printing.dart';
import '../screens/pdf_preview_screen.dart';

import '../widgets/custom_bottom_nav_bar.dart';
import '../services/pdf_service.dart';

// 조회 화면용 635 요약 빌더(JSON → 라인)
const List<String> _surfKeys = ['O','M','D','L','B'];
const List<String> _globalKeys = ['bite','crown','root','status','position'];

String _build635LineFromJson(Map<String, dynamic> toothJson) {
  final out = <String>[];

  final surface = (toothJson['surface'] as Map?)?.cast<String, dynamic>() ?? const {};
  for (final s in _surfKeys) {
    final map = (surface[s] as Map?)?.cast<String, dynamic>() ?? const {};
    final fillings = (map['fillings'] as List?)?.map((e) => e.toString()).toList() ?? const <String>[];
    final perio    = (map['periodontium'] as List?)?.map((e) => e.toString()).toList() ?? const <String>[];
    if (fillings.isNotEmpty) out.add('${fillings.join(",")}($s)');
    if (perio.isNotEmpty)    out.add('${perio.join(",")}($s)');
  }

  final global = (toothJson['global'] as Map?)?.cast<String, dynamic>() ?? const {};
  for (final g in _globalKeys) {
    final list = (global[g] as List?)?.map((e) => e.toString()).toList() ?? const <String>[];
    if (list.isNotEmpty) out.add(list.join(','));
  }

  final note = (toothJson['toothNote'] ?? '').toString().trim();
  if (note.isNotEmpty) out.add('note:$note');

  return out.join(' · ');
}

class FinalReviewScreenReadOnly extends StatelessWidget {
  final Map<String, dynamic> data;
  const FinalReviewScreenReadOnly({super.key, required this.data});

  String getDate(String? isoString) {
    if (isoString == null) return "없음";
    return isoString.split("T")[0];
  }

  String boolToText(dynamic val) => val == true ? '예' : '아니오';

  @override
  Widget build(BuildContext context) {
    final uploadedFiles = (data['uploadedFiles'] as List?) ?? [];

    final isPm = data['recordType'] == 'PM';
    final recordLabel = isPm ? 'Post-mortem (PM)' : 'Ante-mortem (AM)';
    final idLabel = isPm ? 'PM 번호' : 'AM 번호';
    final idValue = isPm ? (data['pmNumber'] ?? '') : (data['amNumber'] ?? '');

    String? _fmtSel(dynamic m) {
      if (m is! Map) return null;
      final map = m.map((k, v) => MapEntry(k.toString(), v));
      final category = (map['category'] ?? '').toString();
      final pathList = (map['path'] as List?)?.map((e) => e.toString()).toList() ?? const <String>[];
      if (category.isEmpty && pathList.isEmpty) return null;
      final tail = pathList.isEmpty ? '' : ' · ${pathList.join(" > ")}';
      return '$category$tail';
    }

    final compSelText = _fmtSel(data['codeSelectionCompact']);
    final zoomSelText = _fmtSel(data['codeSelectionZoom']);

    return Scaffold(
      appBar: AppBar(
        title: const Text("상세 보기"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: 'PDF 미리보기',
            icon: const Icon(Icons.picture_as_pdf_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PdfPreviewScreen(data: data)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text("📍 기본 정보", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("기록 유형: $recordLabel"),
            Text("재난 장소: ${data['placeOfDisaster'] ?? ''}"),
            Text("재난 유형: ${data['natureOfDisaster'] ?? ''}"),
            Text("$idLabel: ${idValue.isEmpty ? '없음' : idValue}"),
            Text("재난 날짜: ${getDate(data['dateOfDisaster'])}"),
            Text("성별: ${data['gender'] ?? ''}"),
            const Divider(),

            const Text("🦷 구강 정보", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("640: 기타 소견 - ${data['otherFindings'] ?? ''}"),
            Text("645: 치열 유형 - ${data['dentitionType'] ?? ''}"),
            Text("647: 나이 추정 - ${data['ageMin'] ?? '?'} ~ ${data['ageMax'] ?? '?'}"),
            Text("650: 품질 확인 - 서명: ${data['qualityCheckSignature'] ?? ''}, 날짜: ${getDate(data['qualityCheckDate'])}"),
            const Divider(),

            const Text("🏷️ Interpol 코드 선택", style: TextStyle(fontWeight: FontWeight.bold)),
            if (compSelText == null && zoomSelText == null)
              const Text("선택 없음")
            else ...[
              if (compSelText != null) Text("축소뷰(Bridge/Denture): $compSelText"),
              if (zoomSelText != null) Text("확대뷰(기타 카테고리): $zoomSelText"),
            ],
            const Divider(),

            const Text("🦷 Materials Available", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("상악 (치아 있음): ${boolToText(data['upperJawWithTeeth'])}"),
            Text("하악 (치아 있음): ${boolToText(data['lowerJawWithTeeth'])}"),
            Text("상악 (치아 없음): ${boolToText(data['upperJawWithoutTeeth'])}"),
            Text("하악 (치아 없음): ${boolToText(data['lowerJawWithoutTeeth'])}"),
            Text("조각 있음: ${boolToText(data['fragments'])}"),
            Text("치아만: ${data['teethOnly'] ?? ''}"),
            Text("기타: ${data['otherMaterials'] ?? ''}"),
            const Divider(),

            const Text("🩻 Radiographs", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("PA: Digital - ${boolToText(data['paDigital'])}, Non-Digital - ${boolToText(data['paNonDigital'])}"),
            Text("BW: Digital - ${boolToText(data['bwDigital'])}, Non-Digital - ${boolToText(data['bwNonDigital'])}"),
            Text("OPG: Digital - ${boolToText(data['opgDigital'])}, Non-Digital - ${boolToText(data['opgNonDigital'])}"),
            Text("CT: Digital - ${boolToText(data['ctDigital'])}, Non-Digital - ${boolToText(data['ctNonDigital'])}"),
            Text("Other: Digital - ${boolToText(data['otherDigital'])}, Non-Digital - ${boolToText(data['otherNonDigital'])}"),
            Text("Photographs: Digital - ${boolToText(data['photographsDigital'])}, Non-Digital - ${boolToText(data['photographsNonDigital'])}"),
            Text("기타 영상 자료: ${data['otherRadiographs'] ?? ''}"),
            const Divider(),

            const Text("🧩 Odontogram Spans", style: TextStyle(fontWeight: FontWeight.bold)),
            Builder(builder: (context) {
              final list = (data['spans'] as List?) ?? const [];
              if (list.isEmpty) return const Text('스팬 없음');
              return Column(
                children: list.map((raw) {
                  final sp = (raw as Map).map((k, v) => MapEntry(k.toString(), v));
                  final type = (sp['type'] ?? '').toString();
                  final code = (sp['code'] ?? '').toString();
                  final teeth = ((sp['teeth'] as List?) ?? const []).map((e) => e.toString()).toList()..sort();
                  final abut  = ((sp['abutments'] as List?) ?? const []).map((e) => e.toString()).toList()..sort();
                  final pont  = ((sp['pontics'] as List?) ?? const []).map((e) => e.toString()).toList()..sort();

                  return Card(
                    margin: const EdgeInsets.only(top: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Wrap(
                        spacing: 8, runSpacing: 6, crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Chip(label: Text(type)),
                          if (code.isNotEmpty) Chip(label: Text('code: $code')),
                          Chip(label: Text('teeth: ${teeth.join(", ")}')),
                          if (abut.isNotEmpty) Chip(label: Text('abut: ${abut.join(", ")}')),
                          if (pont.isNotEmpty) Chip(label: Text('pontic: ${pont.join(", ")}')),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
            const Divider(),

            const Text("🧾 635 Specific 요약", style: TextStyle(fontWeight: FontWeight.bold)),
            Builder(builder: (context) {
              final spec = (data['spec635'] as Map?)?.cast<String, dynamic>() ?? const {};
              if (spec.isEmpty) return const Text('입력 없음');

              final items = <Widget>[];
              final keys = spec.keys.toList()..sort((a, b) => int.parse(a).compareTo(int.parse(b)));
              for (final k in keys) {
                final toothJson = (spec[k] as Map).map((kk, vv) => MapEntry(kk.toString(), vv));
                final line = _build635LineFromJson(toothJson);
                if (line.trim().isEmpty) continue;
                items.add(Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text('Tooth $k · $line'),
                ));
              }
              if (items.isEmpty) return const Text('입력 없음');
              return Column(crossAxisAlignment: CrossAxisAlignment.start, children: items);
            }),
            const Divider(),

            const Text("📂 업로드된 파일", style: TextStyle(fontWeight: FontWeight.bold)),
            if (uploadedFiles.isEmpty)
              const Text("파일 없음")
            else
              ...uploadedFiles.map((url) => InkWell(
                onTap: () => _openImage(context, url),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(url, style: const TextStyle(color: Colors.blue)),
                ),
              )),
            const Divider(),

            const Text("💀 턱 상태 및 기타", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("턱 상태: ${data['conditionOfJaws'] ?? ''}"),
            Text("기타 세부 사항: ${data['otherDetails'] ?? ''}"),
            const Divider(),

            const Text("🦷 FDI 치아 정보", style: TextStyle(fontWeight: FontWeight.bold)),
            ...((data['fdiToothData'] as Map?)?.entries.map((entry) {
              return Text("Tooth ${entry.key}: ${(entry.value as Map)['detail'] ?? ''}");
            }) ?? [const Text("없음")]),

            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.arrow_back),
                label: const Text("뒤로가기"),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }

  void _openImage(BuildContext context, String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('파일 보기')),
          body: Center(
            child: PhotoView(
              imageProvider: NetworkImage(url),
              errorBuilder: (context, error, stackTrace) => const Text("이미지를 불러올 수 없습니다."),
            ),
          ),
        ),
      ),
    );
  }
}
