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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/dental_data_provider.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'package:photo_view/photo_view.dart';

class FinalReviewScreen extends StatelessWidget {
  const FinalReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DentalDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("최종 확인"),
        automaticallyImplyLeading: false, // 상단 뒤로가기 제거
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
                  Text("재난 장소: ${provider.placeOfDisaster}"),
                  Text("재난 유형: ${provider.natureOfDisaster}"),
                  Text("PM 번호: ${provider.pmNumber}"),
                  Text("재난 날짜: ${provider.dateOfDisaster?.toLocal().toString().split(' ')[0] ?? "없음"}"),
                  Text("성별: ${provider.gender}"),
                  const Divider(),

                  const Text("🦷 구강 정보", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("640: 기타 소견 - ${provider.otherFindings}"),
                  Text("645: 치열 유형 - ${provider.dentitionType}"),
                  Text("647: 나이 추정 - ${provider.ageMin ?? "?"} ~ ${provider.ageMax ?? "?"}"),
                  Text("650: 품질 확인 - 서명: ${provider.qualityCheckSignature}, 날짜: ${provider.qualityCheckDate?.toLocal().toString().split(" ")[0] ?? "없음"}"),
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
                    // ...provider.uploadedFiles.map((fileUrl) => InkWell(
                    //   onTap: () async {
                    //     final uri = Uri.parse(fileUrl);
                    //     if (await canLaunchUrl(uri)) {
                    //       await launchUrl(uri, mode: LaunchMode.externalApplication);
                    //     } else {
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //           const SnackBar(content: Text("파일 열기 실패")));
                    //     }
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 4.0),
                    //     child: Text(fileUrl, style: const TextStyle(color: Colors.blue)),
                    //   ),
                    // )),
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
                  onPressed: () => Navigator.pushReplacementNamed(context,'/dentalFindings'),
                  child: const Text("이전"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirebaseFirestore.instance
                          .collection('dental_data')
                          .add(provider.toMap());

                      provider.resetAll();

                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('최종 저장 완료')));
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/record',
                            (Route<dynamic> route) => false,
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('저장 실패: $e')));
                    }
                  },
                  child: const Text("최종 제출"),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
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
