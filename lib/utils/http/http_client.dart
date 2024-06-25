import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nabeey/data/models/file_model.dart';
import 'package:nabeey/features/explore/models/audio_model.dart';
import 'package:nabeey/features/explore/models/video_model.dart';
import 'package:nabeey/utils/constants/api_constants.dart';
import 'package:nabeey/features/explore/models/user_model.dart';
import 'package:nabeey/features/explore/models/article_model.dart';
import 'package:nabeey/features/explore/models/category_model.dart';

// class HttpHelper {
//   HttpHelper();

// static const String _baseUrl = "https://api.nabeey.uz";

// static const String categoryC = 'api/content-categories/create/';
// static const String categoryR = 'api/content-categories/get-by-id/';
// static const String categoryU = 'api/content-categories/update/';
// static const String categoryD = 'api/content-categories/delete/';

// static const String categoriesR = 'api/content-categories/get-all/';

// static const String articleC = 'api/articles/create/';
// static const String articleR = 'api/articles/get-by-id/';
// static const String articleU = 'api/articles/update/';
// static const String articleD = 'api/articles/delete/';

// static const String articlesR = 'api/articles/get-all/';

// static const String videoC = 'api/articles/create/';
// static const String videoR = 'api/articles/get-by-id/';
// static const String videoU = 'api/articles/update/';
// static const String videoD = 'api/articles/delete/';

// static const String videosR = 'api/articles/get-all/';

// static const String youtubeR = 'https://www.googleapis.com/youtube/v3/videos?part=snippet&id=$videoId&key=$apiKey';

// static const String audioC = 'api/audios/create/';
// static const String audioR = 'api/audios/get-by-id/';
// static const String audioU = 'api/audios/update/';
// static const String audioD = 'api/audios/delete/';

// static const String audiosR = 'api/audios/get-all/';

//   Future<Map<String, dynamic>> get(String endpoint) async {
//     final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
//     return _handleResponse(response);
//   }

//   Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
//     final response = await http.post(
//       Uri.parse('$_baseUrl/$endpoint'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(data),
//     );
//     return _handleResponse(response);
//   }

//   Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> data) async {
//     final response = await http.put(
//       Uri.parse('$_baseUrl/$endpoint'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(data),
//     );
//     return _handleResponse(response);
//   }

//   Future<Map<String, dynamic>> delete(String endpoint) async {
//     final response = await http.delete(
//       Uri.parse('$_baseUrl/$endpoint'),
//     );
//     return _handleResponse(response);
//   }

//   Future<Map<String, dynamic>> getVideoMetaData() async {
//     final response = await http.get(Uri.parse(youtubeR));
//     return _handleResponse(response);
//   }

//   Map<String, dynamic> _handleResponse(http.Response response) {
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load data: ${response.statusCode}');
//     }
//   }
// }

class HttpHelper {
  HttpHelper();

  static const String _baseUrl = "https://api.nabeey.uz";

  static const String categoryC = 'api/content-categories/create/';
  static const String categoryR = 'api/content-categories/get-by-id/';
  static const String categoryU = 'api/content-categories/update/';
  static const String categoryD = 'api/content-categories/delete/';

  static const String categoriesR = 'api/content-categories/get-all/';

  static const String articleC = 'api/articles/create/';
  static const String articleR = 'api/articles/get-by-id/';
  static const String articleU = 'api/articles/update/';
  static const String articleD = 'api/articles/delete/';

  static const String articlesR = 'api/articles/get-all/';

  static const String videoC = 'api/videos/create/';
  static const String videoR = 'api/videos/get-by-id/';
  static const String videoU = 'api/videos/update/';
  static const String videoD = 'api/videos/delete/';

  static const String videosR = 'api/videos/get-all/';

  static const String youtubeR = 'https://www.googleapis.com/youtube/v3/videos?part=snippet&id=';

  static const String audioC = 'api/audios/create/';
  static const String audioR = 'api/audios/get-by-id/';
  static const String audioU = 'api/audios/update/';
  static const String audioD = 'api/audios/delete/';

