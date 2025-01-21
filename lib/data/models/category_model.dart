import 'file_model.dart';
import '../../features/explore/models/book_model.dart';
import '../../features/explore/models/audio_model.dart';
import '../../features/explore/models/video_model.dart';
import '../../features/explore/models/article_model.dart';

class CategoryModel {
  final int id;
  final String name;
  final FileModel image;
  final String description;
  final List<BookModel> books;
  final List<AudioModel> audios;
  final List<VideoModel> videos;
  final List<ArticleModel> articles;

  // Constructor
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

  // Factory constructor for JSON deserialization
  factory CategoryModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return CategoryModel.empty();

    return CategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: FileModel.fromJson(json['image']),
      books: _fromJsonList<BookModel>(json['books'], BookModel.fromJson),
      audios: _fromJsonList<AudioModel>(json['audios'], AudioModel.fromJson),
      videos: _fromJsonList<VideoModel>(json['videos'], VideoModel.fromJson),
      articles: _fromJsonList<ArticleModel>(json['articles'], ArticleModel.fromJson),
    );
  }

  // Helper function to parse data models from json list
  static List<T> _fromJsonList<T>(List<dynamic>? jsonList, T Function(Map<String, dynamic>) fromJson) {
    if (jsonList == null) return [];
    return List<T>.from(jsonList.map((item) => fromJson(item as Map<String, dynamic>)));
  }

  // Method to serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image.toJson(),
      'description': description,
      'books': books.map((book) => book.toJson()).toList(),
      'audios': audios.map((audio) => audio.toJson()).toList(),
      'videos': videos.map((video) => video.toJson()).toList(),
      'articles': articles.map((article) => article.toJson()).toList(),
    };
  }

  // Static method to provide an empty instance
  static CategoryModel empty() {
    return CategoryModel(
      id: 0,
      name: '',
      books: [],
      audios: [],
      videos: [],
      articles: [],
      description: '',
      image: FileModel.empty(),
    );
  }
}
