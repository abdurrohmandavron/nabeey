import 'package:get_it/get_it.dart';
import 'package:nabeey/data/repositories/base_repository.dart';
import 'package:nabeey/features/explore/blocs/base/base_bloc.dart';
import 'package:nabeey/features/explore/models/book_model.dart';
import 'package:nabeey/features/explore/models/audio_model.dart';
import 'package:nabeey/features/explore/models/video_model.dart';
import 'package:nabeey/features/explore/models/article_model.dart';
import 'package:nabeey/features/explore/models/category_model.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Registering repositories
  getIt.registerLazySingleton<BaseRepository<CategoryModel>>(() => BaseRepository<CategoryModel>());
  getIt.registerLazySingleton<BaseRepository<ArticleModel>>(() => BaseRepository<ArticleModel>());
  getIt.registerLazySingleton<BaseRepository<VideoModel>>(() => BaseRepository<VideoModel>());
  getIt.registerLazySingleton<BaseRepository<AudioModel>>(() => BaseRepository<AudioModel>());
  getIt.registerLazySingleton<BaseRepository<BookModel>>(() => BaseRepository<BookModel>());

  // Registering BLoCs
  getIt.registerFactory<BaseBloc<CategoryModel>>(() => BaseBloc(getIt<BaseRepository<CategoryModel>>()));
  getIt.registerFactory<BaseBloc<ArticleModel>>(() => BaseBloc(getIt<BaseRepository<ArticleModel>>()));
  getIt.registerFactory<BaseBloc<VideoModel>>(() => BaseBloc(getIt<BaseRepository<VideoModel>>()));
  getIt.registerFactory<BaseBloc<AudioModel>>(() => BaseBloc(getIt<BaseRepository<AudioModel>>()));
  getIt.registerFactory<BaseBloc<BookModel>>(() => BaseBloc(getIt<BaseRepository<BookModel>>()));
}
