import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ums_staff/core/constants.dart';
import 'package:ums_staff/core/http.dart';
import 'package:ums_staff/screens/shift/clinicianTypesModel.dart';
import 'package:ums_staff/screens/shift/clinicianTypesModel.dart' as shiftHours;
import 'package:ums_staff/screens/shift/models.dart';
import 'package:ums_staff/widgets/card/card.dart';
import 'package:ums_staff/widgets/messages/snack_bar.dart';
import '../../widgets/dataDisplay/typography.dart';
import '../../widgets/inputs/search_field.dart';
import '../../widgets/dataDisplay/shift.dart';
import '../../widgets/skeleton/shift.dart';
import 'details.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ShiftScreen extends StatefulWidget {
  const ShiftScreen({super.key});

  @override
  State<ShiftScreen> createState() => _ShiftScreenState();
}

class _ShiftScreenState extends State<ShiftScreen> {
  bool loading = false;
  Iterable<ShiftModel> listShift = [];
  List<ClincianTypes> listClinicianTypes = [];
  List<shiftHours.ClincianTypes> listShiftHours = [];
  TextEditingController searchController = TextEditingController();
  Timer? onStoppedTyping;

  void _onChangeHandler(String value) {
    if (onStoppedTyping?.isActive ?? false) {
      onStoppedTyping?.cancel();
    }

    const duration = Duration(milliseconds: 800);
    onStoppedTyping = Timer(duration, () => _stopTyping(value));
  }

