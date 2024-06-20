import 'package:nabeey/data/models/file_model.dart';
import 'package:nabeey/features/explore/models/user_model.dart';
import 'package:nabeey/features/explore/models/category_model.dart';

class ArticleModel {
  int id;
  String text;
  UserModel user;
  FileModel image;
  CategoryModel category;

  ArticleModel({
    required this.id,
    required this.text,
    required this.user,
    required this.image,
    required this.category,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json["id"],
        text: json["text"],
        user: UserModel.fromJson(json["user"]),
        image: FileModel.fromJson(json["image"]),
        category: CategoryModel.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "user": user.toJson(),
        "image": image.toJson(),
        "category": category.toJson(),
      };
}
