class VideoDataModel {
  final String date;
  final String title;
  final String image;
  final String description;

  // Constructor
  VideoDataModel({
    required this.date,
    required this.title,
    required this.image,
    required this.description,
  });

  // Factory constructor for creating an instance from JSON
  factory VideoDataModel.fromJson(Map<String, dynamic> json) {
    return VideoDataModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: (json['thumbnails'] != null && json['thumbnails']['high'] != null) ? json['thumbnails']['high']['url'] ?? '' : '',
      date: json['publishedAt'] != null ? json['publishedAt'].toString().substring(0, 10) : '',
    );
  }

  // Static method to create an empty instance
  static VideoDataModel empty() {
    return VideoDataModel(
      date: '',
      title: '',
      image: '',
      description: '',
    );
  }
}
