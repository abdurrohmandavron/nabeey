import '../../../data/models/file_model.dart';

class AudioModel {
  final int id;
  final String title;
  final FileModel audio;
  final String description;

  // Constructor
  AudioModel({
    required this.id,
    required this.title,
    required this.audio,
    required this.description,
  });

  // Factory constructor for JSON deserialization
  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      audio: FileModel.fromJson(json['audio'] ?? FileModel.empty()),
    );
  }

  // Method to serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'audio': audio.toJson(),
      'description': description,
    };
  }

  // Static method to provide an empty instance
  static AudioModel empty() {
    return AudioModel(
      id: 0,
      title: '',
      description: '',
      audio: FileModel.empty(),
    );
  }
}
