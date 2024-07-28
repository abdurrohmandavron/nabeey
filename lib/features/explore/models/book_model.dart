import 'package:nabeey/features/explore/models/file_model.dart';

class BookModel {
  int id;
  String title;
  String author;
  String description;
  FileModel file;
  FileModel image;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.file,
    required this.image,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
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
