import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DentalRecordsPage extends StatelessWidget {
  final TextEditingController caseIdController = TextEditingController();
  final TextEditingController patientNameController = TextEditingController();
  final TextEditingController toothConditionController = TextEditingController();

  void saveRecord(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('dental_records').add({
        'case_id': caseIdController.text,
        'patient_name': patientNameController.text,
        'tooth_condition': toothConditionController.text,
        'timestamp': DateTime.now(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Record Saved!')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving record: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: caseIdController,
            decoration: InputDecoration(labelText: 'Case ID'),
          ),
          TextField(
            controller: patientNameController,
            decoration: InputDecoration(labelText: 'Patient Name'),
          ),
          TextField(
            controller: toothConditionController,
            decoration: InputDecoration(labelText: 'Tooth Condition'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => saveRecord(context),
            child: Text('Save Record'),
          ),
        ],
      ),
    );
  }
}
