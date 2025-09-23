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

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../widgets/common_app_bar.dart';
// import 'address_search_screen.dart'; // 더이상 사용 안 하지만, 혹시 다른 곳서 쓰면 남겨도 무방
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
//   final TextEditingController pmNoController = TextEditingController();
//   final TextEditingController amNoController = TextEditingController();
//
//   final List<String> genderOptions = const ['Male', 'Female', 'Other', 'Unknown'];
//
//   @override
//   void initState() {
//     super.initState();
//     final provider = Provider.of<DentalDataProvider>(context, listen: false);
//
//     pmNoController.text = provider.pmNumber;
//     pmNoController.addListener(() => provider.updatePmNumber(pmNoController.text));
//
//     amNoController.text = provider.amNumber;
//     amNoController.addListener(() => provider.updateAmNumber(amNoController.text));
//   }
//
//   @override
//   void dispose() {
//     pmNoController.dispose();
//     amNoController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<DentalDataProvider>();
//
//     return Scaffold(
//       appBar: const CommonAppBar(title: "기록"),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ✅ PM/AM에 따라 번호 입력 필드만 다르게 표시
//             if (provider.recordType == 'PM') ...[
//               TextField(
//                 controller: pmNoController,
//                 keyboardType: TextInputType.text,
//                 inputFormatters: [
//                   FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9-]')), // ✅ 대문자+숫자+하이픈만 허용
//                 ],
//                 textCapitalization: TextCapitalization.characters, // 입력 시 자동 대문자 변환
//                 decoration: const InputDecoration(
//                   labelText: "PM No (Post-mortem)",
//                   helperText: "사후 검체/개체 식별 번호",
//                 ),
//               ),
//             ] else ...[
//               TextField(
//                 controller: amNoController,
//                 keyboardType: TextInputType.text,
//                 inputFormatters: [
//                   FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9-]')),
//                 ],
//                 textCapitalization: TextCapitalization.characters,
//                 decoration: const InputDecoration(
//                   labelText: "AM No (Ante-mortem)",
//                   helperText: "생전 자료 식별 번호 (의무기록·치과기록 등)",
//                 ),
//               ),
//             ],
//
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 Text(
//                   provider.dateOfDisaster == null
//                       ? "Date of Disaster: Not Selected"
//                       : "Date: ${provider.dateOfDisaster!.toLocal().toString().split(' ')[0]}",
//                 ),
//                 const Spacer(),
//                 ElevatedButton(
//                   onPressed: () async {
//                     final picked = await showDatePicker(
//                       context: context,
//                       initialDate: provider.dateOfDisaster ?? DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2101),
//                     );
//                     if (picked != null) provider.updateDisasterDate(picked);
//                   },
//                   child: const Text("Select Date"),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 12),
//             DropdownButtonFormField<String>(
//               value: provider.gender.isEmpty ? null : provider.gender,
//               decoration: const InputDecoration(labelText: "Select Gender"),
//               items: genderOptions.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
//               onChanged: (val) => provider.updateGender(val ?? ''),
//             ),
//
//             const SizedBox(height: 24),
//             Row(
//               children: [
//                 // 이전 버튼
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     icon: const Icon(Icons.arrow_back),
//                     label: const Text("이전"),
//                     onPressed: () {
//                       // RecordSetupScreen으로 돌아가기
//                       Navigator.pushReplacementNamed(context, '/recordSetup');
//                       // 만약 RecordSetup → Record로 올 때 pushNamed를 썼다면 아래로 대체:
//                       // Navigator.pop(context);
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 // 다음 버튼
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     icon: const Icon(Icons.arrow_forward),
//                     label: const Text("다음"),
//                     onPressed: () {
//                       final isPm = provider.recordType == 'PM';
//                       final no = isPm ? pmNoController.text.trim() : amNoController.text.trim();
//
//                       if (no.isEmpty) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text(isPm ? 'PM No를 입력하세요.' : 'AM No를 입력하세요.')),
//                         );
//                         return;
//                       }
//
//                       Navigator.pushReplacementNamed(context, '/materialsAvailable');
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
//     );
//   }
// }

// lib/screens/record_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../widgets/common_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../providers/dental_data_provider.dart';

class RecordScreen extends StatefulWidget {
  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  final TextEditingController pmNoController = TextEditingController();
  final TextEditingController amNoController = TextEditingController();

  final FocusNode _pmFocus = FocusNode();
  final FocusNode _amFocus = FocusNode();

  // 현재 커스텀 키보드가 편집 중인 컨트롤러
  TextEditingController? _activeController;
  bool _showCustomKeyboard = false;

  // (선택) 길이 제한을 두고 싶으면 값을 0보다 크게 설정
  static const int _maxLen = 0; // 예: 20 으로 바꾸면 최대 20자 제한

  final List<String> genderOptions = const ['Male', 'Female', 'Other', 'Unknown'];

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<DentalDataProvider>(context, listen: false);

    // 초기 값 세팅 및 Provider 연동
    pmNoController.text = provider.pmNumber;
    pmNoController.addListener(() => provider.updatePmNumber(pmNoController.text));

    amNoController.text = provider.amNumber;
    amNoController.addListener(() => provider.updateAmNumber(amNoController.text));

    // 포커스 변화에 따라 커스텀 키보드 노출/숨김 및 활성 컨트롤러 지정
    _pmFocus.addListener(() {
      if (_pmFocus.hasFocus) {
        setState(() {
          _activeController = pmNoController;
          _showCustomKeyboard = true;
        });
      }
    });
    _amFocus.addListener(() {
      if (_amFocus.hasFocus) {
        setState(() {
          _activeController = amNoController;
          _showCustomKeyboard = true;
        });
      }
    });
  }

  @override
  void dispose() {
    pmNoController.dispose();
    amNoController.dispose();
    _pmFocus.dispose();
    _amFocus.dispose();
    super.dispose();
  }

  void _hideKeyboard() {
    setState(() => _showCustomKeyboard = false);
    _pmFocus.unfocus();
    _amFocus.unfocus();
  }

  // 커서 위치/선택영역을 고려해 텍스트 삽입
  void _insertText(String text) {
    final c = _activeController;
    if (c == null) return;
    final upper = text.toUpperCase();

    // 길이 제한이 있을 때 차단
    if (_maxLen > 0 && c.text.length >= _maxLen) return;

    final selection = c.selection;
    final full = c.text;
    final start = selection.start >= 0 ? selection.start : full.length;
    final end = selection.end >= 0 ? selection.end : full.length;

    final before = full.substring(0, start);
    final after = full.substring(end);
    final newText = before + upper + after;
    final caret = (before + upper).length;

    c.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: caret),
    );
  }

  // 백스페이스: 선택 영역이면 삭제, 아니면 커서 앞 한 글자 삭제
  void _backspace() {
    final c = _activeController;
    if (c == null) return;
    final selection = c.selection;
    final full = c.text;
    if (selection.start != selection.end) {
      // 선택영역 삭제
      final before = full.substring(0, selection.start);
      final after = full.substring(selection.end);
      final caret = before.length;
      c.value = TextEditingValue(
        text: before + after,
        selection: TextSelection.collapsed(offset: caret),
      );
    } else if (selection.start > 0) {
      final caret = selection.start - 1;
      final before = full.substring(0, caret);
      final after = full.substring(selection.end);
      c.value = TextEditingValue(
        text: before + after,
        selection: TextSelection.collapsed(offset: caret),
      );
    }
  }

  // 전체 지우기
  void _clearAll() {
    final c = _activeController;
    if (c == null) return;
    c.value = const TextEditingValue(
      text: '',
      selection: TextSelection.collapsed(offset: 0),
    );
  }

  // 공통 InputFormatter 목록
  List<TextInputFormatter> get _formatters {
    final list = <TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9-]')), // 허용 문자 필터
    ];
    if (_maxLen > 0) {
      list.add(LengthLimitingTextInputFormatter(_maxLen)); // (선택) 길이 제한
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DentalDataProvider>();

    return Scaffold(
      appBar: const CommonAppBar(title: "기록"),
      body: GestureDetector(
        // 빈 곳 탭 시 키보드 닫기 (커스텀 키보드 내 탭은 흡수되어 여기 안 옴)
        onTap: _hideKeyboard,
        behavior: HitTestBehavior.translucent,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ PM/AM에 따라 번호 입력 필드만 다르게 표시 (시스템 키보드 차단)
                    if (provider.recordType == 'PM') ...[
                      TextField(
                        controller: pmNoController,
                        focusNode: _pmFocus,
                        readOnly: true, // 시스템 키보드 차단
                        showCursor: true,
                        keyboardType: TextInputType.none,
                        inputFormatters: _formatters,
                        decoration: InputDecoration(
                          labelText: "PM No (Post-mortem)",
                          helperText: "영문 대문자(A–Z) + 숫자(0–9) + '-'만 입력",
                          // ✅ 한번에 지우기 버튼
                          suffixIcon: IconButton(
                            tooltip: '전체 지우기',
                            icon: const Icon(Icons.clear),
                            onPressed: _clearAll,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _activeController = pmNoController;
                            _showCustomKeyboard = true;
                          });
                        },
                      ),
                    ] else ...[
                      TextField(
                        controller: amNoController,
                        focusNode: _amFocus,
                        readOnly: true,
                        showCursor: true,
                        keyboardType: TextInputType.none,
                        inputFormatters: _formatters,
                        decoration: InputDecoration(
                          labelText: "AM No (Ante-mortem)",
                          helperText: "영문 대문자(A–Z) + 숫자(0–9) + '-'만 입력",
                          suffixIcon: IconButton(
                            tooltip: '전체 지우기',
                            icon: const Icon(Icons.clear),
                            onPressed: _clearAll,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _activeController = amNoController;
                            _showCustomKeyboard = true;
                          });
                        },
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
                      items: genderOptions
                          .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                          .toList(),
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
                              Navigator.pushReplacementNamed(context, '/recordSetup');
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
                              final no = isPm
                                  ? pmNoController.text.trim()
                                  : amNoController.text.trim();

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
                    const SizedBox(height: 12),
                    const SizedBox(height: 8), // 바닥 네비와 겹치지 않도록 여백
                  ],
                ),
              ),
            ),
            // ✅ 커스텀 키보드 (필드 포커스 시 표시)
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 160),
              crossFadeState: _showCustomKeyboard
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: _RestrictedKeyboard(
                onKey: _insertText,
                onBackspace: _backspace,
                onHide: _hideKeyboard,
                onClearAll: _clearAll, // ✅ 추가
              ),
              secondChild: const SizedBox.shrink(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}

