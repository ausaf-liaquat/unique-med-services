class ClincianTypes {
  final String? value;
  final String? label;

  ClincianTypes({
    required this.value,
    required this.label,
  });

  // Factory constructor to create an instance from JSON
  factory ClincianTypes.fromJson(Map<String, dynamic> json) {
    return ClincianTypes(
      value: json['value'] as String?,
      label: json['label'] as String?,
    );
  }

  // Method to convert a list of dynamic maps to a list of ClincianTypes
  static List<ClincianTypes> listClinicianTypes(List<dynamic> data) {
    return data.map((e) => ClincianTypes.fromJson(e as Map<String, dynamic>)).toList();
  }
}
