import 'package:flutter/material.dart';

import '../../widgets/card/document.dart';
import '../../widgets/common/search_field.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const data = ['a', 'b', 'c', 'd'];

    return SingleChildScrollView(
        child: Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: Column(
        children: [
          const SearchField(),
          const SizedBox(height: 24),
          ListView.separated(
            itemCount: data.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return const DocumentCard();
              // for dinamic usage: data[index].value
            },
            separatorBuilder: (BuildContext context, int index) => Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: const Divider()),
          )
        ],
      ),
    ));
  }
}
