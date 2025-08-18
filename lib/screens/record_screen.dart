// import 'package:flutter/material.dart';
// import '../widgets/common_app_bar.dart';
// import 'address_search_screen.dart'; // 주소 검색 화면 추가
// import 'package:provider/provider.dart';
// import '../providers/dental_data_provider.dart';
//
// class RecordScreen extends StatefulWidget {
//   @override
//   _RecordScreenState createState() => _RecordScreenState();
// }
//
// class _RecordScreenState extends State<RecordScreen> {
//   final TextEditingController placeController = TextEditingController();
//   final TextEditingController customNatureController = TextEditingController(); // "Other" 선택 시 입력 필드
//   final TextEditingController pmNoController = TextEditingController();
//
//   DateTime? selectedDate;
//   String? selectedGender;
//   String? selectedNature; // 재난 유형 선택 값
//
//   final List<String> genderOptions = ['Male', 'Female', 'Other', 'Unknown'];
//   final List<String> disasterTypes = [
//     "Earthquake", // 지진
//     "Flood", // 홍수
//     "Tsunami", // 쓰나미
//     "Wildfire", // 산불
//     "Hurricane / Typhoon", // 허리케인, 태풍
//     "Fire", // 화재
//     "Building Collapse", // 건물 붕괴
//     "Transportation Accident", // 교통사고
//     "Industrial / Chemical Accident", // 산업 / 화학사고
//     "Other" // 기타 (직접 입력)
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<DentalDataProvider>(context);
//
//     return Scaffold(
//       appBar: CommonAppBar(title: "기록"),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GestureDetector(
//                 onTap: () => _openAddressSearchScreen(context, provider),
//                 child: AbsorbPointer(
//                   child: TextField(
//                     controller: TextEditingController(text: provider.placeOfDisaster),
//                     decoration: const InputDecoration(
//                       labelText: "Place of Disaster",
//                       suffixIcon: Icon(Icons.search),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//
//               // Nature Dropdown
//               DropdownButtonFormField<String>(
//                 value: provider.natureOfDisaster.isEmpty ? null : provider.natureOfDisaster,
//                 decoration: const InputDecoration(labelText: "Nature of Disaster"),
//                 items: disasterTypes.map((type) =>
//                     DropdownMenuItem(value: type, child: Text(type))
//                 ).toList(),
//                 onChanged: (val) {
//                   provider.updateNature(val ?? '');
//                 },
//               ),
//
//               const SizedBox(height: 8),
//               TextField(
//                 controller: TextEditingController(text: provider.pmNumber),
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(labelText: "PM No"),
//                 onChanged: provider.updatePmNumber,
//               ),
//
//               const SizedBox(height: 8),
//               Row(
//                 children: [
//                   Text(
//                     provider.dateOfDisaster == null
//                         ? "Date of Disaster: Not Selected"
//                         : "Date: ${provider.dateOfDisaster!.toLocal().toString().split(' ')[0]}",
//                   ),
//                   const Spacer(),
//                   ElevatedButton(
//                     onPressed: () => _pickDate(context, provider),
//                     child: const Text("Select Date"),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 8),
//               DropdownButtonFormField<String>(
//                 value: provider.gender.isEmpty ? null : provider.gender,
//                 decoration: const InputDecoration(labelText: "Select Gender"),
//                 items: genderOptions.map((g) =>
//                     DropdownMenuItem(value: g, child: Text(g))
//                 ).toList(),
//                 onChanged: (val) => provider.updateGender(val ?? ''),
//               ),
//
//               const SizedBox(height: 16),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () => _goToNext(context, provider),
//                   child: const Text("다음"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _openAddressSearchScreen(BuildContext context, DentalDataProvider provider) async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => AddressSearchScreen()),
//     );
//
//     if (result is String) {
//       provider.updatePlace(result);
//     }
//   }
//
//   void _pickDate(BuildContext context, DentalDataProvider provider) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: provider.dateOfDisaster ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       provider.updateDisasterDate(picked);
//     }
//   }
//
//   void _goToNext(BuildContext context, DentalDataProvider provider) {
//     if (provider.placeOfDisaster.isEmpty ||
//         provider.natureOfDisaster.isEmpty ||
//         provider.pmNumber.isEmpty ||
//         provider.dateOfDisaster == null ||
//         provider.gender.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("모든 필드를 입력하세요.")),
//       );
//       return;
//     }
//     Navigator.pushReplacementNamed(context, '/materialsAvailable');
//   }
// }

