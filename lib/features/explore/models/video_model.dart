// import 'package:nabeey/features/explore/models/youtube_video_model.dart';

class VideoModel {
  final int id;
  final String title;
  final String author;
  final String videoLink;
  final String description;
  // late VideoDataModel data;

  // Constructor
  VideoModel({
    required this.id,
    required this.title,
    required this.author,
    required this.videoLink,
    required this.description,
  });

  // Factory constructor for creating an instance from JSON
  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json["id"] ?? 0,
      title: json["title"] ?? '',
      author: json["author"] ?? '',
      videoLink: json["videoLink"] ?? '',
      description: json["description"] ?? '',
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "author": author,
      "videoLink": videoLink,
      "description": description,
    };
  }

  // Static method to create an empty instance
  static VideoModel empty() {
    return VideoModel(
      id: 0,
      title: '',
      author: '',
      videoLink: '',
      description: '',
      // data: VideoDataModel.empty(),
    );
  }
}
