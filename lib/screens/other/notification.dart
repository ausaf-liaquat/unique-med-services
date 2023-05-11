import 'package:flutter/material.dart';
import 'package:ums_staff/core/http.dart';
import '../../widgets/card/notification.dart';
import '../../widgets/messages/snack_bar.dart';
import '../../widgets/others/back_layout.dart';
import '../../widgets/inputs/search_field.dart';
import 'models/notification.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});
  static const route = '/notification';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> listNotification = [];
  bool loading = false;
  @override
  void initState() {
    super.initState();
    var http = HttpRequest();
    http.unreadNotification().then((value) {
      setState(() {
        loading = true;
      });
      http.unreadNotification().then((value) {

        if (!value.success) {
          SnackBarMessage.errorSnackbar(context, value.message);
        } else {
          http.readNotification().then((value) {
            setState(() {
              loading = false;
            });
            if (!value.success) {
              SnackBarMessage.errorSnackbar(context, value.message);
            } else {
              var docType = value.data['data'];
              if (docType != null) {
                setState(() {
                  listNotification = listNotification + NotificationModel.fromJson(docType);
                });
              }
            }
          });
          print(value.data['data']);
          var docType = value.data['data'];

          if (docType != null) {
            setState(() {
              listNotification = NotificationModel.fromJson(docType);
            });
          }
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return BackLayout(
      text: 'Notification',
      page: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        child: Column(
          children: [
            const SizedBox(height: 24),
            ListView.separated(
              itemCount: listNotification.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return NotificationCard(notification: listNotification[index]);
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
