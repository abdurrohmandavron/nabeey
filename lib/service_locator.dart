import 'package:get_it/get_it.dart';
import 'package:nabeey/data/repositories/article_repository.dart';
import 'package:nabeey/data/repositories/audio_repository.dart';
import 'package:nabeey/data/repositories/book_repository.dart';
import 'package:nabeey/data/repositories/category_repository.dart';
import 'package:nabeey/data/repositories/video_repository.dart';
import 'package:nabeey/features/explore/blocs/article/article_bloc.dart';
import 'package:nabeey/features/explore/blocs/audio/audio_bloc.dart';
import 'package:nabeey/features/explore/blocs/book/book_bloc.dart';
import 'package:nabeey/features/explore/blocs/category/category_bloc.dart';
import 'package:nabeey/features/explore/blocs/video/video_bloc.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Registering repositories
  getIt.registerLazySingleton<CategoryRepository>(() => CategoryRepository());
  getIt.registerLazySingleton<ArticleRepository>(() => ArticleRepository());
  getIt.registerLazySingleton<VideoRepository>(() => VideoRepository());
  getIt.registerLazySingleton<AudioRepository>(() => AudioRepository());
  getIt.registerLazySingleton<BookRepository>(() => BookRepository());

  // Registering BLoCs
  getIt.registerFactory<CategoryBloc>(() => CategoryBloc(getIt<CategoryRepository>()));
  getIt.registerFactory<ArticleBloc>(() => ArticleBloc(getIt<ArticleRepository>()));
  getIt.registerFactory<VideoBloc>(() => VideoBloc(getIt<VideoRepository>()));
  getIt.registerFactory<AudioBloc>(() => AudioBloc(getIt<AudioRepository>()));
  getIt.registerFactory<BookBloc>(() => BookBloc(getIt<BookRepository>()));
}
