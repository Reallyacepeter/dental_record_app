import 'package:flutter/material.dart';
import '../widgets/common_app_bar.dart';

class RecordScreen extends StatefulWidget {
  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  final TextEditingController placeController = TextEditingController();
  final TextEditingController natureController = TextEditingController();
  final TextEditingController pmNoController = TextEditingController();
  DateTime? selectedDate;
  String? selectedGender; // 성별 변수
  final List<String> genderOptions = ['Male', 'Female', 'Other', 'Unknown']; // 성별 옵션

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
              TextField(
                controller: placeController,
                decoration: const InputDecoration(labelText: "Place of Disaster"),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: natureController,
                decoration: const InputDecoration(labelText: "Nature of Disaster"),
              ),
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
                decoration: const InputDecoration(
                  labelText: "Select Gender",
                ),
                value: selectedGender,
                items: genderOptions.map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  );
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

  void _goToMaterialsScreen() {
    if (placeController.text.isEmpty ||
        natureController.text.isEmpty ||
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
      'nature': natureController.text,
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
