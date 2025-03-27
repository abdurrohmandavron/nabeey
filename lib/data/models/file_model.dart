import 'package:flutter_dotenv/flutter_dotenv.dart';

class FileModel {
  final String fileName;
  final String filePath;

  // Constructor
  FileModel({
    required this.fileName,
    required this.filePath,
  });

  // Factory constructor for JSON deserialization
  factory FileModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return FileModel.empty();
    return FileModel(
      fileName: json["fileName"] ?? '',
      filePath: (json["filePath"] as String? ?? '')
          .replaceAll('localhost', dotenv.env['BASE_URL']!),
    );
  }

  // Method to serialize to JSON
  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "filePath": filePath,
      };

  // Static method to provide an empty instance
  static FileModel empty() {
    return FileModel(
      fileName: '',
      filePath: '',
    );
  }
}
