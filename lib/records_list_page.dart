import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecordsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('dental_records').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No records found.'));
        }

        final records = snapshot.data!.docs;
        return ListView.builder(
          itemCount: records.length,
          itemBuilder: (context, index) {
            final record = records[index];
            return ListTile(
              title: Text('Case ID: ${record['case_id']}'),
              subtitle: Text('Patient: ${record['patient_name']}'),
            );
          },
        );
      },
    );
  }
}
