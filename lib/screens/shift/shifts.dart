import 'package:flutter/material.dart';
import 'package:ums_staff/core/http.dart';
import 'package:ums_staff/screens/shift/models.dart';
import 'package:ums_staff/widgets/card/card.dart';
import 'package:ums_staff/widgets/messages/snack_bar.dart';
import '../../widgets/dataDisplay/typography.dart';
import '../../widgets/inputs/search_field.dart';
import '../../widgets/dataDisplay/shift.dart';
import '../../widgets/skeleton/shift.dart';
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
    http.shifts().then((value) {
      setState(() {
        loading = false;
      });
      if (!value.success) {
        SnackBarMessage.errorSnackbar(context, value.message);
      } else {
        var docType = value.data['data']['shifts'];
        print("UUUUUUUUUUUUUUUUUUUUUUUUUUUU $docType");
        if (docType != null) {
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
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 32),
      child: Column(
        children: [
          // const SearchField(),
          const SizedBox(height: 24),
          loading
              ? ListView.separated(
                  itemCount: 3,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return const AppCard(child: ShiftSkeleton());
                  },
                  separatorBuilder: (BuildContext context, int index) => Container(padding: const EdgeInsets.symmetric(vertical: 16), child: const Divider()),
                )
              : listShift.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          Image.asset(
                            'assets/images/no-shift.png',
                            width: 280,
                          ),
                          const SizedBox(height: 20),
                          const AppTypography(text: 'No Shift Found!', size: 18)
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              padding: EdgeInsets.all(0),
                              icon: const Icon(Icons.filter_alt_outlined),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.close),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    var http = HttpRequest();
                                                    http.shifts().then((value) {
                                                      setState(() {
                                                        loading = true;
                                                      });
                                                      http.shifts().then((value) {
                                                        if (!value.success) {
                                                          SnackBarMessage.errorSnackbar(context, value.message);
                                                        } else {
                                                          Navigator.pop(context);
                                                          var docType = value.data['data']['shifts'];

                                                          if (docType != null) {
                                                            setState(() {
                                                              listShift = ShiftModel.listShiftModels(docType);
                                                            
                                                            });
                                                          }
                                                        }
                                                      });
                                                    });
                                                  },
                                                  child: Text("Remove Filter", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue))),
                                            ],
                                          ),
                                          Text("Filter By Date :", style: TextStyle(fontSize: 16)),
                                          ListTile(
                                            leading: Icon(Icons.filter_alt_outlined, color: Colors.blue),
                                            title: Text("Select Date"),
                                            onTap: () {},
                                          ),
                                          SizedBox(height: 16),
                                          Text("Filter By Type :", style: TextStyle(fontSize: 16)),
                                          ...["CNA", "PST", "PCT", "PT", "OT", "RT", "EKG Technician", "LPN", "RN", "ARNP"]
                                              .map((type) => ListTile(
                                                    leading: Icon(Icons.filter_alt_outlined, color: Colors.blue),
                                                    title: Text(type),
                                                    onTap: () {
                                                      var http = HttpRequest();
                                                      http
                                                          .shiftFilters(
                                                        type: type,
                                                      )
                                                          .then((value) {
                                                        if (!value.success) {
                                                          SnackBarMessage.errorSnackbar(context, value.message);
                                                        } else {
                                                          Navigator.pop(context);
                                                          var docType = value.data['data'];
                                                          print("JJJJJJJJJJJJJJJJJJJJJJJ $docType");

                                                          if (docType != null) {
                                                            setState(() {
                                                              listShift = ShiftModel.listShiftModels(docType);
                                                            });
                                                          }
                                                        }
                                                      });
                                                    },
                                                  ))
                                              .toList(),
                                          SizedBox(height: 16),
                                          Text("Filter By Time :", style: TextStyle(fontSize: 16)),
                                          ...["7a-3p (8hrs)", "3p-11p (8hrs)", "6:45a-3:15p (8.5hrs)"]
                                              .map((time) => ListTile(
                                                    leading: Icon(Icons.filter_alt_outlined, color: Colors.blue),
                                                    title: Text(time),
                                                    onTap: () {
                                                      var http = HttpRequest();
                                                      http
                                                          .shiftFilters(
                                                        shift_hour: time,
                                                      )
                                                          .then((value) {
                                                        if (!value.success) {
                                                          SnackBarMessage.errorSnackbar(context, value.message);
                                                        } else {
                                                          Navigator.pop(context);
                                                          var docType = value.data['data'];

                                                          if (docType != null) {
                                                            setState(() {
                                                              listShift = ShiftModel.listShiftModels(docType);
                                                            });
                                                          }
                                                        }
                                                      });
                                                    },
                                                  ))
                                              .toList(),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        ListView.separated(
                          itemCount: listShift.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return AppCard(
                              path: ShiftDetailScreen.route,
                              args: {'shiftModel': listShift.elementAt(index)},
                              child: JobShift(shift: listShift.elementAt(index)),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => Container(padding: const EdgeInsets.symmetric(vertical: 16), child: const Divider()),
                        ),
                      ],
                    )
        ],
      ),
    ));
  }
}

class FilterBottomSheet extends StatefulWidget {
  Iterable<ShiftModel>? listShift;
  FilterBottomSheet({
    super.key,
    this.listShift,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Text("Remove Filter", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue)),
            ],
          ),
          Text("Filter By Date :", style: TextStyle(fontSize: 16)),
          ListTile(
            leading: Icon(Icons.filter_alt_outlined, color: Colors.blue),
            title: Text("Select Date"),
            onTap: () {},
          ),
          SizedBox(height: 16),
          Text("Filter By Type :", style: TextStyle(fontSize: 16)),
          ...["CNA", "PST", "PCT", "PT", "OT", "RT", "EKG Technician", "LPN", "RN", "ARNP"]
              .map((type) => ListTile(
                    leading: Icon(Icons.filter_alt_outlined, color: Colors.blue),
                    title: Text(type),
                    onTap: () {
                      var http = HttpRequest();
                      http
                          .shiftFilters(
                        type: type,
                      )
                          .then((value) {
                        if (!value.success) {
                          SnackBarMessage.errorSnackbar(context, value.message);
                        } else {
                          Navigator.pop(context);
                          var docType = value.data['data'];
                          print("JJJJJJJJJJJJJJJJJJJJJJJ $docType");

                          if (docType != null) {
                            setState(() {
                              widget.listShift = ShiftModel.listShiftModels(docType);
                            });
                            setState(() {});
                          }
                        }
                      });
                    },
                  ))
              .toList(),
          SizedBox(height: 16),
          Text("Filter By Time :", style: TextStyle(fontSize: 16)),
          ...["7a-3p (8hrs)", "3p-11p (8hrs)", "6:45a-3:15p (8.5hrs)"]
              .map((time) => ListTile(
                    leading: Icon(Icons.filter_alt_outlined, color: Colors.blue),
                    title: Text(time),
                    onTap: () {
                      var http = HttpRequest();
                      http.shiftFilters(
                        shift_hour: time,
                      );
                    },
                  ))
              .toList(),
        ],
      ),
    );
  }
}
