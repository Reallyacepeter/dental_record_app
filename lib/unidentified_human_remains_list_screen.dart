import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UnidentifiedHumanRemainsListScreen extends StatelessWidget {
  final String natureOfDisaster;

  UnidentifiedHumanRemainsListScreen({required this.natureOfDisaster});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details for $natureOfDisaster')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collectionGroup('unidentifiedHumanRemains')
            .where('natureOfDisaster', isEqualTo: natureOfDisaster) // 특정 재난 유형 필터링
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No records found for $natureOfDisaster.'));
          }

          final remains = snapshot.data!.docs;

          return ListView.builder(
            itemCount: remains.length,
            itemBuilder: (context, index) {
              final remain = remains[index];
              return Card(
                child: ListTile(
                  title: Text('PM No: ${remain['pmNo']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Gender: ${remain['gender']}'),
                      Text('Odontology: ${remain['odontology']}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
