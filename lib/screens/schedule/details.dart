import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';
import 'package:ums_staff/widgets/messages/snack_bar.dart';
import 'package:ums_staff/widgets/others/map.dart';
import '../../widgets/others/back_layout.dart';
import '../../widgets/inputs/check_box.dart';
import '../../widgets/dataDisplay/sub_title.dart';
import '../shift/models.dart';
import 'package:geolocator/geolocator.dart';

class ScheduleDetailScreen extends StatefulWidget {
  const ScheduleDetailScreen({super.key});
  static const route = '/schedule/123';

  @override
  State<ScheduleDetailScreen> createState() => _ScheduleDetailScreenState();
}

class _ScheduleDetailScreenState extends State<ScheduleDetailScreen> {
  double lat =  37.43296265331129;
  double long =  -122.08832357078792;
  bool showMap = false;
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  @override
  void initState() {
    super.initState();
    _determinePosition().then((value) {
      setState(() {
        lat = value.latitude;
        long = value.longitude;
        showMap = true;
      });
      print(value.toString());
    }).catchError((e){
      print(e);
      SnackBarMessage.errorSnackbar(context, "Please allow location to able to clocking");
    });
  }
  @override
  Widget build(BuildContext context) {
    bool midiumDevice = MediaQuery.of(context).size.width >= 350;
    final formKey = GlobalKey<FormBuilderState>();
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    var register = arguments['shiftModel'] ?? ShiftModel(id: 1, title: '', createdAt: '', additionalComments: '', clinicianType: '', date: '', ratePerHour: '', shiftHour: '', shiftLocation: '', shiftNote: '', totalAmount: '', updatedAt: '', userId: '');
    return BackLayout(
      text: 'SHIFT',
      page: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showMap ? MapView(lat: lat,long: long,) : const SizedBox(),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTypography(
                        text: register?.title ?? '',
                        size: 24,
                        weight: FontWeight.w500),
                    const SizedBox(height: 24),
                    const SubTitle(
                        title: 'Clocked In:',
                        subTitle: 'June 12, 2022, 06:45am',
                        bottom: 40),
                    FormBuilder(
                      key: formKey,
                      onChanged: () {
                        formKey.currentState!.save();
                      },
                      autovalidateMode: AutovalidateMode.disabled,
                      initialValue: const {
                        'break': false,
                        'forget': false,
                      },
                      skipDisabled: true,
                      child: Column(children: const [
                        AppCheckBox(
                            label: 'Took my full allotted break',
                            name: 'break'),
                        AppCheckBox(
                            label: 'Forget to clock out', name: 'forget'),
                      ]),
                    ),
                  ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text("I am being Send Home")),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text("issues clocking out")),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: OutlinedButton(
                              onPressed: () {},
                              child: const Text('Offer Detail'))),
                      SizedBox(width: midiumDevice ? 32 : 15),
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('clock out'))),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
