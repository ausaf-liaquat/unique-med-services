class Docs {
  late int id;
  late String title;
  late String documentUrl;
  late String createdAt;
  final DocumentType? documentType;
  Docs({
    required this.id,
    required this.title,
    required this.documentUrl,
    required this.createdAt,
    this.documentType,
  });
  static Iterable<Docs> getDocList(List<dynamic> data) {
    return data.map((e) => Docs(
          id: e['id'],
          title: e['title'],
          documentUrl: e['document_url'],
          createdAt: e['created_at'],
          documentType: DocumentType(
            id: e['document_type']['id'],
            name: e['document_type']['name'],
            createdAt: e['document_type']['created_at'],
            updatedAt: e['document_type']['updated_at'],
          ),
        ));
  }
}

class DocumentType {
  final int? id;
  final String? name;
  final dynamic createdAt;
  final dynamic updatedAt;

  DocumentType({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });
}
