import 'package:flutter/material.dart';

class DentalFindingsScreen extends StatelessWidget {
  final Map<String, dynamic> arguments;

  const DentalFindingsScreen({required this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dental Findings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Dental Findings Details", style: TextStyle(fontSize: 18)),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/supplementaryDetails', arguments: {
                      ...arguments,
                      'dentalFindings': "Details about dental findings here...",
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
