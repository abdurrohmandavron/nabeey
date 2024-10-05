class YouTubeVideoModel {
  final String date;
  final String title;
  final String image;
  final String description;

  // Constructor
  YouTubeVideoModel({
    required this.date,
    required this.title,
    required this.image,
    required this.description,
  });

  // Factory constructor for creating an instance from JSON
  factory YouTubeVideoModel.fromJson(Map<String, dynamic> json) {
    return YouTubeVideoModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: (json['thumbnails'] != null && json['thumbnails']['high'] != null) ? json['thumbnails']['high']['url'] ?? '' : '',
      date: json['publishedAt'] != null ? json['publishedAt'].toString().substring(0, 10) : '',
    );
  }

  // Static method to create an empty instance
  static YouTubeVideoModel empty() {
    return YouTubeVideoModel(
      date: '',
      title: '',
      image: '',
      description: '',
    );
  }
}