  void _stopTyping(String value) {
    if (value.isNotEmpty && value.length > 3) {
      var http = HttpRequest();
      http
          .shiftFilters(
        location: value,
      )
          .then((value) {
        if (!value.success) {
          SnackBarMessage.errorSnackbar(context, value.message);
        } else {
          var docType = value.data['data'];
          Navigator.pop(context);

          if (docType != null) {
            setState(() {
              listShift = ShiftModel.listShiftModels(docType);
            });
            value = "";
          }
        }
      });
    } else if (value.isEmpty) {
      var http = HttpRequest();
      http.shifts().then((value) {
        setState(() {
          loading = true;
        });
        http.shifts().then((value) {
          if (!value.success) {
            SnackBarMessage.errorSnackbar(context, value.message);
          } else {
            var docType = value.data['data']['shifts'];

            if (docType != null) {
              setState(() {
                listShift = ShiftModel.listShiftModels(docType);
              });
            }
          }
        });
      });
    }
  }

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
    fetchClinicianTypes();
    listOfShiftHours();
  }

  void fetchClinicianTypes() async {
    var token = await HttpRequest().getToken();
    var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('GET', Uri.parse('https://${Constants.baseUrl}/api/v1/clinician-types'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      List<dynamic> jsonData = json.decode(responseString);

      // Update the list with parsed clinician types
      setState(() {
        listClinicianTypes = ClincianTypes.listClinicianTypes(jsonData);
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  // shift-hours
  listOfShiftHours() async {
    var token = await HttpRequest().getToken();
    var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('GET', Uri.parse('https://${Constants.baseUrl}/api/v1/shift-hours'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      List<dynamic> jsonData = json.decode(responseString);

      // Update the list with parsed clinician types
      setState(() {
        listShiftHours = shiftHours.ClincianTypes.listClinicianTypes(jsonData);
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  // shift filters
  shiftFilters({String? date, String? type, String? shift_hour, String? location}) async {
    var token = await HttpRequest().getToken();
    var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
    var url = Uri.https(Constants.baseUrl, 'api/v1/shifts/filter');
    var request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      if (date != null) 'date': date,
      if (type != null) 'type': type,
      if (shift_hour != null) 'shift_hour': shift_hour,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // Read response only once
      String responseString = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseString);

      // Check if jsonResponse contains a list under 'data' key or directly
      var docType = jsonResponse['data'];
      if (docType is List) {
        setState(() {
          listShift = ShiftModel.listShiftModels(docType).toList();
        });
        Navigator.pop(context);
      } else {
        print("Unexpected data format. Expected a list, but received: ${docType.runtimeType}");
      }
    } else {
      print(response.reasonPhrase);
    }
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
                          FilterRow(context),
                        //  const SizedBox(height: 16),
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
                        FilterRow(context),
                        const SizedBox(height: 16),
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

  Row FilterRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          padding: const EdgeInsets.all(0),
          icon: const Icon(Icons.filter_alt_outlined),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // search field
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            InkWell(
                                onTap: () {
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
                                        Navigator.pop(context);
                                      }
                                    }
                                  });
                                },
                                child: const Text("Remove Filter", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue))),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text("Search By Location :", style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onChanged: _onChangeHandler),
                        const SizedBox(height: 16),
                        const Text("Filter By Date :", style: TextStyle(fontSize: 16)),
                        ListTile(
                          leading: const Icon(Icons.filter_alt_outlined, color: Colors.blue),
                          title: const Text("Select Date"),
                          onTap: () {
                            // open date picker

                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2025),
                            ).then((value) {
                              if (value != null) {
                                shiftFilters(
                                  date: value.toString().split(" ")[0],
                                );
                                // var http = HttpRequest();
                                // http
                                //     .shiftFilters(
                                //   date: value.toString().split(" ")[0],
                                // )
                                //     .then((value) {
                                //   if (!value.success) {
                                //     SnackBarMessage.errorSnackbar(context, value.message);
                                //   } else {
                                //     Navigator.pop(context);
                                //     var docType = value.data['data'];

                                //     if (docType != null) {
                                //       setState(() {
                                //         listShift = ShiftModel.listShiftModels(docType);
                                //       });
                                //     }
                                //   }
                                // });
                              }
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text("Filter By Type :", style: TextStyle(fontSize: 16)),
                        ...listClinicianTypes
                            .map((clinician) => ListTile(
                                  leading: const Icon(Icons.filter_alt_outlined, color: Colors.blue),
                                  title: Text(clinician.label ?? ""),
                                  onTap: () {
                                    shiftFilters(
                                      type: clinician.value ?? "",
                                    );
                                    // var http = HttpRequest();
                                    // http.shiftFilters(type: clinician.value ?? "").then((value) {
                                    //   if (!value.success) {
                                    //     SnackBarMessage.errorSnackbar(context, value.message);
                                    //   } else {
                                    //     Navigator.pop(context);
                                    //     var docType = value.data['data'];
                                    //     print("JJJJJJJJJJJJJJJJJJJJJJJ ${value.data['data']}");

                                    //     if (docType != null) {
                                    //       setState(() {
                                    //         listShift = ShiftModel.listShiftModels(docType);
                                    //       });
                                    //     }
                                    //   }
                                    // });
                                  },
                                ))
                            .toList(),
                        const SizedBox(height: 16),
                        const Text("Filter By Time :", style: TextStyle(fontSize: 16)),
                        ...listShiftHours
                            .map((time) => ListTile(
                                  leading: const Icon(Icons.filter_alt_outlined, color: Colors.blue),
                                  title: Text(time.label ?? ""),
                                  onTap: () {
                                    shiftFilters(
                                      shift_hour: time.value ?? "",
                                    );
                                    // var http = HttpRequest();
                                    // http
                                    //     .shiftFilters(
                                    //   shift_hour: time.label ?? "",
                                    // )
                                    //     .then((value) {
                                    //   if (!value.success) {
                                    //     SnackBarMessage.errorSnackbar(context, value.message);
                                    //   } else {
                                    //     Navigator.pop(context);
                                    //     var docType = value.data['data'];

                                    //     if (docType != null) {
                                    //       setState(() {
                                    //         listShift = ShiftModel.listShiftModels(docType);
                                    //       });
                                    //     }
                                    //   }
                                    // });
                                  },
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
