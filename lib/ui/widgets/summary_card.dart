import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final int number;
  final String title;

  const SummaryCard({
    Key? key, // Added Key? type
    required this.number,
    required this.title, // Added required keyword
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              '$number',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
