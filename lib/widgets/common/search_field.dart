import 'package:flutter/material.dart';

import '../../shared/theme/color.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: 'Enter Keyword...',
          fillColor: AppColorScheme().black6,
          contentPadding: const EdgeInsets.symmetric(vertical: 13),
          prefixIcon: Container(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: const Icon(
                Icons.search_rounded,
                size: 26,
              )),
          border: UnderlineInputBorder(borderRadius: BorderRadius.circular(8)),
          enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.transparent))),
    );
  }
}
