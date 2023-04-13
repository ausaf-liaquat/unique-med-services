import 'package:flutter/material.dart';
import 'package:ums_staff/widgets/card/card.dart';
import '../../widgets/common/search_field.dart';
import '../../widgets/dataDisplay/shift.dart';
import 'details.dart';

class ShiftScreen extends StatelessWidget {
  const ShiftScreen({super.key});

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
              return const AppCard(
                path: ShiftDetailScreen.route,
                child: JobShift(),
              );
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
