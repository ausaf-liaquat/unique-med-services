import 'package:flutter/material.dart';

class Step1 extends StatelessWidget {
  const Step1({super.key, required this.onSelect, required this.fieldsError});
  final void Function(String, String) onSelect;
  final String? Function(String) fieldsError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [],
    );
  }
}

class Step2 extends StatelessWidget {
  const Step2({super.key, required this.onSelect, required this.fieldsError});
  final void Function(String, String) onSelect;
  final String? Function(String) fieldsError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [],
    );
  }
}
