// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import '../providers/dental_data_provider.dart';
//
// class FinalReviewScreen extends StatelessWidget {
//   final Map<String, dynamic> arguments;
//
//   const FinalReviewScreen({required this.arguments});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Final Review")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const Text("Review and Submit", style: TextStyle(fontSize: 18)),
//             Expanded(
//               child: Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Logic to submit data to Firebase or backend here.
//                     Navigator.popUntil(context, ModalRoute.withName('/record'));
//                   },
//                   child: const Text("Submit"),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../providers/dental_data_provider.dart';
//
// class FinalReviewScreen extends StatelessWidget {
//   const FinalReviewScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<DentalDataProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("최종 확인"),
//         automaticallyImplyLeading: false,),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("입력 내용 확인 후 제출하세요", style: TextStyle(fontSize: 18)),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView(
//                 children: [
//                   Text("640: 기타 소견 - ${provider.otherFindings}"),
//                   Text("645: 치열 유형 - ${provider.dentitionType}"),
//                   Text("647: 나이 추정 - ${provider.ageMin ?? "?"} ~ ${provider.ageMax ?? "?"}"),
//                   Text("650: 품질 확인 - 서명: ${provider.qualityCheckSignature}, 날짜: ${provider.qualityCheckDate?.toLocal().toString().split(" ")[0] ?? "없음"}"),
//                   const Divider(),
//                   const Text("Materials Available"),
//                   Text("상악 (치아 있음): ${provider.upperJawWithTeeth}"),
//                   Text("하악 (치아 있음): ${provider.lowerJawWithTeeth}"),
//                   Text("상악 (치아 없음): ${provider.upperJawWithoutTeeth}"),
//                   Text("하악 (치아 없음): ${provider.lowerJawWithoutTeeth}"),
//                   Text("조각 있음: ${provider.fragments}"),
//                   Text("치아만: ${provider.teethOnly}"),
//                   Text("기타: ${provider.otherMaterials}"),
//                   const Divider(),
//                   const Text("Radiographs"),
//                   Text("PA Digital: ${provider.paDigital}, Non-Digital: ${provider.paNonDigital}"),
//                   Text("BW Digital: ${provider.bwDigital}, Non-Digital: ${provider.bwNonDigital}"),
//                   Text("OPG Digital: ${provider.opgDigital}, Non-Digital: ${provider.opgNonDigital}"),
//                   Text("CT Digital: ${provider.ctDigital}, Non-Digital: ${provider.ctNonDigital}"),
//                   Text("Other: Digital: ${provider.otherDigital}, Non-Digital: ${provider.otherNonDigital}"),
//                   Text("Photographs: Digital: ${provider.photographsDigital}, Non-Digital: ${provider.photographsNonDigital}"),
//                   Text("Other Radiographs: ${provider.otherRadiographs}"),
//                   const Divider(),
//                   Text("업로드 파일 수: ${provider.uploadedFiles.length}"),
//                   const Divider(),
//                   Text("턱 상태: ${provider.conditionOfJaws}"),
//                   Text("기타 세부 사항: ${provider.otherDetails}"),
//                   const Divider(),
//                   const Text("FDI Tooth Data"),
//                   ...provider.fdiToothData.entries.map((e) => Text("Tooth ${e.key}: ${e.value['detail']}")),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text("이전"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     try {
//                       await FirebaseFirestore.instance.collection('dental_data').add(provider.toMap());
//                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('최종 저장 완료')));
//                       Navigator.popUntil(context, ModalRoute.withName('/record'));
//                     } catch (e) {
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('저장 실패: $e')));
//                     }
//                   },
//                   child: const Text("최종 제출"),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../providers/dental_data_provider.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
//
// class FinalReviewScreen extends StatelessWidget {
//   const FinalReviewScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<DentalDataProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("최종 확인"),
//         automaticallyImplyLeading: false, // 상단 뒤로가기 제거
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("입력 내용 확인 후 제출하세요", style: TextStyle(fontSize: 18)),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView(
//                 children: [
//                   const Text("📍 기본 정보", style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text("재난 장소: ${provider.placeOfDisaster}"),
//                   Text("재난 유형: ${provider.natureOfDisaster}"),
//                   Text("PM 번호: ${provider.pmNumber}"),
//                   Text("재난 날짜: ${provider.dateOfDisaster?.toLocal().toString().split(' ')[0] ?? "없음"}"),
//                   Text("성별: ${provider.gender}"),
//                   const Divider(),
//
//                   const Text("🦷 구강 정보", style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text("640: 기타 소견 - ${provider.otherFindings}"),
//                   Text("645: 치열 유형 - ${provider.dentitionType}"),
//                   Text("647: 나이 추정 - ${provider.ageMin ?? "?"} ~ ${provider.ageMax ?? "?"}"),
//                   Text("650: 품질 확인 - 서명: ${provider.qualityCheckSignature}, 날짜: ${provider.qualityCheckDate?.toLocal().toString().split(" ")[0] ?? "없음"}"),
//                   const Divider(),
//
//                   const Text("🦷 Materials Available", style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text("상악 (치아 있음): ${provider.upperJawWithTeeth}"),
//                   Text("하악 (치아 있음): ${provider.lowerJawWithTeeth}"),
//                   Text("상악 (치아 없음): ${provider.upperJawWithoutTeeth}"),
//                   Text("하악 (치아 없음): ${provider.lowerJawWithoutTeeth}"),
//                   Text("조각 있음: ${provider.fragments}"),
//                   Text("치아만: ${provider.teethOnly}"),
//                   Text("기타: ${provider.otherMaterials}"),
//                   const Divider(),
//
//                   const Text("🩻 Radiographs", style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text("PA: Digital - ${provider.paDigital}, Non-Digital - ${provider.paNonDigital}"),
//                   Text("BW: Digital - ${provider.bwDigital}, Non-Digital - ${provider.bwNonDigital}"),
//                   Text("OPG: Digital - ${provider.opgDigital}, Non-Digital - ${provider.opgNonDigital}"),
//                   Text("CT: Digital - ${provider.ctDigital}, Non-Digital - ${provider.ctNonDigital}"),
//                   Text("Other: Digital - ${provider.otherDigital}, Non-Digital - ${provider.otherNonDigital}"),
//                   Text("Photographs: Digital - ${provider.photographsDigital}, Non-Digital - ${provider.photographsNonDigital}"),
//                   Text("기타 영상 자료: ${provider.otherRadiographs}"),
//                   const Divider(),
//
//                   Text("업로드 파일 수: ${provider.uploadedFiles.length}"),
//                   const Divider(),
//
//                   const Text("💀 턱 상태 및 기타", style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text("턱 상태: ${provider.conditionOfJaws}"),
//                   Text("기타 세부 사항: ${provider.otherDetails}"),
//                   const Divider(),
//
//                   const Text("🦷 FDI 치아 정보", style: TextStyle(fontWeight: FontWeight.bold)),
//                   ...provider.fdiToothData.entries.map((e) => Text("Tooth ${e.key}: ${e.value['detail']}")),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => Navigator.pushReplacementNamed(context,'/dentalFindings'),
//                   child: const Text("이전"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     try {
//                       await FirebaseFirestore.instance
//                           .collection('dental_data')
//                           .add(provider.toMap());
//
//                       provider.resetAll();
//
//                       ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('최종 저장 완료')));
//                       Navigator.pushNamedAndRemoveUntil(
//                         context,
//                         '/record',
//                             (Route<dynamic> route) => false,
//                       );
//                     } catch (e) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('저장 실패: $e')));
//                     }
//                   },
//                   child: const Text("최종 제출"),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../providers/dental_data_provider.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
// import 'package:photo_view/photo_view.dart';
//
// class FinalReviewScreen extends StatelessWidget {
//   const FinalReviewScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<DentalDataProvider>(context);
//     final isPm = provider.recordType == 'PM';
//     final recordLabel = isPm ? 'Post-mortem (PM)' : 'Ante-mortem (AM)';
//     final idLabel = isPm ? 'PM 번호' : 'AM 번호';
//     final idValue = isPm ? provider.pmNumber : provider.amNumber;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("최종 확인"),
//         automaticallyImplyLeading: false, // 상단 뒤로가기 제거
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("입력 내용 확인 후 제출하세요", style: TextStyle(fontSize: 18)),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView(
//                 children: [
//                   const Text("📍 기본 정보", style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text("기록 유형: $recordLabel"),
//                   Text("재난 장소: ${provider.placeForUi.isEmpty ? '없음' : provider.placeForUi}"),   // ✅ 잠금/사용자 선택 모두 OK
//                   Text("재난 유형: ${provider.natureForUi.isEmpty ? '없음' : provider.natureForUi}"), // ✅ 잠금/사용자 선택 모두 OK
//                   Text("$idLabel: ${idValue.isEmpty ? '없음' : idValue}"),
//                   Text("재난 날짜: ${provider.dateOfDisaster?.toLocal().toString().split(' ')[0] ?? "없음"}"),
//                   Text("성별: ${provider.gender}"),
//                   const Divider(),
//
//                   const Text("🦷 구강 정보", style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text("640: 기타 소견 - ${provider.otherFindings}"),
//                   Text("645: 치열 유형 - ${provider.dentitionType}"),
//                   Text("647: 나이 추정 - ${provider.ageMin ?? "?"} ~ ${provider.ageMax ?? "?"}"),
//                   Text("650: 품질 확인 - 서명: ${provider.qualityCheckSignature}, 날짜: ${provider.qualityCheckDate?.toLocal().toString().split(" ")[0] ?? "없음"}"),
//                   const Divider(),
//
//                   // ===================== Odontogram Spans 요약 =====================
//                   const SizedBox(height: 12),
//                   const Text("🧩 Odontogram Spans", style: TextStyle(fontWeight: FontWeight.bold)),
//
//                   if (provider.spans.isEmpty)
//                     const Text("스팬 없음")
//                   else
//                     ...provider.spans.map((sp) => Card(
//                       margin: const EdgeInsets.only(top: 8),
//                       child: Padding(
//                         padding: const EdgeInsets.all(12),
//                         child: Wrap(
//                           spacing: 8, runSpacing: 6, crossAxisAlignment: WrapCrossAlignment.center,
//                           children: [
//                             Chip(label: Text(sp.type.name)),
//                             if (sp.code != null && sp.code!.isNotEmpty)
//                               Chip(label: Text('code: ${sp.code}')),
//                             Chip(label: Text('teeth: ${(sp.teeth.toList()..sort()).join(", ")}')),
//                             if (sp.abutments.isNotEmpty)
//                               Chip(label: Text('abut: ${(sp.abutments.toList()..sort()).join(", ")}')),
//                             if (sp.pontics.isNotEmpty)
//                               Chip(label: Text('pontic: ${(sp.pontics.toList()..sort()).join(", ")}')),
//                           ],
//                         ),
//                       ),
//                     )),
//
//                   const Divider(),
//
// // ===================== 635 Specific 요약 =====================
//                   const Text("🧾 635 Specific 요약", style: TextStyle(fontWeight: FontWeight.bold)),
//
//                   Builder(builder: (context) {
//                     // provider에 있는 직렬화 스냅샷에서 치아 목록 얻기
//                     final specMap = (provider.toMap()['spec635'] as Map?)?.cast<String, dynamic>() ?? {};
//                     final lines = <Widget>[];
//
//                     // build635Line(fdi) 사용해서 사람 읽기 좋은 요약 생성
//                     for (final e in specMap.entries) {
//                       final fdi = int.tryParse(e.key);
//                       if (fdi == null) continue;
//                       final line = provider.build635Line(fdi).trim();
//                       if (line.isNotEmpty) {
//                         lines.add(Padding(
//                           padding: const EdgeInsets.only(top: 6),
//                           child: Text('Tooth $fdi · $line'),
//                         ));
//                       }
//                     }
//                     if (lines.isEmpty) return const Text('입력 없음');
//                     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: lines);
//                   }),
//                   const Divider(),
//
//                   const Text("🦷 Materials Available", style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text("상악 (치아 있음): ${provider.upperJawWithTeeth}"),
//                   Text("하악 (치아 있음): ${provider.lowerJawWithTeeth}"),
//                   Text("상악 (치아 없음): ${provider.upperJawWithoutTeeth}"),
//                   Text("하악 (치아 없음): ${provider.lowerJawWithoutTeeth}"),
//                   Text("조각 있음: ${provider.fragments}"),
//                   Text("치아만: ${provider.teethOnly}"),
//                   Text("기타: ${provider.otherMaterials}"),
//                   const Divider(),
//
//                   const Text("🩻 Radiographs", style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text("PA: Digital - ${provider.paDigital}, Non-Digital - ${provider.paNonDigital}"),
//                   Text("BW: Digital - ${provider.bwDigital}, Non-Digital - ${provider.bwNonDigital}"),
//                   Text("OPG: Digital - ${provider.opgDigital}, Non-Digital - ${provider.opgNonDigital}"),
//                   Text("CT: Digital - ${provider.ctDigital}, Non-Digital - ${provider.ctNonDigital}"),
//                   Text("Other: Digital - ${provider.otherDigital}, Non-Digital - ${provider.otherNonDigital}"),
//                   Text("Photographs: Digital - ${provider.photographsDigital}, Non-Digital - ${provider.photographsNonDigital}"),
//                   Text("기타 영상 자료: ${provider.otherRadiographs}"),
//                   const Divider(),
//
//                   const Text("📂 업로드된 파일", style: TextStyle(fontWeight: FontWeight.bold)),
//                   if (provider.uploadedFiles.isEmpty)
//                     const Text("파일 없음")
//                   else
//                     ...provider.uploadedFiles.map((url) => InkWell(
//                       onTap: () => _openImage(context, url),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 4.0),
//                         child: Text(url, style: const TextStyle(color: Colors.blue)),
//                       ),
//                     )),
//
//                   const Divider(),
//
//                   const Text("💀 턱 상태 및 기타", style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text("턱 상태: ${provider.conditionOfJaws}"),
//                   Text("기타 세부 사항: ${provider.otherDetails}"),
//                   const Divider(),
//
//                   const Text("🦷 FDI 치아 정보", style: TextStyle(fontWeight: FontWeight.bold)),
//                   ...provider.fdiToothData.entries.map((e) => Text("Tooth ${e.key}: ${e.value['detail']}")),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => Navigator.pushReplacementNamed(context,'/DentalDataScreen'),
//                   child: const Text("이전"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     try {
//                       await FirebaseFirestore.instance
//                           .collection('dental_data')
//                           .add(provider.toMap());
//
//                       provider.resetAll();
//
//                       ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('최종 저장 완료')));
//                       Navigator.pushNamedAndRemoveUntil(
//                         context,
//                         '/record',
//                             (Route<dynamic> route) => false,
//                       );
//                     } catch (e) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('저장 실패: $e')));
//                     }
//                   },
//                   child: const Text("최종 제출"),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
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
// import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../providers/dental_data_provider.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
// import 'package:photo_view/photo_view.dart';
//
// class FinalReviewScreen extends StatelessWidget {
//   const FinalReviewScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<DentalDataProvider>(context);
//     final isPm = provider.recordType == 'PM';
//     final recordLabel = isPm ? 'Post-mortem (PM)' : 'Ante-mortem (AM)';
//     final idLabel = isPm ? 'PM 번호' : 'AM 번호';
//     final idValue = isPm ? provider.pmNumber : provider.amNumber;
//
//     // ▼ helper: 선택 포맷팅
//     String _fmtSel(CodeSelection sel) {
//       final tail = sel.path.isEmpty ? '' : ' · ${sel.path.join(" > ")}';
//       return '${sel.category}$tail';
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("최종 확인"),
//         automaticallyImplyLeading: false, // 상단 뒤로가기 제거
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("입력 내용 확인 후 제출하세요", style: TextStyle(fontSize: 18)),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView(
//                 children: [
//                   const Text("📍 기본 정보", style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text("기록 유형: $recordLabel"),
//                   Text("재난 장소: ${provider.placeForUi.isEmpty ? '없음' : provider.placeForUi}"),   // ✅ 잠금/사용자 선택 모두 OK
//                   Text("재난 유형: ${provider.natureForUi.isEmpty ? '없음' : provider.natureForUi}"), // ✅ 잠금/사용자 선택 모두 OK
//                   Text("$idLabel: ${idValue.isEmpty ? '없음' : idValue}"),
//                   Text("재난 날짜: ${provider.dateOfDisaster?.toLocal().toString().split(' ')[0] ?? "없음"}"),
//                   Text("성별: ${provider.gender}"),
//                   const Divider(),
//
//                   const Text("🦷 구강 정보", style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text("640: 기타 소견 - ${provider.otherFindings}"),
//                   Text("645: 치열 유형 - ${provider.dentitionType}"),
//                   Text("647: 나이 추정 - ${provider.ageMin ?? "?"} ~ ${provider.ageMax ?? "?"}"),
//                   Text("650: 품질 확인 - 서명: ${provider.qualityCheckSignature}, 날짜: ${provider.qualityCheckDate?.toLocal().toString().split(" ")[0] ?? "없음"}"),
//                   const Divider(),
//
//                   // ===================== Interpol 코드 선택 (축소/확대) =====================
//                   const Text("🏷️ Interpol 코드 선택", style: TextStyle(fontWeight: FontWeight.bold)),
//                   if (provider.currentSelectionCompact == null && provider.currentSelectionZoom == null)
//                     const Text("선택 없음")
//                   else ...[
//                     if (provider.currentSelectionCompact != null)
//                       Text("축소뷰(Bridge/Denture): ${_fmtSel(provider.currentSelectionCompact!)}"),
//                     if (provider.currentSelectionZoom != null)
//                       Text("확대뷰(기타 카테고리): ${_fmtSel(provider.currentSelectionZoom!)}"),
//                   ],
//                   const Divider(),
//
//                   // ===================== Odontogram Spans 요약 =====================
//                   const SizedBox(height: 12),
//                   const Text("🧩 Odontogram Spans", style: TextStyle(fontWeight: FontWeight.bold)),
//
//                   if (provider.spans.isEmpty)
//                     const Text("스팬 없음")
//                   else
//                     ...provider.spans.map((sp) => Card(
//                       margin: const EdgeInsets.only(top: 8),
//                       child: Padding(
//                         padding: const EdgeInsets.all(12),
//                         child: Wrap(
//                           spacing: 8, runSpacing: 6, crossAxisAlignment: WrapCrossAlignment.center,
//                           children: [
//                             Chip(label: Text(sp.type.name)),
//                             if (sp.code != null && sp.code!.isNotEmpty)
//                               Chip(label: Text('code: ${sp.code}')),
//                             Chip(label: Text('teeth: ${(sp.teeth.toList()..sort()).join(", ")}')),
//                             if (sp.abutments.isNotEmpty)
//                               Chip(label: Text('abut: ${(sp.abutments.toList()..sort()).join(", ")}')),
//                             if (sp.pontics.isNotEmpty)
//                               Chip(label: Text('pontic: ${(sp.pontics.toList()..sort()).join(", ")}')),
//                           ],
//                         ),
//                       ),
//                     )),
//
//                   const Divider(),
//
//                   // ===================== 635 Specific 요약 =====================
//                   const Text("🧾 635 Specific 요약", style: TextStyle(fontWeight: FontWeight.bold)),
//
//                   Builder(builder: (context) {
//                     // provider에 있는 직렬화 스냅샷에서 치아 목록 얻기
//                     final specMap = (provider.toMap()['spec635'] as Map?)?.cast<String, dynamic>() ?? {};
//                     final lines = <Widget>[];
//
//                     // build635Line(fdi) 사용해서 사람 읽기 좋은 요약 생성
//                     for (final e in specMap.entries) {
//                       final fdi = int.tryParse(e.key);
//                       if (fdi == null) continue;
//                       final line = provider.build635Line(fdi).trim();
//                       if (line.isNotEmpty) {
//                         lines.add(Padding(
//                           padding: const EdgeInsets.only(top: 6),
//                           child: Text('Tooth $fdi · $line'),
//                         ));
//                       }
//                     }
//                     if (lines.isEmpty) return const Text('입력 없음');
//                     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: lines);
//                   }),
//                   const Divider(),
//
//                   const Text("🦷 Materials Available", style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text("상악 (치아 있음): ${provider.upperJawWithTeeth}"),
//                   Text("하악 (치아 있음): ${provider.lowerJawWithTeeth}"),
//                   Text("상악 (치아 없음): ${provider.upperJawWithoutTeeth}"),
//                   Text("하악 (치아 없음): ${provider.lowerJawWithoutTeeth}"),
//                   Text("조각 있음: ${provider.fragments}"),
//                   Text("치아만: ${provider.teethOnly}"),
//                   Text("기타: ${provider.otherMaterials}"),
//                   const Divider(),
//
//                   const Text("🩻 Radiographs", style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text("PA: Digital - ${provider.paDigital}, Non-Digital - ${provider.paNonDigital}"),
//                   Text("BW: Digital - ${provider.bwDigital}, Non-Digital - ${provider.bwNonDigital}"),
//                   Text("OPG: Digital - ${provider.opgDigital}, Non-Digital - ${provider.opgNonDigital}"),
//                   Text("CT: Digital - ${provider.ctDigital}, Non-Digital - ${provider.ctNonDigital}"),
//                   Text("Other: Digital - ${provider.otherDigital}, Non-Digital - ${provider.otherNonDigital}"),
//                   Text("Photographs: Digital - ${provider.photographsDigital}, Non-Digital - ${provider.photographsNonDigital}"),
//                   Text("기타 영상 자료: ${provider.otherRadiographs}"),
//                   const Divider(),
//
//                   const Text("📂 업로드된 파일", style: TextStyle(fontWeight: FontWeight.bold)),
//                   if (provider.uploadedFiles.isEmpty)
//                     const Text("파일 없음")
//                   else
//                     ...provider.uploadedFiles.map((url) => InkWell(
//                       onTap: () => _openImage(context, url),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 4.0),
//                         child: Text(url, style: const TextStyle(color: Colors.blue)),
//                       ),
//                     )),
//
//                   const Divider(),
//
//                   const Text("💀 턱 상태 및 기타", style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text("턱 상태: ${provider.conditionOfJaws}"),
//                   Text("기타 세부 사항: ${provider.otherDetails}"),
//                   const Divider(),
//
//                   const Text("🦷 FDI 치아 정보", style: TextStyle(fontWeight: FontWeight.bold)),
//                   ...provider.fdiToothData.entries.map((e) => Text("Tooth ${e.key}: ${e.value['detail']}")),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => Navigator.pushReplacementNamed(context,'/DentalDataScreen'),
//                   child: const Text("이전"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     try {
//                       await FirebaseFirestore.instance
//                           .collection('dental_data')
//                           .add(provider.toMap());
//
//                       provider.resetAll();
//
//                       ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('최종 저장 완료')));
//                       Navigator.pushNamedAndRemoveUntil(
//                         context,
//                         '/record',
//                             (Route<dynamic> route) => false,
//                       );
//                     } catch (e) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('저장 실패: $e')));
//                     }
//                   },
//                   child: const Text("최종 제출"),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
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

import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_view/photo_view.dart';
import 'package:printing/printing.dart';
import '../providers/app_mode_provider.dart';
import '../screens/pdf_preview_screen.dart';

import '../providers/dental_data_provider.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../services/pdf_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/local_store.dart';

class FinalReviewScreen extends StatelessWidget {
  const FinalReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final offline = context.watch<AppModeProvider>().isOfflineMode;
    final provider = Provider.of<DentalDataProvider>(context);
    final isPm = provider.recordType == 'PM';
    final recordLabel = isPm ? 'Post-mortem (PM)' : 'Ante-mortem (AM)';
    final idLabel = isPm ? 'PM 번호' : 'AM 번호';
    final idValue = isPm ? provider.pmNumber : provider.amNumber;

    String _fmtSel(CodeSelection sel) {
      final tail = sel.path.isEmpty ? '' : ' · ${sel.path.join(" > ")}';
      return '${sel.category}$tail';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("최종 확인"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: 'PDF 미리보기',
            icon: const Icon(Icons.picture_as_pdf_outlined),
            onPressed: () {
              final map = provider.toMap();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PdfPreviewScreen(data: map)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("입력 내용 확인 후 제출하세요", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  const Text("📍 기본 정보", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("기록 유형: $recordLabel"),
                  Text("재난 장소: ${provider.placeForUi.isEmpty ? '없음' : provider.placeForUi}"),
                  Text("재난 유형: ${provider.natureForUi.isEmpty ? '없음' : provider.natureForUi}"),
                  Text("$idLabel: ${idValue.isEmpty ? '없음' : idValue}"),
                  Text("재난 날짜: ${provider.dateOfDisaster?.toLocal().toString().split(' ')[0] ?? "없음"}"),
                  Text("성별: ${provider.gender}"),
                  const Divider(),

                  const Text("🦷 구강 정보", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("640: 기타 소견 - ${provider.otherFindings}"),
                  Text("645: 치열 유형 - ${provider.dentitionType}"),
                  Text("647: 나이 추정 - ${provider.ageMin ?? "?"} ~ ${provider.ageMax ?? "?"}"),
                  Text("650: 품질 확인 - 서명: ${provider.qualityCheckSignature}, 날짜: ${provider.qualityCheckDate?.toLocal().toString().split(" ")[0] ?? "없음"}"),
                  const Divider(),

                  const Text("🏷️ Interpol 코드 선택", style: TextStyle(fontWeight: FontWeight.bold)),
                  if (provider.currentSelectionCompact == null && provider.currentSelectionZoom == null)
                    const Text("선택 없음")
                  else ...[
                    if (provider.currentSelectionCompact != null)
                      Text("축소뷰(Bridge/Denture): ${_fmtSel(provider.currentSelectionCompact!)}"),
                    if (provider.currentSelectionZoom != null)
                      Text("확대뷰(기타 카테고리): ${_fmtSel(provider.currentSelectionZoom!)}"),
                  ],
                  const Divider(),

                  const SizedBox(height: 12),
                  const Text("🧩 Odontogram Spans", style: TextStyle(fontWeight: FontWeight.bold)),
                  if (provider.spans.isEmpty)
                    const Text("스팬 없음")
                  else
                    ...provider.spans.map((sp) => Card(
                      margin: const EdgeInsets.only(top: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Wrap(
                          spacing: 8, runSpacing: 6, crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Chip(label: Text(sp.type.name)),
                            if (sp.code != null && sp.code!.isNotEmpty) Chip(label: Text('code: ${sp.code}')),
                            Chip(label: Text('teeth: ${(sp.teeth.toList()..sort()).join(", ")}')),
                            if (sp.abutments.isNotEmpty) Chip(label: Text('abut: ${(sp.abutments.toList()..sort()).join(", ")}')),
                            if (sp.pontics.isNotEmpty) Chip(label: Text('pontic: ${(sp.pontics.toList()..sort()).join(", ")}')),
                          ],
                        ),
                      ),
                    )),
                  const Divider(),

                  const Text("🧾 635 Specific 요약", style: TextStyle(fontWeight: FontWeight.bold)),
                  Builder(builder: (context) {
                    final specMap = (provider.toMap()['spec635'] as Map?)?.cast<String, dynamic>() ?? {};
                    final lines = <Widget>[];
                    for (final e in specMap.entries) {
                      final fdi = int.tryParse(e.key);
                      if (fdi == null) continue;
                      final line = provider.build635Line(fdi).trim();
                      if (line.isNotEmpty) {
                        lines.add(Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text('Tooth $fdi · $line'),
                        ));
                      }
                    }
                    if (lines.isEmpty) return const Text('입력 없음');
                    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: lines);
                  }),
                  const Divider(),

                  const Text("🦷 Materials Available", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("상악 (치아 있음): ${provider.upperJawWithTeeth}"),
                  Text("하악 (치아 있음): ${provider.lowerJawWithTeeth}"),
                  Text("상악 (치아 없음): ${provider.upperJawWithoutTeeth}"),
                  Text("하악 (치아 없음): ${provider.lowerJawWithoutTeeth}"),
                  Text("조각 있음: ${provider.fragments}"),
                  Text("치아만: ${provider.teethOnly}"),
                  Text("기타: ${provider.otherMaterials}"),
                  const Divider(),

                  const Text("🩻 Radiographs", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("PA: Digital - ${provider.paDigital}, Non-Digital - ${provider.paNonDigital}"),
                  Text("BW: Digital - ${provider.bwDigital}, Non-Digital - ${provider.bwNonDigital}"),
                  Text("OPG: Digital - ${provider.opgDigital}, Non-Digital - ${provider.opgNonDigital}"),
                  Text("CT: Digital - ${provider.ctDigital}, Non-Digital - ${provider.ctNonDigital}"),
                  Text("Other: Digital - ${provider.otherDigital}, Non-Digital - ${provider.otherNonDigital}"),
                  Text("Photographs: Digital - ${provider.photographsDigital}, Non-Digital - ${provider.photographsNonDigital}"),
                  Text("기타 영상 자료: ${provider.otherRadiographs}"),
                  const Divider(),

                  const Text("📂 업로드된 파일", style: TextStyle(fontWeight: FontWeight.bold)),
                  if (provider.uploadedFiles.isEmpty)
                    const Text("파일 없음")
                  else
                    ...provider.uploadedFiles.map((url) => InkWell(
                      onTap: () => _openImage(context, url),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(url, style: const TextStyle(color: Colors.blue)),
                      ),
                    )),

                  const Divider(),

                  const Text("💀 턱 상태 및 기타", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("턱 상태: ${provider.conditionOfJaws}"),
                  Text("기타 세부 사항: ${provider.otherDetails}"),
                  const Divider(),

                  const Text("🦷 FDI 치아 정보", style: TextStyle(fontWeight: FontWeight.bold)),
                  ...provider.fdiToothData.entries.map((e) => Text("Tooth ${e.key}: ${e.value['detail']}")),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pushReplacementNamed(context,'/DentalDataScreen'),
                  child: const Text("이전"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final data = provider.toMap();

                    bool onlineAndAuthed;
                    try {
                      onlineAndAuthed =
                          Firebase.apps.isNotEmpty && FirebaseAuth.instance.currentUser != null;
                    } catch (_) {
                      onlineAndAuthed = false;
                    }

                    if (onlineAndAuthed) {
                      try {
                        await FirebaseFirestore.instance.collection('dental_data').add(data);
                        await provider.resetAll();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('최종 저장 완료 (서버)')),
                          );
                          Navigator.pushNamedAndRemoveUntil(context, '/record', (_) => false);
                        }
                        return;
                      } catch (_) {
                        // 떨어지면 로컬 큐로 폴백
                      }
                    }

                    // 오프라인/미인증/업로드 실패 → 로컬 제출 대기
                    await LocalStore.enqueuePendingSubmission(data);
                    await provider.resetAll();
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('오프라인: 제출 대기로 저장됨')),
                    );
                    Navigator.pushNamedAndRemoveUntil(context, '/record', (_) => false);
                  },
                  child: const Text("최종 제출"),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
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


