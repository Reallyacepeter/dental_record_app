// import 'package:flutter/material.dart';
//
// class DentalDataScreen extends StatefulWidget {
//   @override
//   _DentalDataScreenState createState() => _DentalDataScreenState();
// }
//
// class _DentalDataScreenState extends State<DentalDataScreen> {
//   // 데이터 저장 변수
//   final Map<int, Map<String, dynamic>> fdiToothData = {}; // FDI 번호별 데이터
//   String otherFindings = ""; // 기타 소견
//   String dentitionType = ""; // 치열 유형
//   int? ageMin; // 최소 나이
//   int? ageMax; // 최대 나이
//   String qualityCheckSignature = ""; // 품질 확인 서명
//   DateTime? qualityCheckDate; // 품질 확인 날짜
//
//   // 635번의 FDI 치아 번호
//   final List<int> fdiTeeth = [
//     14, 15, 18, 13, 21, 23, 22, 27, 16, 17, 12, 11, 24, 28,
//     45, 36, 26, 46, 48, 44, 35, 37, 32, 34, 33, 47, 42, 41, 25, 43, 31, 38
//   ];
//
//   // 사용자 입력 UI 생성
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('치과 데이터 입력 (635-650)')),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 635번: FDI 번호와 관련 데이터 입력
//             Text("635: 특정 데이터 (Specific Data)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Wrap(
//               spacing: 8.0,
//               runSpacing: 8.0,
//               children: fdiTeeth.map((tooth) {
//                 return ElevatedButton(
//                   onPressed: () => _showToothDialog(tooth),
//                   child: Text("FDI $tooth"),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 16),
//
//             // 640번: 기타 소견
//             Text("640: 기타 소견 (Other Findings)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             TextField(
//               maxLines: 3,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: "기타 소견을 입력하세요",
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   otherFindings = value;
//                 });
//               },
//             ),
//             SizedBox(height: 16),
//
//             // 645번: 치열 유형
//             Text("645: 치열 유형 (Type of Dentition)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             DropdownButton<String>(
//               value: dentitionType.isEmpty ? null : dentitionType,
//               hint: Text("치열 유형을 선택하세요"),
//               items: ["유치", "혼합 치열", "영구 치열"]
//                   .map((type) => DropdownMenuItem(
//                 value: type,
//                 child: Text(type),
//               ))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   dentitionType = value!;
//                 });
//               },
//             ),
//             SizedBox(height: 16),
//
//             // 647번: 나이 추정
//             Text("647: 나이 추정 (Age Estimation)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       labelText: "최소 나이",
//                       border: OutlineInputBorder(),
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         ageMin = int.tryParse(value);
//                       });
//                     },
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: TextField(
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       labelText: "최대 나이",
//                       border: OutlineInputBorder(),
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         ageMax = int.tryParse(value);
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//
//             // 650번: 품질 확인
//             Text("650: 품질 확인 (Quality Check)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: "서명",
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   qualityCheckSignature = value;
//                 });
//               },
//             ),
//             SizedBox(height: 8),
//             Row(
//               children: [
//                 Text("날짜: "),
//                 Text(qualityCheckDate == null ? "선택되지 않음" : "${qualityCheckDate!.toLocal()}".split(' ')[0]),
//                 Spacer(),
//                 ElevatedButton(
//                   onPressed: () async {
//                     DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(1900),
//                       lastDate: DateTime(2100),
//                     );
//                     if (pickedDate != null) {
//                       setState(() {
//                         qualityCheckDate = pickedDate;
//                       });
//                     }
//                   },
//                   child: Text("날짜 선택"),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//
//             // 저장 버튼
//             ElevatedButton(
//               onPressed: () {
//                 // 데이터를 저장하거나 제출
//                 _saveData();
//               },
//               child: Text("저장"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // FDI 치아 데이터 입력 다이얼로그
//   void _showToothDialog(int tooth) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         String detail = fdiToothData[tooth]?["detail"] ?? "";
//         return AlertDialog(
//           title: Text("FDI $tooth 데이터 입력"),
//           content: TextField(
//             maxLines: 3,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               labelText: "세부 정보를 입력하세요",
//             ),
//             onChanged: (value) {
//               detail = value;
//             },
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   fdiToothData[tooth] = {"detail": detail};
//                 });
//                 Navigator.pop(context);
//               },
//               child: Text("저장"),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text("취소"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   // 데이터 저장 함수
//   void _saveData() {
//     // 데이터 저장 로직 구현
//     print("FDI 데이터: $fdiToothData");
//     print("기타 소견: $otherFindings");
//     print("치열 유형: $dentitionType");
//     print("최소 나이: $ageMin, 최대 나이: $ageMax");
//     print("품질 확인 서명: $qualityCheckSignature");
//     print("품질 확인 날짜: $qualityCheckDate");
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/dental_data_provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class DentalDataScreen extends StatelessWidget {
//   final List<int> fdiTeeth = [
//     17, 16, 15, 14, 13, 12, 11,
//     21, 22, 23, 24, 25, 26, 27,
//     31, 32, 33, 34, 35, 36, 37,
//     47, 46, 45, 44, 43, 42, 41
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<DentalDataProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(title: Text('치과 데이터 입력 (635-650)')),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             // 635: FDI Data
//             Text("635: 특정 데이터 (Specific Data)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Wrap(
//               spacing: 8.0,
//               runSpacing: 8.0,
//               children: fdiTeeth.map((tooth) {
//                 return ElevatedButton(
//                   onPressed: () => _showToothDialog(context, provider, tooth),
//                   child: Text("FDI $tooth"),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 16),
//
//             // 640
//             Text("640: 기타 소견", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             TextField(
//               maxLines: 3,
//               decoration: InputDecoration(border: OutlineInputBorder(), labelText: "기타 소견"),
//               onChanged: provider.updateOtherFindings,
//             ),
//             SizedBox(height: 16),
//
//             // 645
//             Text("645: 치열 유형", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             DropdownButton<String>(
//               value: provider.dentitionType.isEmpty ? null : provider.dentitionType,
//               hint: Text("치열 유형 선택"),
//               items: ["유치", "혼합 치열", "영구 치열"].map((type) =>
//                   DropdownMenuItem(value: type, child: Text(type))
//               ).toList(),
//               onChanged: (String? value) {
//                 if (value != null) {
//                   provider.updateDentitionType(value);
//                 }
//               },
//             ),
//             SizedBox(height: 16),
//
//             // 647
//             Text("647: 나이 추정", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(labelText: "최소 나이", border: OutlineInputBorder()),
//                     onChanged: (val) => provider.updateAgeMin(int.tryParse(val)),
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: TextField(
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(labelText: "최대 나이", border: OutlineInputBorder()),
//                     onChanged: (val) => provider.updateAgeMax(int.tryParse(val)),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//
//             // 650
//             Text("650: 품질 확인", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             TextField(
//               decoration: InputDecoration(labelText: "서명", border: OutlineInputBorder()),
//               onChanged: provider.updateQualitySignature,
//             ),
//             SizedBox(height: 8),
//             Row(
//               children: [
//                 Text("날짜: "),
//                 Text(provider.qualityCheckDate == null
//                     ? "선택되지 않음"
//                     : "${provider.qualityCheckDate!.toLocal()}".split(' ')[0]),
//                 Spacer(),
//                 ElevatedButton(
//                   onPressed: () async {
//                     DateTime? picked = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(1900),
//                       lastDate: DateTime(2100),
//                     );
//                     if (picked != null) {
//                       provider.updateQualityDate(picked);
//                     }
//                   },
//                   child: Text("날짜 선택"),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//
//             // Buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => Navigator.pushNamed(context, '/dentalFindings'),
//                   child: Text("이전"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () => _saveToFirebase(context, provider),
//                   child: Text("저장"),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showToothDialog(BuildContext context, DentalDataProvider provider, int tooth) {
//     String detail = provider.fdiToothData[tooth]?['detail'] ?? '';
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("FDI $tooth 데이터 입력"),
//         content: TextField(
//           maxLines: 3,
//           decoration: InputDecoration(labelText: "세부 정보 입력", border: OutlineInputBorder()),
//           onChanged: (value) {
//             detail = value;
//           },
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               provider.updateToothDetail(tooth, detail);
//               Navigator.pop(context);
//             },
//             child: Text("저장"),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("취소"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _saveToFirebase(BuildContext context, DentalDataProvider provider) async {
//     try {
//       await FirebaseFirestore.instance.collection('dental_data').add(provider.toMap());
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('저장되었습니다.')));
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('저장 실패: $e')));
//     }
//   }
// }

