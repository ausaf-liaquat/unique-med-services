class Docs {
  late int id;
  late String title;
  late String documentUrl;
  late String createdAt;
  Docs({ required this.id, required this.title, required this.documentUrl, required this.createdAt });
  static Iterable<Docs> getDocList(List<dynamic> data){
    return data.map((e) => Docs(id: e['id'], title: e['title'], documentUrl: e['document_url'], createdAt: e['created_at']));
  }
}