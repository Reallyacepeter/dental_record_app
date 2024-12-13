import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UnidentifiedHumanRemainsScreen extends StatefulWidget {
  final DocumentReference disasterRef;

  UnidentifiedHumanRemainsScreen({required this.disasterRef});

  @override
  _UnidentifiedHumanRemainsScreenState createState() =>
      _UnidentifiedHumanRemainsScreenState();
}

class _UnidentifiedHumanRemainsScreenState
    extends State<UnidentifiedHumanRemainsScreen> {
  final TextEditingController pmNoController = TextEditingController();
  final List<String> genderOptions = ['Male', 'Female', 'Other', 'Unknown'];
  String? selectedGender;
  final Map<int, String> odontology = {}; // 치아 상태 저장
  String? selectedBiteAndOcclusion;

  final List<String> biteAndOcclusionOptions = [
    'CBT',
    'DBT',
    'DIO',
    'EBT',
    'HBT',
    'MEO',
    'NOO',
    'OBT',
    'RBT',
    'SBT'
  ];

  void saveUnidentifiedHumanRemains() {
    if (pmNoController.text.isEmpty || selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in PM No and Gender.')),
      );
      return;
    }

    widget.disasterRef.collection('unidentifiedHumanRemains').add({
      'pmNo': int.parse(pmNoController.text),
      'gender': selectedGender,
      'odontology': odontology,
      'biteAndOcclusion': selectedBiteAndOcclusion,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data saved successfully!')),
    );
    Navigator.pop(context);
  }

  void showOdontologyDialog(int toothNumber) {
    TextEditingController findingController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tooth $toothNumber'),
          content: TextField(
            controller: findingController,
            decoration: InputDecoration(labelText: 'Dental Findings'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  odontology[toothNumber] = findingController.text;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Unidentified Human Remains')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: pmNoController,
              decoration: InputDecoration(labelText: 'PM No'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: selectedGender,
              hint: Text('Select Gender'),
              items: genderOptions
                  .map((gender) =>
                  DropdownMenuItem(value: gender, child: Text(gender)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              },
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                ),
                itemCount: 32,
                itemBuilder: (context, index) {
                  int toothNumber = index + 1;
                  return InkWell(
                    onTap: () => showOdontologyDialog(toothNumber),
                    child: Card(
                      child: Center(child: Text('Tooth $toothNumber')),
                    ),
                  );
                },
              ),
            ),
            DropdownButton<String>(
              value: selectedBiteAndOcclusion,
              hint: Text('Select Bite and Occlusion'),
              items: biteAndOcclusionOptions
                  .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedBiteAndOcclusion = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveUnidentifiedHumanRemains,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