// import 'package:flutter/material.dart';
// import '../widgets/common_app_bar.dart';
// import 'address_search_screen.dart';
// import 'package:provider/provider.dart';
// import '../providers/dental_data_provider.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
//
// class RecordScreen extends StatefulWidget {
//   @override
//   _RecordScreenState createState() => _RecordScreenState();
// }
//
// class _RecordScreenState extends State<RecordScreen> {
//   final TextEditingController placeController = TextEditingController();
//   final TextEditingController customNatureController = TextEditingController();
//   final TextEditingController pmNoController = TextEditingController();
//
//   DateTime? selectedDate;
//   String? selectedGender;
//   String? selectedNature;
//
//   final List<String> genderOptions = ['Male', 'Female', 'Other', 'Unknown'];
//   final List<String> disasterTypes = [
//     "Earthquake",
//     "Flood",
//     "Tsunami",
//     "Wildfire",
//     "Hurricane / Typhoon",
//     "Fire",
//     "Building Collapse",
//     "Transportation Accident",
//     "Industrial / Chemical Accident",
//     "Other"
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     final provider = Provider.of<DentalDataProvider>(context, listen: false);
//     pmNoController.text = provider.pmNumber;
//     pmNoController.addListener(() {
//       provider.updatePmNumber(pmNoController.text);
//     });
//   }
//
//   @override
//   void dispose() {
//     pmNoController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<DentalDataProvider>(context);
//
//     return Scaffold(
//       appBar: CommonAppBar(title: "기록"),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GestureDetector(
//                 onTap: () => _openAddressSearchScreen(context, provider),
//                 child: AbsorbPointer(
//                   child: TextField(
//                     controller: TextEditingController(text: provider.placeOfDisaster),
//                     decoration: const InputDecoration(
//                       labelText: "Place of Disaster",
//                       suffixIcon: Icon(Icons.search),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//
//               DropdownButtonFormField<String>(
//                 value: provider.natureOfDisaster.isEmpty ? null : provider.natureOfDisaster,
//                 decoration: const InputDecoration(labelText: "Nature of Disaster"),
//                 items: disasterTypes.map((type) =>
//                     DropdownMenuItem(value: type, child: Text(type))
//                 ).toList(),
//                 onChanged: (val) {
//                   provider.updateNature(val ?? '');
//                 },
//               ),
//
//               const SizedBox(height: 8),
//               TextField(
//                 controller: pmNoController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(labelText: "PM No"),
//               ),
//
//               const SizedBox(height: 8),
//               Row(
//                 children: [
//                   Text(
//                     provider.dateOfDisaster == null
//                         ? "Date of Disaster: Not Selected"
//                         : "Date: ${provider.dateOfDisaster!.toLocal().toString().split(' ')[0]}",
//                   ),
//                   const Spacer(),
//                   ElevatedButton(
//                     onPressed: () => _pickDate(context, provider),
//                     child: const Text("Select Date"),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 8),
//               DropdownButtonFormField<String>(
//                 value: provider.gender.isEmpty ? null : provider.gender,
//                 decoration: const InputDecoration(labelText: "Select Gender"),
//                 items: genderOptions.map((g) =>
//                     DropdownMenuItem(value: g, child: Text(g))
//                 ).toList(),
//                 onChanged: (val) => provider.updateGender(val ?? ''),
//               ),
//
//               const SizedBox(height: 16),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () => _goToNext(context, provider),
//                   child: const Text("다음"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
//     );
//   }
//
//   void _openAddressSearchScreen(BuildContext context, DentalDataProvider provider) async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => AddressSearchScreen()),
//     );
//
//     if (result is String) {
//       provider.updatePlace(result);
//     }
//   }
//
//   void _pickDate(BuildContext context, DentalDataProvider provider) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: provider.dateOfDisaster ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       provider.updateDisasterDate(picked);
//     }
//   }
//
//   void _goToNext(BuildContext context, DentalDataProvider provider) {
//     if (provider.placeOfDisaster.isEmpty ||
//         provider.natureOfDisaster.isEmpty ||
//         provider.pmNumber.isEmpty ||
//         provider.dateOfDisaster == null ||
//         provider.gender.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("모든 필드를 입력하세요.")),
//       );
//       return;
//     }
//     Navigator.pushReplacementNamed(context, '/materialsAvailable');
//   }
// }

