import 'package:flutter/material.dart';
import 'package:ums_staff/core/http.dart';
import 'package:ums_staff/screens/shift/models.dart';
import 'package:ums_staff/widgets/card/card.dart';
import 'package:ums_staff/widgets/messages/snack_bar.dart';
import '../../widgets/inputs/search_field.dart';
import '../../widgets/dataDisplay/shift.dart';
import 'details.dart';

class ShiftScreen extends StatefulWidget {
  const ShiftScreen({super.key});

  @override
  State<ShiftScreen> createState() => _ShiftScreenState();
}

class _ShiftScreenState extends State<ShiftScreen> {
  bool loading = false;
  Iterable<ShiftModel> listShift = [];
  @override
  void initState() {
    super.initState();
    var http = HttpRequest();
    setState(() {
      loading = true;
    });
    http.shifts().then((value){
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
            listShift = ShiftModel.listShiftModels(docType);
          });
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    const data = ['a', 'b', 'c', 'd'];

    return SingleChildScrollView(
        child: Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: Column(
        children: [
          const SearchField(),
          const SizedBox(height: 24),
          loading ? const CircularProgressIndicator() : listShift.isEmpty ? const Center(
            child: Text("There is not shift available"),
          ):  ListView.separated(
            itemCount: listShift.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return AppCard(
                path: ShiftDetailScreen.route,
                args: { 'shiftModel': listShift.elementAt(index) },
                child: JobShift(shift: listShift.elementAt(index)),
              );
            },
            separatorBuilder: (BuildContext context, int index) => Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: const Divider()),
          )
        ],
      ),
    ));
  }
}
