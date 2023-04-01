import 'package:flutter/material.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Center(
        child: Text('Document page'),
      ),
    );
  }
}
