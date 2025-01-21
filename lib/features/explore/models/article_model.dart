import '../../../data/models/file_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/category_model.dart';

class ArticleModel {
  final int id;
  final String title;
  final String text;
  final UserModel user;
  final FileModel image;
  final CategoryModel category;

  // Constructor
  ArticleModel({
    required this.id,
    required this.title,
    required this.text,
    required this.user,
    required this.image,
    required this.category,
  });

  // Factory constructor for JSON deserialization
  factory ArticleModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ArticleModel.empty();

    return ArticleModel(
      id: json["id"] ?? 0,
      title: json["title"] ?? 'Maqola sarlavhasi',
      text: json["text"] ?? '',
      user: UserModel.fromJson(json["user"]),
      image: FileModel.fromJson(json["image"]),
      category: CategoryModel.fromJson(json["category"]),
    );
  }

  // Method to serialize to JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "text": text,
        "user": user.toJson(),
        "image": image.toJson(),
        "category": category.toJson(),
      };

  // Static method to provide an empty instance
  static ArticleModel empty() {
    return ArticleModel(
      id: 0,
      title: '',
      text: '',
      user: UserModel.empty(),
      image: FileModel.empty(),
      category: CategoryModel.empty(),
    );
  }
}
