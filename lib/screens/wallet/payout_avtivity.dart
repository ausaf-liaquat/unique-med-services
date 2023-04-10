import 'package:flutter/material.dart';
import '../../widgets/card/card.dart';
import '../../widgets/common/back_layout.dart';
import '../../widgets/common/search_field.dart';
import '../../widgets/dataDisplay/payout.dart';

class PayoutActivtyScreen extends StatelessWidget {
  const PayoutActivtyScreen({super.key});
  static const route = '/payout-activity';

  @override
  Widget build(BuildContext context) {
    const data = ['a', 'b', 'c', 'd'];

    return BackLayout(
      text: 'Payout Activity',
      page: SingleChildScrollView(
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Payout(),
                );
                // for dinamic usage: data[index].value
              },
              separatorBuilder: (BuildContext context, int index) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const Divider()),
            )
          ],
        ),
      )),
    );
  }
}
