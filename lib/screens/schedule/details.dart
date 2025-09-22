import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ums_staff/screens/landing.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';
import 'package:ums_staff/widgets/messages/snack_bar.dart';
import 'package:ums_staff/widgets/open_street_map.dart';
import '../../core/http.dart';
import '../../widgets/others/back_layout.dart';
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
  double? lat; // Make nullable
  double? long; // Make nullable
  bool showMap = false;
  bool loading = false;
  bool locationLoading = true; // Separate loading for location
  String? locationError;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    print('📍 Checking location services...');
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('❌ Location services are disabled');
      return Future.error('Location services are disabled.');
    }

    print('📍 Checking permissions...');
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      print('📍 Requesting location permission...');
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('❌ Location permissions denied');
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('❌ Location permissions permanently denied');
      return Future.error('Location permissions are permanently denied');
    }

    print('📍 Getting current position...');
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best, // Changed to best
        timeLimit: Duration(seconds: 15),
      );
      print('✅ Location obtained: ${position.latitude}, ${position.longitude}');
      return position;
    } catch (e) {
      print('❌ Error getting position: $e');
      return Future.error('Failed to get location: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Location permissions are denied");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception("Location permissions are permanently denied.");
      }

      // ✅ Force high accuracy and avoid cached location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 15),
      );

      setState(() {
        lat = position.latitude;
        long = position.longitude;
        showMap = true;
        locationLoading = false;
      });
    } catch (e) {
      print('❌ Location error: $e');
      setState(() {
        locationError = e.toString();
        lat = 37.43296265331129; // fallback
        long = -122.08832357078792;
        showMap = true;
        locationLoading = false;
      });
      SnackBarMessage.errorSnackbar(context, "Using default location: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
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
          userId: '',
        );

    return BackLayout(
      text: 'SHIFT',
      page: SingleChildScrollView( // Changed from 'page' to 'child'
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location status indicator
            if (locationError != null)
              Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.orange),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Using default location',
                        style: TextStyle(color: Colors.orange[800]),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: _getCurrentLocation,
                      tooltip: 'Retry location',
                    ),
                  ],
                ),
              ),

            // Map or loading indicator
            locationLoading
                ? Container(
              height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Getting your location...'),
                  ],
                ),
              ),
            )
                : showMap && lat != null && long != null
                ? Column(
              children: [
                OpenStreetMap(
                  lat: lat!,
                  long: long!,
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Your location: ${lat!.toStringAsFixed(6)}, ${long!.toStringAsFixed(6)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
                : Container(
              height: 200,
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_off, size: 40, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('Location not available'),
                    TextButton(
                      onPressed: _getCurrentLocation,
                      child: Text('Try Again'),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTypography(
                      text: register?.title ?? '',
                      size: 24,
                      weight: FontWeight.w500
                  ),
                  const SizedBox(height: 24),
                  SubTitle(
                      title: 'Location',
                      subTitle: register.shiftLocation ?? '',
                      bottom: 40
                  ),
                  SubTitle(
                      title: 'Timing',
                      subTitle: register.shiftHour ?? '',
                      bottom: 40
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Clock In Button
                  register.shiftClinicians?.first.clockin != ''
                      ? Container()
                      : ElevatedButton(
                      onPressed: loading || lat == null || long == null
                          ? null // Disable if loading or no location
                          : () {
                        var http = HttpRequest();
                        setState(() {
                          loading = true;
                        });

                        http.clockin({
                          'lat': lat.toString(),
                          'lon': long.toString(),
                          'location_name': register.shiftLocation.toString()
                        }, register.id).then((value) {
                          setState(() {
                            loading = false;
                          });
                          if (!value.success) {
                            SnackBarMessage.errorSnackbar(context, value.message);
                          } else {
                            http.getAcceptShift().then((value) {
                              if (!value.success) {
                                SnackBarMessage.errorSnackbar(context, value.message);
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const LandingScreen(
                                          selectedIndex: 0,
                                        )));
                              }
                            });
                            SnackBarMessage.successSnackbar(context, "CheckIn is SuccessFull");
                          }
                        });
                      },
                      child: loading
                          ? CircularProgressIndicator(
                        color: AppColorScheme().black0,
                      )
                          : const Text('clock in')),

                  const SizedBox(height: 24),

                  // Clock Out Button
                  register.shiftClinicians?.first.clockout != ''
                      ? Container()
                      : OutlinedButton(
                      onPressed: loading
                          ? null
                          : () {
                        var http = HttpRequest();
                        setState(() {
                          loading = true;
                        });
                        http.clockout(register.id).then((value) {
                          setState(() {
                            loading = false;
                          });
                          if (!value.success) {
                            SnackBarMessage.errorSnackbar(context, value.message);
                          } else {
                            http.getAcceptShift().then((value) {
                              if (!value.success) {
                                SnackBarMessage.errorSnackbar(context, value.message);
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const LandingScreen(
                                          selectedIndex: 0,
                                        )));
                              }
                            });
                            SnackBarMessage.successSnackbar(context, "Checkout is SuccessFull");
                          }
                        });
                      },
                      child: loading
                          ? CircularProgressIndicator()
                          : const Text('clock out')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}