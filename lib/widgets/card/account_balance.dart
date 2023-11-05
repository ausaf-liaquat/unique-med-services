import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ums_staff/core/http.dart';
import 'package:ums_staff/screens/auth/register/register_form.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../screens/other/w9_form/w9_form.dart';
import '../../screens/other/direct_deposit.dart';
import '../messages/snack_bar.dart';

class AccountBalance extends StatefulWidget {
  const AccountBalance({super.key});

  @override
  State<AccountBalance> createState() => _AccountBalanceState();
}

class _AccountBalanceState extends State<AccountBalance> {
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
          // Row(
          //   children: [
          //     AppTypography(
          //       text: 'My Account',
          //       size: 15,
          //       spacing: 0.44,
          //       color: AppColorScheme().black40,
          //     ),
          //     const SizedBox(width: 6),
          //     Chip(
          //       backgroundColor: AppColorScheme().black6,
          //       label: AppTypography(
          //         text: '0112345678',
          //         size: 13,
          //         spacing: 0.51,
          //         color: AppColorScheme().black50,
          //       ),
          //     )
          //   ],
          // ),
          // const SizedBox(height: 12),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Expanded(
          //         child: InkWell(
          //       onTap: () {
          //         setState(() {
          //           _balanceVisible = !_balanceVisible;
          //         });
          //       },
          //       child: AppTypography(
          //         overflow: TextOverflow.ellipsis,
          //         text: "\$54,292.79",
          //         size: 36,
          //         spacing: 0.39,
          //         weight: FontWeight.w500,
          //         color: AppColorScheme().black90,
          //       ),
          //     )),
          //     const SizedBox(width: 6),
          //     _balanceVisible
          //         ? const SizedBox()
          //         : Chip(
          //             backgroundColor: HexColor('#3CA442'),
          //             label: AppTypography(
          //               text: '+5.21%',
          //               size: 15,
          //               weight: FontWeight.w600,
          //               spacing: 0.44,
          //               color: AppColorScheme().black0,
          //             ),
          //           )
          //   ],
          // ),
          // const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.route);
                      },
                      child: const Text('Register'))),
              SizedBox(width: smallDevice ? 16 : 8),
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(context: context, builder: (BuildContext context){
                          return AlertDialog(
                          content: Container(
                            height: 230,
                            child: Column(
                              children: [
                                Image.asset('assets/images/stripe.png'),
                                const Text("Please wait try to login to strip account"),
                                const SizedBox(height: 15,),
                                const CircularProgressIndicator(),
                              ],
                            ),
                          ),
                          );
                        });
                        var http = HttpRequest();
                        http.getStripLogin().then((value) async {
                        if (value.success == true) {
                          await launchUrl( Uri.parse(value.data['data']['onboardingLink']) );
                          Navigator.pop(
                            context);
                      } else {
                          Navigator.pop(
                              context);
                        SnackBarMessage.errorSnackbar(
                        context, value.message);
                        }
                        });
                      }, child: const Text('Stripe')))
            ],
          )
        ],
      ),
    );
  }
}
