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
  double? lat;
  double? long;
  bool showMap = false;
  bool loading = false;
  bool locationLoading = true;
  String? locationError;
  ShiftModel? register;

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
      return Future.error('Location permissions are permanently denied');
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        timeLimit: Duration(seconds: 15),
      );
      return position;
    } catch (e) {
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
      setState(() {
        locationError = e.toString();
        lat = 37.43296265331129;
        long = -122.08832357078792;
        showMap = true;
        locationLoading = false;
      });
      SnackBarMessage.errorSnackbar(context, "Using default location: $e");
    }
  }

  void _showClockInConfirmation() {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return _buildConfirmationDialog(
          isClockIn: true,
          title: 'Confirm Clock In',
          subtitle: 'You are about to clock in for your shift',
          icon: Icons.login_rounded,
          iconColor: Colors.green.shade600,
          primaryButtonText: 'Confirm Clock In',
          warningMessage: 'Please ensure you are at the correct location before clocking in.',
        );
      },
    );
  }

  void _showClockOutConfirmation() {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return _buildConfirmationDialog(
          isClockIn: false,
          title: 'Confirm Clock Out',
          subtitle: 'You are about to clock out from your shift',
          icon: Icons.logout_rounded,
          iconColor: Colors.orange.shade600,
          primaryButtonText: 'Confirm Clock Out',
          warningMessage: 'Please ensure you have completed all tasks before clocking out.',
        );
      },
    );
  }

  Widget _buildConfirmationDialog({
    required bool isClockIn,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required String primaryButtonText,
    required String warningMessage,
  }) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 32,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isClockIn
                      ? [
                    Colors.green.withOpacity(0.1),
                    Colors.green.withOpacity(0.05),
                  ]
                      : [
                    Colors.orange.withOpacity(0.1),
                    Colors.orange.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: iconColor,
                      size: 32,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColorScheme().black90,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColorScheme().black60,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Content Section
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  _buildConfirmationDetailItem(
                    icon: Icons.location_on_rounded,
                    title: 'Location',
                    value: register?.shiftLocation ?? 'Not specified',
                    color: Colors.blue.shade600,
                  ),
                  SizedBox(height: 16),
                  _buildConfirmationDetailItem(
                    icon: Icons.access_time_rounded,
                    title: 'Shift Time',
                    value: register?.shiftHour ?? 'Not specified',
                    color: Colors.green.shade600,
                  ),
                  SizedBox(height: 16),
                  _buildConfirmationDetailItem(
                    icon: Icons.calendar_today_rounded,
                    title: 'Date',
                    value: register?.date ?? 'Not specified',
                    color: Colors.purple.shade600,
                  ),
                  SizedBox(height: 24),

                  // Warning Message
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isClockIn ? Colors.orange.shade50 : Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isClockIn ? Colors.orange.shade200 : Colors.blue.shade200,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: isClockIn ? Colors.orange.shade700 : Colors.blue.shade700,
                          size: 20,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            warningMessage,
                            style: TextStyle(
                              fontSize: 12,
                              color: isClockIn ? Colors.orange.shade800 : Colors.blue.shade800,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Button Section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: AppColorScheme().black20)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColorScheme().black60,
                        side: BorderSide(color: AppColorScheme().black40),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (isClockIn) {
                          _handleClockIn();
                        } else {
                          _handleClockOut();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isClockIn ? Colors.green.shade600 : Colors.orange.shade600,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: loading
                          ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : Text(
                        primaryButtonText,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmationDetailItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColorScheme().black60,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColorScheme().black90,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleClockIn() async {
    if (register == null || lat == null || long == null) return;

    var http = HttpRequest();
    setState(() => loading = true);

    try {
      final value = await http.clockin({
        'lat': lat.toString(),
        'lon': long.toString(),
        'location_name': register!.shiftLocation.toString()
      }, register!.id);

      setState(() => loading = false);

      if (!value.success) {
        SnackBarMessage.errorSnackbar(context, value.message);
      } else {
        final shiftResult = await http.getAcceptShift();
        if (!shiftResult.success) {
          SnackBarMessage.errorSnackbar(context, shiftResult.message);
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LandingScreen(selectedIndex: 0),
            ),
          );
          SnackBarMessage.successSnackbar(context, "Clock In Successful!");
        }
      }
    } catch (e) {
      setState(() => loading = false);
      SnackBarMessage.errorSnackbar(context, "An error occurred during clock in");
    }
  }

  void _handleClockOut() async {
    if (register == null || lat == null || long == null) return;

    var http = HttpRequest();
    setState(() => loading = true);

    try {
      final value = await http.clockout({
        'lat': lat.toString(),
        'lon': long.toString(),
        'location_name': register!.shiftLocation.toString()
      }, register!.id);

      setState(() => loading = false);

      if (!value.success) {
        SnackBarMessage.errorSnackbar(context, value.message);
      } else {
        final shiftResult = await http.getAcceptShift();
        if (!shiftResult.success) {
          SnackBarMessage.errorSnackbar(context, shiftResult.message);
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LandingScreen(selectedIndex: 0),
            ),
          );
          SnackBarMessage.successSnackbar(context, "Clock Out Successful!");
        }
      }
    } catch (e) {
      setState(() => loading = false);
      SnackBarMessage.errorSnackbar(context, "An error occurred during clock out");
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    register = arguments['shiftModel'] ??
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
      page: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),

            if (locationError != null)
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.orange[50]!,
                      Colors.orange[100]!,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.orange[200]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.warning_amber_rounded, color: Colors.orange[800], size: 20),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Location Service',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.orange[800],
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Using default location for display',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.orange[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: _getCurrentLocation,
                      icon: Icon(Icons.refresh_rounded, color: Colors.orange[800]),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.orange[50],
                        padding: EdgeInsets.all(8),
                      ),
                    ),
                  ],
                ),
              ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: locationLoading
                    ? Container(
                  height: 220,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColorScheme().black10,
                        AppColorScheme().black20,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                          strokeWidth: 3,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Getting your location...',
                          style: TextStyle(
                            color: AppColorScheme().black60,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                    : showMap && lat != null && long != null
                    ? Stack(
                  children: [
                    OpenStreetMap(lat: lat!, long: long!),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.location_on_rounded, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text(
                              'Live Location',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '📍 ${lat!.toStringAsFixed(6)}, ${long!.toStringAsFixed(6)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    : Container(
                  height: 220,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColorScheme().black10,
                        AppColorScheme().black20,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_disabled_rounded, size: 48, color: AppColorScheme().black40),
                        SizedBox(height: 12),
                        Text(
                          'Location unavailable',
                          style: TextStyle(
                            color: AppColorScheme().black60,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: _getCurrentLocation,
                          icon: Icon(Icons.refresh_rounded, size: 16),
                          label: Text('Try Again'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 32),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Theme.of(context).colorScheme.primary.withOpacity(0.05),
                          Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.work_history_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 28,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shift Details',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColorScheme().black60,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                register!.title.isNotEmpty ? register!.title : 'Shift Assignment',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColorScheme().black90,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      children: [
                        _buildModernDetailItem(
                          icon: Icons.location_on_rounded,
                          title: 'Work Location',
                          value: register!.shiftLocation ?? 'Not specified',
                          color: Colors.blue.shade600,
                        ),
                        SizedBox(height: 24),
                        _buildModernDetailItem(
                          icon: Icons.access_time_rounded,
                          title: 'Shift Timing',
                          value: register!.shiftHour ?? 'Not specified',
                          color: Colors.green.shade600,
                        ),
                        SizedBox(height: 24),
                        _buildModernDetailItem(
                          icon: Icons.calendar_today_rounded,
                          title: 'Schedule Date',
                          value: register!.date ?? 'Not specified',
                          color: Colors.purple.shade600,
                        ),
                        if (register!.ratePerHour?.isNotEmpty == true) ...[
                          SizedBox(height: 24),
                          _buildModernDetailItem(
                            icon: Icons.attach_money_rounded,
                            title: 'Hourly Rate',
                            value: '${register!.ratePerHour}/hour',
                            color: Colors.orange.shade600,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  if (register!.shiftClinicians?.first.clockin != '')
                    _buildStatusButton(
                      icon: Icons.check_circle_rounded,
                      text: 'CLOCKED IN',
                      color: Colors.green,
                    )
                  else
                    _buildActionButton(
                      onPressed: loading || lat == null || long == null ? null : _showClockInConfirmation,
                      loading: loading,
                      icon: Icons.login_rounded,
                      text: 'CLOCK IN',
                      isPrimary: true,
                    ),

                  SizedBox(height: 16),

                  if (register!.shiftClinicians?.first.clockout != '')
                    _buildStatusButton(
                      icon: Icons.check_circle_rounded,
                      text: 'CLOCKED OUT',
                      color: Colors.blue,
                    )
                  else
                    _buildActionButton(
                      onPressed: loading || lat == null || long == null ? null : _showClockOutConfirmation,
                      loading: loading,
                      icon: Icons.logout_rounded,
                      text: 'CLOCK OUT',
                      isPrimary: false,
                    ),
                ],
              ),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildModernDetailItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColorScheme().black60,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColorScheme().black90,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback? onPressed,
    required bool loading,
    required IconData icon,
    required String text,
    required bool isPrimary,
  }) {
    return Container(
      width: double.infinity,
      height: 56,
      child: isPrimary
          ? ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24),
        ),
        child: loading
            ? SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22),
            SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      )
          : OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.error,
          side: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24),
        ),
        child: loading
            ? SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Theme.of(context).colorScheme.error,
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22),
            SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusButton({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22),
            SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: color,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}