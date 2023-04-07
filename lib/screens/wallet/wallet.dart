import 'package:flutter/material.dart';

import '../../widgets/card/account_balance.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
      child: Column(
        children: const [
          AccountBalance(),
          SizedBox(height: 32),
        ],
      ),
    ));
  }
}
