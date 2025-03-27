import 'package:nabeey/features/explore/models/article_model.dart';
import 'package:nabeey/features/explore/models/audio_model.dart';
import 'package:nabeey/features/explore/models/book_model.dart';
import 'package:nabeey/data/models/category_model.dart';
import 'package:nabeey/data/models/user_model.dart';
import 'package:nabeey/features/explore/models/video_model.dart';
import 'package:nabeey/features/quiz/models/quiz_model.dart';

class ADAPIs {
  /// API Endpoints
  static const Map<String, Map<Type, String>> endpoints = {
    'CREATE': {
      CategoryModel: 'api/content-categories/create',
      UserModel: 'api/user/create',
      ArticleModel: 'api/article/create',
      BookModel: 'api/books/create',
      AudioModel: 'api/content-audios/create',
      VideoModel: 'api/content-videos/create',
      QuizModel: 'api/quizzes/create',
    },
    'GET': {
      CategoryModel: 'api/content-categories/get/',
      UserModel: 'api/user/get/',
      ArticleModel: 'api/article/get/',
      BookModel: 'api/books/get/',
      AudioModel: 'api/content-audios/get/',
      VideoModel: 'api/content-videos/get/',
      QuizModel: 'api/quizzes/get/',
    },
    'GETBYCATEGORY': {
      ArticleModel: 'api/article/get-by-category/',
      BookModel: 'api/books/get-by-categoryId/',
      AudioModel: 'api/content-audios/get-by-categoryId/',
      VideoModel: 'api/content-videos/get-by-categoryId/',
    },
    'GETALL': {
      CategoryModel: 'api/content-categories/get-all',
      UserModel: 'api/user/get-all',
      ArticleModel: 'api/article/get-all',
      BookModel: 'api/books/get-all',
      AudioModel: 'api/content-audios/get-all',
      VideoModel: 'api/content-videos/get-all',
      QuizModel: 'api/quizzes/get-all',
    },
    'UPDATE': {
      CategoryModel: 'api/content-categories/update',
      UserModel: 'api/user/update',
      ArticleModel: 'api/article/update',
      BookModel: 'api/books/update',
      QuizModel: 'api/quizzes/update',
    },
    'DELETE': {
      CategoryModel: 'api/content-categories/delete/',
      UserModel: 'api/user/delete/',
      ArticleModel: 'api/article/delete/',
      BookModel: 'api/books/delete/',
      AudioModel: 'api/content-audios/delete/',
      VideoModel: 'api/content-videos/delete/',
      QuizModel: 'api/quizzes/delete/',
    },
    'LOGIN': {
      UserModel: 'api/auth/login',
    },
  };

  static const String youtubeBase = 'www.googleapis.com';
  static const String youtubeR = 'youtube/v3/videos';
}