// import 'package:flutter/material.dart';
// import '../widgets/common_app_bar.dart';
// import 'address_search_screen.dart';
// import 'package:provider/provider.dart';
// import '../providers/dental_data_provider.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
//
// class RecordScreen extends StatefulWidget {
//   @override
//   _RecordScreenState createState() => _RecordScreenState();
// }
//
// class _RecordScreenState extends State<RecordScreen> {
//   final TextEditingController placeController = TextEditingController();
//   final TextEditingController pmNoController = TextEditingController();
//
//   final List<String> genderOptions = ['Male', 'Female', 'Other', 'Unknown'];
//   final List<String> disasterTypes = [
//     "Earthquake",
//     "Flood",
//     "Tsunami",
//     "Wildfire",
//     "Hurricane / Typhoon",
//     "Fire",
//     "Building Collapse",
//     "Transportation Accident",
//     "Industrial / Chemical Accident",
//     "Other"
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     final provider = Provider.of<DentalDataProvider>(context, listen: false);
//     pmNoController.text = provider.pmNumber;
//     pmNoController.addListener(() {
//       provider.updatePmNumber(pmNoController.text);
//     });
//   }
//
//   @override
//   void dispose() {
//     pmNoController.dispose();
//     placeController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<DentalDataProvider>(context);
//     final locked = provider.incidentLockEnabled;
//
//     // 표시용 컨트롤러 동기화 (잠금이면 고정값, 아니면 일반값)
//     placeController.text = provider.placeForUi;
//
//     return Scaffold(
//       appBar: CommonAppBar(title: "기록"),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (locked)
//                 Container(
//                   width: double.infinity,
//                   margin: const EdgeInsets.only(bottom: 12),
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.amber.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: Colors.amber),
//                   ),
//                   child: Text(
//                     "대형 사건 모드: Place='${provider.lockedPlace}', Nature='${provider.lockedNature}' 로 고정.",
//                     style: const TextStyle(fontWeight: FontWeight.w600),
//                   ),
//                 ),
//
//               // Place of Disaster (잠금 시 검색 불가 + 읽기 전용)
//               GestureDetector(
//                 onTap: locked ? null : () => _openAddressSearchScreen(context, provider),
//                 child: AbsorbPointer(
//                   child: TextField(
//                     controller: placeController,
//                     readOnly: true,
//                     decoration: InputDecoration(
//                       labelText: "Place of Disaster",
//                       suffixIcon: Icon(locked ? Icons.lock : Icons.search),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//
//               // Nature of Disaster (잠금 시 드롭다운 비활성)
//               DropdownButtonFormField<String>(
//                 value: provider.natureForUi.isEmpty ? null : provider.natureForUi,
//                 decoration: InputDecoration(
//                   labelText: "Nature of Disaster",
//                   suffixIcon: Icon(locked ? Icons.lock : Icons.arrow_drop_down),
//                 ),
//                 items: disasterTypes
//                     .map((type) => DropdownMenuItem(value: type, child: Text(type)))
//                     .toList(),
//                 onChanged: locked
//                     ? null
//                     : (val) {
//                   provider.updateNature(val ?? '');
//                 },
//               ),
//
//               const SizedBox(height: 8),
//               TextField(
//                 controller: pmNoController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(labelText: "PM No"),
//               ),
//
//               const SizedBox(height: 8),
//               Row(
//                 children: [
//                   Text(
//                     provider.dateOfDisaster == null
//                         ? "Date of Disaster: Not Selected"
//                         : "Date: ${provider.dateOfDisaster!.toLocal().toString().split(' ')[0]}",
//                   ),
//                   const Spacer(),
//                   ElevatedButton(
//                     onPressed: () => _pickDate(context, provider),
//                     child: const Text("Select Date"),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 8),
//               DropdownButtonFormField<String>(
//                 value: provider.gender.isEmpty ? null : provider.gender,
//                 decoration: const InputDecoration(labelText: "Select Gender"),
//                 items: genderOptions
//                     .map((g) => DropdownMenuItem(value: g, child: Text(g)))
//                     .toList(),
//                 onChanged: (val) => provider.updateGender(val ?? ''),
//               ),
//
//               const SizedBox(height: 16),
//               Center(
//                 child: ElevatedButton(
//                   // ✅ 검증 제거: 비어 있어도 다음으로 이동
//                   onPressed: () => Navigator.pushReplacementNamed(context, '/materialsAvailable'),
//                   child: const Text("다음"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
//     );
//   }
//
//   void _openAddressSearchScreen(BuildContext context, DentalDataProvider provider) async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => AddressSearchScreen()),
//     );
//     if (result is String) {
//       provider.updatePlace(result);
//     }
//   }
//
//   void _pickDate(BuildContext context, DentalDataProvider provider) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: provider.dateOfDisaster ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       provider.updateDisasterDate(picked);
//     }
//   }
// }

