class ShiftModel {
  late int id;
  late String userId;
  late String shiftLocation;
  late String clinicianType;
  late String title;
  late String date;
  late String shiftHour;
  late String ratePerHour;
  late String totalAmount;
  late String shiftNote;
  late String? additionalComments;
  late String createdAt;
  late String? updatedAt;
  late UserShiftModel? userShiftModel;
  ShiftModel({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.additionalComments,
    required this.clinicianType,
    required this.date,
    required this.ratePerHour,
    required this.shiftHour,
    required this.shiftLocation,
    required this.shiftNote,
    required this.totalAmount,
    required this.updatedAt,
    required this.userId,
    this.userShiftModel,
  });
  static Iterable<ShiftModel> listShiftModels(Iterable<dynamic> data) {
    return data.map(
      (e) => ShiftModel(
          id: e['id'],
          userId: e['user_id'].toString(),
          shiftLocation: e['shift_location'] ?? '',
          clinicianType: e['clinician_type'] ?? '',
          title: e['title'] ?? '',
          date: e['date'],
          shiftHour: e['shift_hour'] ?? '',
          ratePerHour: e['rate_per_hour'] ?? '',
          totalAmount: e['total_amount'] ?? '',
          shiftNote: e['shift_note'] ?? '',
          additionalComments: e['additional_comments'] ?? '',
          createdAt: e['created_at'],
          userShiftModel: e['user_shift'] != null ? UserShiftModel.fromJson(e['user_shift']) : null,
          updatedAt: e['updated_at']),
    );
  }
}

class UserShiftModel {
  late int id;
  late int userId;
  late int shiftId;
  late String locationName;
  late String clockin;
  late String clockout;
  late String lat;
  late String lon;
  late int shiftStatus;
  late int status;
  late String acceptedAt;
  late String? rejectedAt;
  late String createdAt;
  late String updatedAt;
  UserShiftModel({
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
    required this.rejectedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserShiftModel.fromJson(Map<String, dynamic> json) {
    return UserShiftModel(
      id: json['id'],
      userId: json['user_id'],
      shiftId: json['shift_id'],
      locationName: json['location_name'],
      clockin: json['clockin'],
      clockout: json['clockout'],
      lat: json['lat'],
      lon: json['lon'],
      shiftStatus: json['shift_status'],
      status: json['status'],
      acceptedAt: json['accepted_at'],
      rejectedAt: json['rejected_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
