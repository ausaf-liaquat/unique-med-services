import 'package:flutter/material.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';

import '../../screens/other/w9_form/w9_form.dart';
import '../../screens/other/direct_deposit.dart';

class AccountBalance extends StatefulWidget {
  const AccountBalance({super.key});

  @override
  State<AccountBalance> createState() => _AccountBalanceState();
}

class _AccountBalanceState extends State<AccountBalance> {
  bool _balanceVisible = false;

  @override
  Widget build(BuildContext context) {
    bool smallDevice = MediaQuery.of(context).size.width >= 350;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
          color: AppColorScheme().black0,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 6,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          borderRadius: const BorderRadius.all(
            Radius.circular(32),
          )),
      child: Column(
        children: [
          Row(
            children: [
              AppTypography(
                text: 'My Account',
                size: 15,
                spacing: 0.44,
                color: AppColorScheme().black40,
              ),
              const SizedBox(width: 6),
              Chip(
                backgroundColor: AppColorScheme().black6,
                label: AppTypography(
                  text: '0112345678',
                  size: 13,
                  spacing: 0.51,
                  color: AppColorScheme().black50,
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: InkWell(
                onTap: () {
                  setState(() {
                    _balanceVisible = !_balanceVisible;
                  });
                },
                child: AppTypography(
                  overflow: TextOverflow.ellipsis,
                  text: "\$54,292.79",
                  size: 36,
                  spacing: 0.39,
                  weight: FontWeight.w500,
                  color: AppColorScheme().black90,
                ),
              )),
              const SizedBox(width: 6),
              _balanceVisible
                  ? const SizedBox()
                  : Chip(
                      backgroundColor: HexColor('#3CA442'),
                      label: AppTypography(
                        text: '+5.21%',
                        size: 15,
                        weight: FontWeight.w600,
                        spacing: 0.44,
                        color: AppColorScheme().black0,
                      ),
                    )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, W9FormScreen.route);
                      },
                      child: Text(smallDevice ? 'W-9 form' : 'W-9'))),
              SizedBox(width: smallDevice ? 16 : 8),
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, DirectDepositScreen.route);
                      },
                      child: const Text('Deposit')))
            ],
          )
        ],
      ),
    );
  }
}
