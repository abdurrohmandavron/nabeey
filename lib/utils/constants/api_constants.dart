class ADAPIs {
  /// YouTube Data API Key
  static const String youTubeSecretApiKey = 'AIzaSyC455mcFdJrv07Pq8qb4pKFIcuOWGirrTA';

  /// API Base URL
  static const String baseUrl = "http://nabeey.ddns.net:8080";

  /// API Endpoints
  static const String articleC = 'api/article/create';
  static const String articleU = 'api/article/update';
  static const String articleR = 'api/article/get/';
  static const String articlesR = 'api/article/get-all';
  static const String articleD = 'api/article/delete/';

  static const String bookC = 'api/books/create';
  static const String bookU = 'api/books/update';
  static const String bookD = 'api/books/delete/';
  static const String bookR = 'api/books/get/';
  static const String booksR = 'api/books/get-all';
  static const String booksRC = 'api/books/get-by-categoryId/';

  static const String audioC = 'api/content-audios/create';
  static const String audioU = 'api/content-audios/update';
  static const String audioD = 'api/content-audios/delete/';
  static const String audioR = 'api/content-audios/get/';
  static const String audiosR = 'api/content-audios/get-all';
  static const String audiosRC = 'api/content-audios/get-by-categoryId/';

  static const String categoryC = 'api/content-categories/create';
  static const String categoryU = 'api/content-categories/update';
  static const String categoryD = 'api/content-categories/delete/';
  static const String categoryR = 'api/content-categories/get/';
  static const String categoriesR = 'api/content-categories/get-all';

  static const String videoC = 'api/content-videos/create';
  static const String videoU = 'api/content-videos/update';
  static const String videoD = 'api/content-videos/delete/';
  static const String videoR = 'api/content-videos/get/';
  static const String videoRC = 'api/content-videos/get-by-categoryId/';
  static const String videosR = 'api/content-videos/get-all';
  static const String youtubeR = 'https://www.googleapis.com/youtube/v3/videos?part=snippet&id=';
}
