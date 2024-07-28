import 'package:nabeey/features/explore/models/file_model.dart';

class CategoryModel {
  int id;
  String name;
  FileModel image;
  String description;
  List<dynamic> books;
  List<dynamic> audios;
  List<dynamic> videos;
  List<dynamic> articles;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.books,
    required this.audios,
    required this.videos,
    required this.articles,
    required this.description,
  });

  static CategoryModel empty() => CategoryModel(id: 0, name: '', image: FileModel.empty(), books: [], audios: [], videos: [], articles: [], description: '');

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"] != null ? FileModel.fromJson(json["image"]) : FileModel.empty(),
        books: List<dynamic>.from(json["books"].map((x) => x)),
        audios: List<dynamic>.from(json["audios"].map((x) => x)),
        videos: List<dynamic>.from(json["videos"].map((x) => x)),
        articles: List<dynamic>.from(json["articles"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image.toJson(),
        "description": description,
        "books": List<dynamic>.from(books.map((x) => x)),
        "audios": List<dynamic>.from(audios.map((x) => x)),
        "videos": List<dynamic>.from(videos.map((x) => x)),
        "articles": List<dynamic>.from(articles.map((x) => x)),
      };
}
