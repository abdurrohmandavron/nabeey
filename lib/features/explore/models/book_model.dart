import '../../../data/models/file_model.dart';

class BookModel {
  final int id;
  final String title;
  final String author;
  final String description;
  final FileModel file;
  final FileModel image;

  // Constructor
  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.file,
    required this.image,
  });

  // Factory constructor for JSON deserialization
  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      description: json['description'] ?? '',
      file: FileModel.fromJson(json['file'] ?? FileModel.empty()),
      image: FileModel.fromJson(json['image'] ?? FileModel.empty()),
    );
  }

  // Method to serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'file': file.toJson(),
      'image': image.toJson(),
    };
  }

  // Static method to provide an empty instance
  static BookModel empty() {
    return BookModel(
      id: 0,
      title: '',
      author: '',
      description: '',
      file: FileModel.empty(),
      image: FileModel.empty(),
    );
  }
}
