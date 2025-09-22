class ShiftModel {
  final int id;
  final String userId;
  final String shiftLocation;
  final String clinicianType;
  final String title;
  final String date;
  final String shiftHour;
  final String ratePerHour;
  final String totalAmount;
  final String shiftNote;
  final String? additionalComments;
  final String createdAt;
  final String? updatedAt;
  final List<ShiftClinician>? shiftClinicians;

  ShiftModel({
    required this.id,
    required this.userId,
    required this.shiftLocation,
    required this.clinicianType,
    required this.title,
    required this.date,
    required this.shiftHour,
    required this.ratePerHour,
    required this.totalAmount,
    required this.shiftNote,
    this.additionalComments,
    required this.createdAt,
    this.updatedAt,
    this.shiftClinicians,
  });

  static Iterable<ShiftModel> listShiftModels(Iterable<dynamic> data) {
    return data.map((e) {
      return ShiftModel(
        id: _parseInt(e['id']),
        userId: e['user_id']?.toString() ?? '',
        shiftLocation: e['shift_location'] ?? '',
        clinicianType: e['clinician_type'] ?? '',
        title: e['title'] ?? '',
        date: e['date'] ?? '',
        shiftHour: e['shift_hour']?.toString() ?? '',
        ratePerHour: e['rate_per_hour']?.toString() ?? '',
        totalAmount: e['total_amount']?.toString() ?? '',
        shiftNote: e['shift_note'] ?? '',
        additionalComments: e['additional_comments'],
        createdAt: e['created_at'] ?? '',
        updatedAt: e['updated_at'],
        shiftClinicians: (e['shift_clinicians'] as List?)?.map((e) => ShiftClinician.fromMap(e)).toList(),
      );
    });
  }

  // Helper method to safely parse integers
  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is double) return value.toInt();
    return 0;
  }
}

class ShiftClinician {
  final int id;
  final int userId;
  final int shiftId;
  final String locationName;
  final String clockin;
  final String clockout;
  final String lat;
  final String lon;
  final int shiftStatus;
  final int status;
  final String acceptedAt;
  final String? rejectedAt;
  final String createdAt;
  final String updatedAt;

  ShiftClinician({
    required this.id,
    required this.userId,
    required this.shiftId,
    required this.locationName,
    required this.clockin,
    required this.clockout,
    required this.lat,
    required this.lon,
    required this.shiftStatus,
    required this.status,
    required this.acceptedAt,
    this.rejectedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ShiftClinician.fromMap(Map<String, dynamic> data) {
    return ShiftClinician(
      id: _parseInt(data['id']),
      userId: _parseInt(data['user_id']),
      shiftId: _parseInt(data['shift_id']),
      locationName: data['location_name'] ?? '',
      clockin: data['clockin'] ?? '',
      clockout: data['clockout'] ?? '',
      lat: data['lat'] ?? '',
      lon: data['lon'] ?? '',
      shiftStatus: _parseInt(data['shift_status']),
      status: _parseInt(data['status']),
      acceptedAt: data['accepted_at'] ?? '',
      rejectedAt: data['rejected_at'],
      createdAt: data['created_at'] ?? '',
      updatedAt: data['updated_at'] ?? '',
    );
  }

  static Iterable<ShiftClinician> listShiftClinician(Iterable<dynamic> data) {
    return data.map((e) => ShiftClinician.fromMap(e));
  }

  // Helper method to safely parse integers
  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is double) return value.toInt();
    return 0;
  }
}