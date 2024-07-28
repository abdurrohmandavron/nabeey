import 'package:nabeey/features/explore/models/file_model.dart';
import 'package:nabeey/features/explore/models/user_model.dart';
import 'package:nabeey/features/explore/models/category_model.dart';

class ArticleModel {
  final int id;
  final String title;
  final String text;
  final UserModel user;
  final FileModel image;
  final CategoryModel category;

  ArticleModel({
    required this.id,
    required this.title,
    required this.text,
    required this.user,
    required this.image,
    required this.category,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json["id"] ?? 0,
        title: json["title"] ?? '',
        text: json["text"] ?? '',
        user: json["user"] != null ? UserModel.fromJson(json["user"]) : UserModel.empty(),
        image: json["image"] != null ? FileModel.fromJson(json["image"]) : FileModel.empty(),
        category: json["category"] != null ? CategoryModel.fromJson(json["category"]) : CategoryModel.empty(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "text": text,
        "user": user.toJson(),
        "image": image.toJson(),
        "category": category.toJson(),
      };
}
