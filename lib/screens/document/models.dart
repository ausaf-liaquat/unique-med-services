class Docs {
  late int id;
  late String title;
  late String documentUrl;
  late String createdAt;
  final DocumentType? documentType;
  final DateTime? expiryDate; // Add this field

  Docs({
    required this.id,
    required this.title,
    required this.documentUrl,
    required this.createdAt,
    this.documentType,
    this.expiryDate,
  });

  static Iterable<Docs> getDocList(List<dynamic> data) {
    return data.map((e) => Docs(
      id: e['id'],
      title: e['title'],
      documentUrl: e['document_url'],
      createdAt: e['created_at'],
      documentType: e['document_type'] != null ? DocumentType(
        id: e['document_type']['id'],
        name: e['document_type']['name'],
        createdAt: e['document_type']['created_at'],
        updatedAt: e['document_type']['updated_at'],
      ) : null,
      expiryDate: e['expiry_date'] != null ? DateTime.parse(e['expiry_date']) : null,
    ));
  }

  // Add toJson method for API submission
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'document_url': documentUrl,
      'created_at': createdAt,
      'document_type_id': documentType?.id,
      'expiry_date': expiryDate?.toIso8601String().split('T')[0], // YYYY-MM-DD format
    };
  }

  // Add copyWith method for immutability
  Docs copyWith({
    int? id,
    String? title,
    String? documentUrl,
    String? createdAt,
    DocumentType? documentType,
    DateTime? expiryDate,
  }) {
    return Docs(
      id: id ?? this.id,
      title: title ?? this.title,
      documentUrl: documentUrl ?? this.documentUrl,
      createdAt: createdAt ?? this.createdAt,
      documentType: documentType ?? this.documentType,
      expiryDate: expiryDate ?? this.expiryDate,
    );
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