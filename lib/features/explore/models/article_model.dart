import 'package:nabeey/data/models/file_model.dart';
import 'package:nabeey/features/explore/models/category_model.dart';

class ArticleModel {
  int id;
  String text;
  CategoryModel category;
  FileModel image;
  // User user;

  ArticleModel({
    required this.id,
    required this.text,
    required this.category,
    required this.image,
    // required this.user,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json["id"],
        text: json["text"],
        category: CategoryModel.fromJson(json["category"]),
        image: FileModel.fromJson(json["image"]),
        // user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "category": category.toJson(),
        "image": image.toJson(),
        // "user": user.toJson(),
      };
}