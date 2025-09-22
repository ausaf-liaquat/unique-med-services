class ApiResponse {
  final bool success;
  final dynamic data;
  final String message;

  ApiResponse({
    required this.success,
    this.data,
    required this.message,
  });

  @override
  String toString() {
    return 'ApiResponse{success: $success, message: $message, data: $data}';
  }
}