import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("조회"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('disasterDetails')
              .orderBy('savedAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final documents = snapshot.data!.docs;

            if (documents.isEmpty) {
              return const Center(child: Text("No records found."));
            }

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final data = documents[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['placeOfDisaster'] ?? 'Unknown'),
                  subtitle: Text(data['dateOfDisaster'] ?? 'Unknown'),
                  onTap: () {
                    // 상세화면 또는 수정화면으로 이동
                    Navigator.pushNamed(context, '/record', arguments: data);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
