class YouTubeVideoModel {
  String date;
  String title;
  String image;
  String description;

  YouTubeVideoModel({
    required this.date,
    required this.title,
    required this.image,
    required this.description,
  });

  static YouTubeVideoModel empty() => YouTubeVideoModel(date: '', title: '', image: '', description: '');

  factory YouTubeVideoModel.fromJson(Map<String, dynamic> json) => YouTubeVideoModel(
        title: json['title'],
        description: json['description'],
        image: json['thumbnails']['high']['url'],
        date: json['publishedAt'].toString().substring(0, 10),
      );
}
