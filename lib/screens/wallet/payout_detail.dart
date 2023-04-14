import 'package:flutter/material.dart';
import 'package:ums_staff/widgets/card/card.dart';
import 'package:ums_staff/widgets/dataDisplay/shift.dart';
import '../../widgets/card/payout_detail.dart';
import '../../widgets/common/back_layout.dart';

class PayoutDetailScreen extends StatelessWidget {
  const PayoutDetailScreen({super.key});
  static const route = '/payout-detail';

  @override
  Widget build(BuildContext context) {
    return BackLayout(
      text: 'Payout Detail',
      page: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
          child: Column(
            children: [
              const PayoutDetailCard(),
              const SizedBox(height: 32),
              AppCard(
                  child: Column(
                children: [
                  const JobShift(),
                  const SizedBox(height: 24),
                  TextButton(
                      onPressed: () {}, child: const Text('SEE SHIFT DETAIL'))
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
