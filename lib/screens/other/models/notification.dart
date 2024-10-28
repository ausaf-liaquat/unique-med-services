class NotificationModel {
  late dynamic id;
  late dynamic type;
  late String title;
  late dynamic createdAt;
  NotificationModel({required this.id, required this.title, required this.createdAt, required this.type});
  static fromJson(Iterable<dynamic> data) {
    return data.map((e) => NotificationModel(id: e['id'], title: e['title'], createdAt: e['created_at'], type: e['title'])).toList();
  }
}
