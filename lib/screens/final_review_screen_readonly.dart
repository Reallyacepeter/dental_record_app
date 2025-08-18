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

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'package:photo_view/photo_view.dart';
//
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
//             const Text("📂 업로드된 파일", style: TextStyle(fontWeight: FontWeight.bold)),
//             if (uploadedFiles.isEmpty)
//               const Text("파일 없음")
//             else
//               // ...uploadedFiles.map((url) => InkWell(
//               //   onTap: () async {
//               //     final uri = Uri.parse(url);
//               //     if (await canLaunchUrl(uri)) {
//               //       await launchUrl(uri, mode: LaunchMode.externalApplication);
//               //     } else {
//               //       ScaffoldMessenger.of(context).showSnackBar(
//               //         const SnackBar(content: Text("파일 열기 실패")),
//               //       );
//               //     }
//               //   },
//               //   child: Padding(
//               //     padding: const EdgeInsets.symmetric(vertical: 4.0),
//               //     child: Text(url, style: const TextStyle(color: Colors.blue)),
//               //   ),
//               // )),
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

    // ✅ AM/PM 구분 처리
    final isPm = data['recordType'] == 'PM';
    final recordLabel = isPm ? 'Post-mortem (PM)' : 'Ante-mortem (AM)';
    final idLabel = isPm ? 'PM 번호' : 'AM 번호';
    final idValue = isPm ? (data['pmNumber'] ?? '') : (data['amNumber'] ?? '');

    return Scaffold(
      appBar: AppBar(
        title: const Text("상세 보기"),
        automaticallyImplyLeading: false, // ✅ 상단 뒤로가기 버튼 제거
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

            // ✅ 하단 뒤로가기 버튼
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
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 1),
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

