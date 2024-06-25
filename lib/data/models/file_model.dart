class FileModel {
  String fileName;
  String filePath;

  FileModel({
    required this.fileName,
    required this.filePath,
  });

  static FileModel empty() => FileModel(fileName: '', filePath: '');

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
        fileName: json["fileName"],
        filePath: json["filePath"],
      );

  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "filePath": filePath,
      };
}
