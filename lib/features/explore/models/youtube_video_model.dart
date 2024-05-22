class YouTubeVideoModel {
  int views;
  String date;
  String title;
  String image;
  String description;

  YouTubeVideoModel({
    required this.date,
    required this.title,
    required this.image,
    required this.views,
    required this.description,
  });

  factory YouTubeVideoModel.fromJson(Map<String, dynamic> json) => YouTubeVideoModel(
        views: 13354,
        title: json['title'],
        description: json['description'],
        image: json['thumbnails']['high']['url'],
        date: json['publishedAt'].toString().substring(0, 10),
      );
}
