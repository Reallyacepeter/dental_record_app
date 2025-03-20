import 'package:flutter/material.dart';
import '../widgets/common_app_bar.dart';
import 'address_search_screen.dart'; // 주소 검색 화면 추가

class RecordScreen extends StatefulWidget {
  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  final TextEditingController placeController = TextEditingController();
  final TextEditingController customNatureController = TextEditingController(); // "Other" 선택 시 입력 필드
  final TextEditingController pmNoController = TextEditingController();

  DateTime? selectedDate;
  String? selectedGender;
  String? selectedNature; // 재난 유형 선택 값

  final List<String> genderOptions = ['Male', 'Female', 'Other', 'Unknown'];
  final List<String> disasterTypes = [
    "Earthquake", // 지진
    "Flood", // 홍수
    "Tsunami", // 쓰나미
    "Wildfire", // 산불
    "Hurricane / Typhoon", // 허리케인, 태풍
    "Fire", // 화재
    "Building Collapse", // 건물 붕괴
    "Transportation Accident", // 교통사고
    "Industrial / Chemical Accident", // 산업 / 화학사고
    "Other" // 기타 (직접 입력)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "기록"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _openAddressSearchScreen,
                child: AbsorbPointer(
                  child: TextField(
                    controller: placeController,
                    decoration: const InputDecoration(
                      labelText: "Place of Disaster",
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // 🔹 "Nature of Disaster" 드롭다운 추가
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Nature of Disaster"),
                value: selectedNature,
                items: disasterTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedNature = value;
                    if (value != "Other") {
                      customNatureController.clear(); // "Other"가 아니면 입력 필드 초기화
                    }
                  });
                },
              ),

              // 🔹 "Other" 선택 시 입력 필드 활성화
              if (selectedNature == "Other") ...[
                const SizedBox(height: 8),
                TextField(
                  controller: customNatureController,
                  decoration: const InputDecoration(labelText: "Specify Disaster Type"),
                ),
              ],

              const SizedBox(height: 8),
              TextField(
                controller: pmNoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "PM No"),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    selectedDate == null
                        ? "Date of Disaster: Not Selected"
                        : "Date of Disaster: ${selectedDate!.toLocal().toString().split(' ')[0]}",
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _pickDate,
                    child: const Text("Select Date"),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Select Gender"),
                value: selectedGender,
                items: genderOptions.map((gender) {
                  return DropdownMenuItem(value: gender, child: Text(gender));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              Center(
                child: ElevatedButton(
                  onPressed: _goToMaterialsScreen,
                  child: const Text("다음"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openAddressSearchScreen() async {
    final selectedAddress = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddressSearchScreen()),
    );

    if (selectedAddress != null && selectedAddress is String) {
      setState(() {
        placeController.text = selectedAddress;
      });
    }
  }

  void _goToMaterialsScreen() {
    String finalNature = selectedNature == "Other"
        ? customNatureController.text
        : selectedNature ?? "";

    if (placeController.text.isEmpty ||
        finalNature.isEmpty ||
        pmNoController.text.isEmpty ||
        selectedDate == null ||
        selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("모든 필드를 입력하세요.")),
      );
      return;
    }

    Navigator.pushNamed(context, '/materialsAvailable', arguments: {
      'place': placeController.text,
      'nature': finalNature,
      'pmNo': pmNoController.text,
      'date': selectedDate!.toIso8601String(),
      'gender': selectedGender.toString(),
    });
  }

  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
}
