import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ums_staff/core/http.dart';
import 'package:ums_staff/screens/shift/models.dart';
import 'package:ums_staff/widgets/messages/snack_bar.dart';
import '../../shared/theme/color.dart';
import '../../widgets/others/back_layout.dart';
import '../../widgets/dataDisplay/sub_title.dart';
import '../../widgets/dataDisplay/typography.dart';

class ShiftDetailScreen extends StatefulWidget {
  const ShiftDetailScreen({super.key});

  static const route = '/shift/123';

  @override
  State<ShiftDetailScreen> createState() => _ShiftDetailScreenState();
}

class _ShiftDetailScreenState extends State<ShiftDetailScreen> {
  bool loading = false;
  accept(String id, bool accept, BuildContext context) {
    var http = HttpRequest();
    setState(() {
      loading = true;
    });
    (accept ? http.shiftsAccept(id) : http.shiftsDecline(id)).then((value) {
      setState(() {
        loading = false;
      });
      if (!value.success) {
        SnackBarMessage.errorSnackbar(context, value.message);
      } else {
        if (accept) {
          SnackBarMessage.successSnackbar(context, 'Shift have been Accepted');
        } else {
          SnackBarMessage.waringSnackbar(context, 'Shift have been Rejected');
        }
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool smallDevice = MediaQuery.of(context).size.width >= 350;
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    var register = arguments['shiftModel'] ??
        ShiftModel(
            id: 1,
            title: '',
            createdAt: '',
            additionalComments: '',
            clinicianType: '',
            date: '',
            ratePerHour: '',
            shiftHour: '',
            shiftLocation: '',
            shiftNote: '',
            totalAmount: '',
            updatedAt: '',
            userId: '');
    var shiftNote = [];
    if (register.shiftNote != '') {
      shiftNote = (jsonDecode(register.shiftNote.toString()) as List<dynamic>).map((e) => e.toString()).toList();
    }
    return BackLayout(
      text: 'Shift Offer',
      page: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                AppTypography(text: register.title ?? '', size: 24, weight: FontWeight.w500),
                const SizedBox(height: 12),
                AppTypography(text: shiftNote.join(', '), color: AppColorScheme().black60, size: 17),
                const SizedBox(height: 24),
                SubTitle(title: 'Rate:', subTitle: register.ratePerHour, bottom: 24),
                SubTitle(title: 'Shift timing:', subTitle: register.shiftHour, bottom: 24),
                SubTitle(title: 'Shift Location:', subTitle: register.shiftLocation, bottom: 24),
                const SizedBox(height: 48),
                smallDevice
                    ? Row(
                        children: [
                          Expanded(
                              child: OutlinedButton.icon(
                                  onPressed: loading
                                      ? null
                                      : () {
                                          accept(register.id.toString(), false, context).then((value) {});
                                        },
                                  icon: const Icon(Icons.thumb_down_outlined),
                                  label: loading ? const CircularProgressIndicator() : const Text('Decline'))),
                          const SizedBox(width: 32),
                          Expanded(
                              child: ElevatedButton.icon(
                                  onPressed: loading
                                      ? null
                                      : () {
                                          accept(register.id.toString(), true, context);
                                        },
                                  icon: const Icon(Icons.thumb_up_outlined),
                                  label: loading ? const CircularProgressIndicator() : const Text('Accept'))),
                        ],
                      )
                    : Row(children: [
                        Expanded(
                            child: OutlinedButton(
                                onPressed: loading
                                    ? null
                                    : () {
                                        accept(register.id.toString(), false, context);
                                      },
                                child: loading ? const CircularProgressIndicator() : const Text('Decline'))),
                        const SizedBox(width: 32),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: loading
                                    ? null
                                    : () {
                                        accept(register.id.toString(), true, context);
                                      },
                                child: loading ? const CircularProgressIndicator() : const Text('Accept'))),
                      ])
              ]),
            )
          ],
        ),
      ),
    );
  }
}
