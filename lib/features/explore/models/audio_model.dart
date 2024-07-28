import 'package:nabeey/features/explore/models/file_model.dart';

class AudioModel {
  int id;
  String title;
  FileModel audio;
  String description;

  AudioModel({
    required this.id,
    required this.title,
    required this.audio,
    required this.description,
  });

  static AudioModel empty() => AudioModel(id: 0, title: '', audio: FileModel.empty(), description: '');

  factory AudioModel.fromJson(Map<String, dynamic> json) => AudioModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        audio: FileModel.fromJson(json["audio"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "audio": audio.toJson(),
        "description": description,
      };
}
