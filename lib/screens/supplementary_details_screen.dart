import 'package:flutter/material.dart';

class SupplementaryDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> arguments;

  const SupplementaryDetailsScreen({required this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Supplementary Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Supplementary Details", style: TextStyle(fontSize: 18)),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/additionalDetails', arguments: {
                      ...arguments,
                      'supplementaryDetails': "Additional data captured here...",
                    });
                  },
                  child: const Text("Next"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