/// 영문 대문자(A–Z) + 숫자(0–9) + '-' 전용 키보드
class _RestrictedKeyboard extends StatelessWidget {
  const _RestrictedKeyboard({
    required this.onKey,
    required this.onBackspace,
    required this.onHide,
    required this.onClearAll,
  });

  final void Function(String) onKey;
  final VoidCallback onBackspace;
  final VoidCallback onHide;
  final VoidCallback onClearAll;

  // 키 배열 (행 단위로 구성)
  List<List<String>> get _rows => const [
    // A–Z
    ['A','B','C','D','E','F','G','H','I','J'],
    ['K','L','M','N','O','P','Q','R','S','T'],
    ['U','V','W','X','Y','Z','0','1','2','3'],
    // 숫자 + 하이픈
    ['4','5','6','7','8','9','-'],
  ];

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isWide = media.size.width >= 600;
    final keyHeight = isWide ? 52.0 : 48.0;
    final keyTextStyle = TextStyle(
      fontSize: isWide ? 18 : 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    );

    return GestureDetector(
      // ✅ 키보드 영역 내 빈 공간 탭도 모두 흡수 (상위 onTap 전파 방지)
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      child: Material(
        elevation: 8,
        color: Theme.of(context).colorScheme.surface,
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 상단 액션바
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: SingleChildScrollView( // 가로 스크롤 허용
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // 타이틀은 늘어나면 말줄임
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 180), // 필요시 조정
                        child: Text(
                          "Restricted Keyboard",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: isWide ? 16 : 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // 전체 지우기
                      TextButton.icon(
                        onPressed: onClearAll,
                        icon: const Icon(Icons.delete_sweep_outlined, size: 18),
                        label: const Text('전체 지우기'),
                        style: TextButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: const Size(0, 32),
                        ),
                      ),
                      const SizedBox(width: 4),

                      // 백스페이스
                      IconButton(
                        tooltip: '지우기',
                        onPressed: onBackspace,
                        icon: const Icon(Icons.backspace_outlined, size: 20),
                        visualDensity: VisualDensity.compact,
                        constraints: const BoxConstraints.tightFor(width: 36, height: 32),
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(width: 4),

                      // 숨기기
                      TextButton.icon(
                        onPressed: onHide,
                        icon: const Icon(Icons.keyboard_hide, size: 18),
                        label: const Text('숨기기'),
                        style: TextButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: const Size(0, 32),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 키 행들
              ..._rows.map(
                    (row) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      for (final label in row) ...[
                        Expanded(
                          child: SizedBox(
                            height: keyHeight,
                            child: ElevatedButton(
                              onPressed: () => onKey(label),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(label, style: keyTextStyle),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                      ],
                      // 마지막 여백 제거용 더미
                      const SizedBox(width: 0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}


