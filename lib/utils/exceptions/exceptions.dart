class ADException implements Exception {
  final dynamic error;
  final String message;
  final String code;

  ADException(this.error, {required this.message, required this.code});

  @override
  String toString() => message;
}