  static const String audiosR = 'api/audios/get-all/';

  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = Jsons().get('$_baseUrl/$endpoint');
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    final response = Jsons().get('$_baseUrl/$endpoint');
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> data) async {
    final response = Jsons().get('$_baseUrl/$endpoint');
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = Jsons().get('$_baseUrl/$endpoint');
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> getVideoData(String videoId) async {
    final uri = Uri.parse('$youtubeR$videoId&key=${ADAPIs.youTubeSecretApiKey}');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      return jsonData;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Map<String, dynamic> _handleResponse(Map<String, dynamic> response) {
    if (response['statusCode'] == 200) {
      return response;
    } else {
      throw Exception('Failed to load data: ${response['statusCode']}');
    }
  }
}

class Jsons {
  Jsons();

  static List<Map<String, dynamic>> createCategories() {
    List<Map<String, dynamic>> categories = [];

    for (int i = 1; i <= 4; i++) {
      categories.add(CategoryModel(
              id: i,
              name: 'Kategoriya $i',
              image: FileModel(fileName: 'image-$i', filePath: 'https://picsum.photos/id/${i * 15}/350/250'),
              books: [],
              audios: [],
              videos: [],
              articles: [],
              description: "Test uchun kategoriya $i")
          .toJson());
    }
    return categories;
  }

  static List<Map<String, dynamic>> createArticles() {
    List<Map<String, dynamic>> articles = [];

    for (int i = 1; i <= 4; i++) {
      articles.add(
        ArticleModel(
          id: i,
          category: CategoryModel.fromJson(Jsons.createCategories()[0]),
          image: FileModel(fileName: 'image-$i', filePath: 'https://picsum.photos/id/${i * 25}/350/250'),
          user: UserModel.fromJson(UserModel(id: 1, firstName: 'Abdurahmon', lastName: 'Davronov', email: 'abdurakhmon278@gmail.com', phone: '+998915550895', userRole: 0).toJson()),
          text: "This is text of article-$i. cle-$i. This is text of . This is text of article-$i. This is text of article-$i. This is text of article-$i. This is text of article-$i. This is text",
        ).toJson(),
      );
    }
    return articles;
  }

  static const List<String> youtubeLinks = [
    "https://www.youtube.com/watch?v=52RySwIJS4M&list=PLY0icf9y8v8JuHaTNzOslMQDLtJ6EAVSj&index=7",
    'https://www.youtube.com/watch?v=tRe1DBOPbxM&list=PLY0icf9y8v8JuHaTNzOslMQDLtJ6EAVSj&index=7&pp=iAQB',
    'https://www.youtube.com/watch?v=EIAcRUbeN7o&list=PLY0icf9y8v8JuHaTNzOslMQDLtJ6EAVSj&index=8&pp=iAQB',
    'https://www.youtube.com/watch?v=ibAmzTS2h1Y&list=PLY0icf9y8v8JuHaTNzOslMQDLtJ6EAVSj&index=9&pp=iAQB',
  ];

  static List<Map<String, dynamic>> createVideos() {
    List<Map<String, dynamic>> videos = [];

    for (int i = 1; i <= 4; i++) {
      videos.add(
        VideoModel(
          id: 1,
          title: 'Video title-$i',
          // author: i <= 2 ? 'Author 1' : 'Author 2',
          author: 'Nurulloh Raufxon',
          videoLink: Jsons.youtubeLinks[i - 1],
          description: 'Video description $i',
        ).toJson(),
      );
    }
    return videos;
  }

  static const List<String> audioLinks = [
    "https://download.quranicaudio.com/quran/abdullaah_3awwaad_al-juhaynee/001.mp3",
    "https://media.blubrry.com/muslim_central_quran/podcasts.qurancentral.com/aaar-al-hudhoudi/002.mp3",
    "https://download.quranicaudio.com/quran/abdullaah_3awwaad_al-juhaynee/112.mp3",
    "https://download.quranicaudio.com/quran/abdullaah_3awwaad_al-juhaynee/113.mp3",
    "https://download.quranicaudio.com/quran/abdullaah_3awwaad_al-juhaynee/114.mp3",
  ];

  static List<Map<String, dynamic>> createAudios() {
    List<Map<String, dynamic>> audios = [];

    for (int i = 1; i <= 5; i++) {
      audios.add(AudioModel(
        id: i,
        title: 'Audio title - $i',
        audio: FileModel(fileName: 'audio-$i', filePath: Jsons.audioLinks[i - 1]),
        description: "Audio description - $i",
      ).toJson());
    }
    return audios;
  }

  Map<String, dynamic> get(String uri) => jsons[uri]!;

  Map<String, Map<String, dynamic>> jsons = {
    "${HttpHelper._baseUrl}/${HttpHelper.categoryC}": {
      "statusCode": 200,
      "message": "Successful",
      "data": Jsons.createCategories()[0],
    },
    "${HttpHelper._baseUrl}/${HttpHelper.categoryR}1": {
      "statusCode": 200,
      "message": "Successful",
      "data": Jsons.createCategories()[0],
    },
    "https://api.nabeey.uz/api/content-categories/update/1": {},
    "https://api.nabeey.uz/api/content-categories/delete/1": {"": ""},
    "${HttpHelper._baseUrl}/${HttpHelper.categoriesR}": {
      "statusCode": 200,
      "message": "Successful",
      "data": [Jsons.createCategories()[0], Jsons.createCategories()[1], Jsons.createCategories()[2], Jsons.createCategories()[3]],
    },
    "${HttpHelper._baseUrl}/${HttpHelper.articleC}": {
      "statusCode": 200,
      "message": "Successful",
      "data": Jsons.createArticles()[0],
    },
    "${HttpHelper._baseUrl}/${HttpHelper.articleR}": {
      "statusCode": 200,
      "message": "Successful",
      "data": Jsons.createArticles()[0],
    },
    "${HttpHelper._baseUrl}/${HttpHelper.articleU}1": {},
    "${HttpHelper._baseUrl}/${HttpHelper.articleD}1": {"": ""},
    "${HttpHelper._baseUrl}/${HttpHelper.articlesR}": {
      "statusCode": 200,
      "message": "Successful",
      "data": [Jsons.createArticles()[0], Jsons.createArticles()[1], Jsons.createArticles()[2], Jsons.createArticles()[3]],
    },
    "${HttpHelper._baseUrl}/${HttpHelper.videoC}": {
      "statusCode": 200,
      "message": "Successful",
      "data": Jsons.createArticles()[0],
    },
    "${HttpHelper._baseUrl}/${HttpHelper.videoR}": {
      "statusCode": 200,
      "message": "Successful",
      "data": Jsons.createArticles()[0],
    },
    "${HttpHelper._baseUrl}/${HttpHelper.videoU}1": {},
    "${HttpHelper._baseUrl}/${HttpHelper.videoD}1": {"": ""},
    "${HttpHelper._baseUrl}/${HttpHelper.videosR}": {
      "statusCode": 200,
      "message": "Successful",
      "data": [Jsons.createVideos()[0], Jsons.createVideos()[1], Jsons.createVideos()[2], Jsons.createVideos()[3]],
    },
    "${HttpHelper._baseUrl}/${HttpHelper.audiosR}": {
      "statusCode": 200,
      "message": "Successful",
      "data": [Jsons.createAudios()[0], Jsons.createAudios()[1], Jsons.createAudios()[2], Jsons.createAudios()[3], Jsons.createAudios()[4]],
    },
  };
}