// dental_data_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/dental_data_provider.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class DentalDataScreen extends StatelessWidget {
  const DentalDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<DentalDataProvider>();

    return Scaffold(
      appBar: const CommonAppBar(
        title: "640–650 : Dental Data",
        showRecordBadge: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 640: 기타 소견
          Text("640: 기타 소견", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: p.otherFindings,
            maxLines: 3,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "기타 소견",
            ),
            onChanged: p.updateOtherFindings,
          ),

          const SizedBox(height: 20),

          // 645: 치열 유형
          Text("645: 치열 유형", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: p.dentitionType.isEmpty ? null : p.dentitionType,
            decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "치열 유형 선택"),
            items: const [
              DropdownMenuItem(value: "유치", child: Text("유치")),
              DropdownMenuItem(value: "혼합 치열", child: Text("혼합 치열")),
              DropdownMenuItem(value: "영구 치열", child: Text("영구 치열")),
            ],
            onChanged: (v) => p.updateDentitionType(v ?? ''),
          ),

          const SizedBox(height: 20),

          // 647: 나이 추정
          Text("647: 나이 추정", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: p.ageMin?.toString() ?? '',
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "최소 나이", border: OutlineInputBorder()),
                  onChanged: (v) => p.updateAgeMin(int.tryParse(v)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  initialValue: p.ageMax?.toString() ?? '',
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "최대 나이", border: OutlineInputBorder()),
                  onChanged: (v) => p.updateAgeMax(int.tryParse(v)),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 650: 품질 확인
          Text("650: 품질 확인", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: p.qualityCheckSignature,
            decoration: const InputDecoration(labelText: "서명", border: OutlineInputBorder()),
            onChanged: p.updateQualitySignature,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text("날짜: "),
              Text(
                p.qualityCheckDate == null
                    ? "선택되지 않음"
                    : "${p.qualityCheckDate!.toLocal()}".split(' ')[0],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: p.qualityCheckDate ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) p.updateQualityDate(picked);
                },
                child: const Text("날짜 선택"),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // 이동 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/dentalFindings'),
                child: const Text("이전"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/finalReview'),
                child: const Text("다음"),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}


