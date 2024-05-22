class VideoModel {
  int id;
  String title;
  String author;
  String videoLink;
  String description;

  VideoModel({
    required this.id,
    required this.title,
    required this.author,
    required this.videoLink,
    required this.description,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        videoLink: json["videoLink"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "videoLink": videoLink,
        "description": description,
      };
}
