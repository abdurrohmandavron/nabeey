import 'package:nabeey/data/models/file_model.dart';

class BookData {
  int id;
  String title;
  String author;
  String description;
  FileModel file;
  FileModel image;

  BookData({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.file,
    required this.image,
  });

  factory BookData.fromJson(Map<String, dynamic> json) => BookData(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        description: json["description"],
        file: FileModel.fromJson(json["file"]),
        image: FileModel.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "description": description,
        "file": file.toJson(),
        "image": image.toJson(),
      };
}
