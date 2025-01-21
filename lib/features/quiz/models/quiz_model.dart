import '../../../data/models/user_model.dart';
import '../../../data/models/category_model.dart';

class QuizModel {
  final int id;
  final String name;
  final String description;
  final int questionCount;
  final DateTime startTime;
  final DateTime endTime;
  final UserModel user;
  final CategoryModel contentCategory;
  final String certificate;

  // Constructor
  QuizModel({
    required this.id,
    required this.name,
    required this.description,
    required this.questionCount,
    required this.startTime,
    required this.endTime,
    required this.user,
    required this.contentCategory,
    required this.certificate,
  });

  // Factory constructor for JSON deserialization
  factory QuizModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return QuizModel.empty();

    return QuizModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? '',
      description: json["description"] ?? '',
      questionCount: json["questionCount"] ?? 0,
      startTime: DateTime.parse(json["startTime"] ?? DateTime.now().toIso8601String()),
      endTime: DateTime.parse(json["endTime"] ?? DateTime.now().toIso8601String()),
      user: UserModel.fromJson(json["user"]),
      contentCategory: CategoryModel.fromJson(json["contentCategory"]),
      certificate: json["certificate"] ?? '',
    );
  }

  // Method to serialize to JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "questionCount": questionCount,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "user": user.toJson(),
        "contentCategory": contentCategory.toJson(),
        "certificate": certificate,
      };

  // Static method to provide an empty instance
  static QuizModel empty() {
    return QuizModel(
      id: 0,
      name: '',
      description: '',
      questionCount: 0,
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      user: UserModel.empty(),
      contentCategory: CategoryModel.empty(),
      certificate: '',
    );
  }
}
