class FileModel {
  String fileName;
  String filePath;

  FileModel({
    required this.fileName,
    required this.filePath,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      fileName: json["fileName"] ?? '',
      filePath: json["filePath"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "filePath": filePath,
      };

  factory FileModel.empty() {
    return FileModel(
      fileName: '',
      filePath: '',
    );
  }
}