import 'package:flutter/material.dart';
import '../widgets/common_app_bar.dart';
import 'address_search_screen.dart'; // 더이상 사용 안 하지만, 혹시 다른 곳서 쓰면 남겨도 무방
import 'package:provider/provider.dart';
import '../providers/dental_data_provider.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class RecordScreen extends StatefulWidget {
  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  final TextEditingController pmNoController = TextEditingController();
  final TextEditingController amNoController = TextEditingController();

  final List<String> genderOptions = const ['Male', 'Female', 'Other', 'Unknown'];

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<DentalDataProvider>(context, listen: false);

    pmNoController.text = provider.pmNumber;
    pmNoController.addListener(() => provider.updatePmNumber(pmNoController.text));

    amNoController.text = provider.amNumber;
    amNoController.addListener(() => provider.updateAmNumber(amNoController.text));
  }

  @override
  void dispose() {
    pmNoController.dispose();
    amNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DentalDataProvider>();

    return Scaffold(
      appBar: const CommonAppBar(title: "기록"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ PM/AM에 따라 번호 입력 필드만 다르게 표시
            if (provider.recordType == 'PM') ...[
              TextField(
                controller: pmNoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "PM No (Post-mortem)",
                  helperText: "사후 검체/개체 식별 번호",
                ),
              ),
            ] else ...[
              TextField(
                controller: amNoController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "AM No (Ante-mortem)",
                  helperText: "생전 자료 식별 번호 (의무기록·치과기록 등)",
                ),
              ),
            ],

            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  provider.dateOfDisaster == null
                      ? "Date of Disaster: Not Selected"
                      : "Date: ${provider.dateOfDisaster!.toLocal().toString().split(' ')[0]}",
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: provider.dateOfDisaster ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null) provider.updateDisasterDate(picked);
                  },
                  child: const Text("Select Date"),
                ),
              ],
            ),

            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: provider.gender.isEmpty ? null : provider.gender,
              decoration: const InputDecoration(labelText: "Select Gender"),
              items: genderOptions.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
              onChanged: (val) => provider.updateGender(val ?? ''),
            ),

            const SizedBox(height: 24),
            Row(
              children: [
                // 이전 버튼
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_back),
                    label: const Text("이전"),
                    onPressed: () {
                      // RecordSetupScreen으로 돌아가기
                      Navigator.pushReplacementNamed(context, '/recordSetup');
                      // 만약 RecordSetup → Record로 올 때 pushNamed를 썼다면 아래로 대체:
                      // Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                // 다음 버튼
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text("다음"),
                    onPressed: () {
                      final isPm = provider.recordType == 'PM';
                      final no = isPm ? pmNoController.text.trim() : amNoController.text.trim();

                      if (no.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(isPm ? 'PM No를 입력하세요.' : 'AM No를 입력하세요.')),
                        );
                        return;
                      }

                      Navigator.pushReplacementNamed(context, '/materialsAvailable');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}

