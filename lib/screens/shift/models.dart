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
  ShiftModel({ required this.id, required this.title,required this.createdAt,required this.additionalComments, required this.clinicianType, required this.date, required this.ratePerHour, required this.shiftHour, required this.shiftLocation, required this.shiftNote, required this.totalAmount, required this.updatedAt, required this.userId});
  static Iterable<ShiftModel> listShiftModels(Iterable<dynamic> data) {
    return data.map((e) =>ShiftModel(id: e['id'], userId: e['user_id'],
        shiftLocation: e['shift_location'], clinicianType: e['clinician_type'],
      title: e['title'], date: e['date'], shiftHour: e['shift_hour'], ratePerHour: e['rate_per_hour'],
        totalAmount: e['total_amount'], shiftNote: e['shift_note'], additionalComments: e['additional_comments'],
      createdAt: e['created_at'], updatedAt: e['updated_at']
    ));
  }
}