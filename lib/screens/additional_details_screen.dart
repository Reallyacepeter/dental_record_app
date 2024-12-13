import 'package:flutter/material.dart';

class AdditionalDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> arguments;

  const AdditionalDetailsScreen({required this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Additional Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Additional Observations", style: TextStyle(fontSize: 18)),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/finalReview', arguments: {
                      ...arguments,
                      'additionalDetails': "Miscellaneous details captured here...",
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
