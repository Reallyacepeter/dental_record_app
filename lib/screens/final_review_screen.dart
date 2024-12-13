import 'package:flutter/material.dart';

class FinalReviewScreen extends StatelessWidget {
  final Map<String, dynamic> arguments;

  const FinalReviewScreen({required this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Final Review")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Review and Submit", style: TextStyle(fontSize: 18)),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Logic to submit data to Firebase or backend here.
                    Navigator.popUntil(context, ModalRoute.withName('/record'));
                  },
                  child: const Text("Submit"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
