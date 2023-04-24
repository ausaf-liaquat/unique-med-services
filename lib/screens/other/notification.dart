import 'package:flutter/material.dart';
import '../../widgets/card/notification.dart';
import '../../widgets/others/back_layout.dart';
import '../../widgets/inputs/search_field.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  static const route = '/notification';

  @override
  Widget build(BuildContext context) {
    const data = ['a', 'b', 'c', 'd'];

    return BackLayout(
      text: 'Notification',
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
                return const NotificationCard();
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
