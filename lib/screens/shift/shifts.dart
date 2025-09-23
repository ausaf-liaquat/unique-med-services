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
  int? selectedDateIndex;
  int? selectedTypeIndex;
  int? selectedHourIndex;

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
      http.shiftFilters(location: value);
      Navigator.pop(context);
      searchController.clear();
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
    _loadShifts();
    fetchClinicianTypes();
    listOfShiftHours();
  }

  void _loadShifts() {
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
        if (docType != null) {
          setState(() {
            listShift = ShiftModel.listShiftModels(docType);
          });
        }
      }
    });
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
      setState(() {
        listClinicianTypes = ClincianTypes.listClinicianTypes(jsonData);
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  listOfShiftHours() async {
    var token = await HttpRequest().getToken();
    var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('GET', Uri.parse('https://${Constants.baseUrl}/api/v1/shift-hours'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      List<dynamic> jsonData = json.decode(responseString);
      setState(() {
        listShiftHours = shiftHours.ClincianTypes.listClinicianTypes(jsonData);
      });
    } else {
      print(response.reasonPhrase);
    }
  }

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
      String responseString = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseString);
      var docType = jsonResponse['data'];
      if (docType is List) {
        setState(() {
          listShift = ShiftModel.listShiftModels(docType).toList();
        });
        Navigator.pop(context);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 32),
          child: Column(
            children: [
              // Modern Header
              _buildHeader(),
              const SizedBox(height: 24),

              // Filter Button
              _buildFilterButton(),
              const SizedBox(height: 20),

              // Content
              loading
                  ? _buildShimmerLoading()
                  : listShift.isEmpty
                  ? _buildEmptyState()
                  : _buildShiftList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available Shifts',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Find your next opportunity',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(
            Icons.work_outline,
            color: Colors.blue[700],
            size: 28,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterButton() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextButton.icon(
        onPressed: () => _showFilterModal(context),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Icon(
          Icons.filter_list_rounded,
          color: Colors.blue[700],
        ),
        label: Text(
          'Filter Shifts',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[800],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.separated(
      itemCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: AppCard(
            child: ShiftSkeleton(),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 16),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              Icon(
                Icons.work_outline,
                size: 80,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 20),
              Text(
                'No Shifts Available',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Check back later for new opportunities',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildShiftList() {
    return Column(
      children: [
        Text(
          '${listShift.length} shifts found',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          itemCount: listShift.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: ModernCard.elevated(
                onTap: () {
                  Navigator.pushNamed(
                      context,
                      ShiftDetailScreen.route,
                      arguments: {'shiftModel': listShift.elementAt(index)}
                  );
                },
                child: JobShift(shift: listShift.elementAt(index)),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 16),
        ),
      ],
    );
  }

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  _buildFilterHeader(),
                  const SizedBox(height: 24),

                  // Location Search
                  _buildLocationSearch(),
                  const SizedBox(height: 24),

                  // Date Filter
                  _buildDateFilter(),
                  const SizedBox(height: 20),

                  // Type Filter
                  _buildTypeFilter(),
                  const SizedBox(height: 20),

                  // Time Filter
                  _buildTimeFilter(),
                  const SizedBox(height: 30),

                  // Action Buttons
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Filter Shifts',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        IconButton(
          icon: Icon(Icons.close, color: Colors.grey[600]),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildLocationSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search by Location',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Enter location...',
                    prefixIcon: Icon(Icons.location_on_outlined, color: Colors.grey[500]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue[600],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () => _onChangeHandler(searchController.text),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filter by Date',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: selectedDateIndex == 0 ? Colors.blue[50] : Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selectedDateIndex == 0 ? Colors.blue[200]! : Colors.grey[300]!,
            ),
          ),
          child: ListTile(
            leading: Icon(
              Icons.calendar_today,
              color: selectedDateIndex == 0 ? Colors.blue[600] : Colors.grey[600],
            ),
            title: Text(
              'Select Date',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: selectedDateIndex == 0 ? Colors.blue[800] : Colors.grey[700],
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: selectedDateIndex == 0 ? Colors.blue[600] : Colors.grey[500],
            ),
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2075),
              ).then((value) {
                if (value != null) {
                  setState(() {
                    selectedDateIndex = 0;
                    selectedTypeIndex = null;
                    selectedHourIndex = null;
                  });
                  shiftFilters(date: value.toString().split(" ")[0]);
                }
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTypeFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filter by Type',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 12),
        ...listClinicianTypes.asMap().entries.map((entry) {
          int index = entry.key;
          ClincianTypes clinician = entry.value;
          bool isSelected = selectedTypeIndex == index;

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue[50] : Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.blue[200]! : Colors.grey[300]!,
              ),
            ),
            child: ListTile(
              leading: Icon(
                Icons.medical_services_outlined,
                color: isSelected ? Colors.blue[600] : Colors.grey[600],
              ),
              title: Text(
                clinician.label ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.blue[800] : Colors.grey[700],
                ),
              ),
              onTap: () {
                setState(() {
                  selectedTypeIndex = index;
                  selectedDateIndex = null;
                  selectedHourIndex = null;
                });
                shiftFilters(type: clinician.value ?? "");
              },
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildTimeFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filter by Time',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 12),
        ...listShiftHours.asMap().entries.map((entry) {
          int index = entry.key;
          shiftHours.ClincianTypes time = entry.value;
          bool isSelected = selectedHourIndex == index;

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue[50] : Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.blue[200]! : Colors.grey[300]!,
              ),
            ),
            child: ListTile(
              leading: Icon(
                Icons.access_time,
                color: isSelected ? Colors.blue[600] : Colors.grey[600],
              ),
              title: Text(
                time.label ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.blue[800] : Colors.grey[700],
                ),
              ),
              onTap: () {
                setState(() {
                  selectedHourIndex = index;
                  selectedDateIndex = null;
                  selectedTypeIndex = null;
                });
                shiftFilters(shift_hour: time.value ?? "");
              },
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              _loadShifts();
              setState(() {
                selectedDateIndex = null;
                selectedTypeIndex = null;
                selectedHourIndex = null;
                searchController.clear();
              });
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: BorderSide(color: Colors.blue[600]!),
            ),
            child: Text(
              'Clear Filters',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.blue[600],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            child: Text(
              'Apply Filters',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}