import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/http.dart';
import '../../widgets/card/calendar.dart';
import '../../widgets/card/card.dart';
import '../../widgets/dataDisplay/shift.dart';
import '../../widgets/dataDisplay/typography.dart';
import '../../widgets/messages/snack_bar.dart';
import '../../widgets/others/link.dart';
import '../shift/models.dart';
import 'details.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  Iterable<ShiftModel> listShift = [];
  Iterable<ShiftModel> allListShift = [];
  bool loading = false;
  DateTime todate = DateTime.now();
  var timeSet = <String>{};
  void initState() {
    super.initState();
    var http = HttpRequest();
    setState(() {
      loading = true;
    });
    http.getAcceptShift().then((value){
      setState(() {
        loading = false;
      });
      if (!value.success) {
        SnackBarMessage.errorSnackbar(
            context, value.message);
      } else {
        var docType =value.data['data']['shifts'];
        if( docType != null ){
          setState(() {
            allListShift = ShiftModel.listShiftModels(docType);
            var dateset = <String>{};
            for (var e in allListShift) {
              dateset.add(e.date);
            }
            timeSet = dateset;
            listShift = allListShift.where((element) {
              return element.date == DateFormat('yyyy-MM-dd').format(todate);});
          });
        }
      }
    });
  }
  changeDate(date){
    setState(() {
      todate = date;
      listShift = allListShift.where((element) {
        return element.date == DateFormat('yyyy-MM-dd').format(date);});
    });
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            child: Column(
              children: [
                CalendarCard(focusedDay: todate, changeDate: changeDate, timeSet: timeSet ),
                const SizedBox(height: 24),
                AppCard(
                  child: Column(
                    children: [
                      AppTypography(
                        text: DateFormat('EEEE - MMM dd').format(todate),
                        size: 20,
                        color: Theme.of(context).colorScheme.secondary,
                        weight: FontWeight.w600,
                        spacing: 0.4,
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Divider(
                              color: Theme.of(context).colorScheme.secondary)),
                      ListView.separated(
                        itemCount: listShift.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return AppLink(
                              path: ScheduleDetailScreen.route,
                              params: {"shiftModel": listShift.elementAt(index)},
                              child: JobShift(accept: true, shift: listShift.elementAt(index),));
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: const Divider()),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
