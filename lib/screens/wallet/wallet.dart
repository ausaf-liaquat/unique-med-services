import 'package:flutter/material.dart';
import 'package:ums_staff/screens/wallet/payout_avtivity.dart';
import 'package:ums_staff/screens/wallet/payout_detail.dart';
import 'package:ums_staff/widgets/common/link.dart';
import 'package:ums_staff/widgets/dataDisplay/payout.dart';

import '../../widgets/card/account_balance.dart';
import '../../widgets/card/card.dart';
import '../../widgets/dataDisplay/typography.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const data = ['a', 'b', 'c', 'd'];

    return SingleChildScrollView(
        child: Container(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
      child: Column(
        children: [
          const AccountBalance(),
          const SizedBox(height: 32),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppTypography(
                    text: 'Payout Activity',
                    size: 24,
                    spacing: 0.34,
                    weight: FontWeight.w600),
                const SizedBox(height: 28),
                ListView.separated(
                  itemCount: data.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return const AppLink(
                      path: PayoutDetailScreen.route,
                      child: Payout(),
                    );
                    // for dinamic usage: data[index].value
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: const Divider()),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, PayoutActivtyScreen.route);
                      },
                      child: const Text('SEE ALL ')),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
