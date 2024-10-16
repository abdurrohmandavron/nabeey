import 'package:get_it/get_it.dart';
import 'package:nabeey/data/repositories/base_repository.dart';
import 'package:nabeey/data/repositories/video_repository.dart';
import 'package:nabeey/features/explore/models/book_model.dart';
import 'package:nabeey/features/explore/models/audio_model.dart';
import 'package:nabeey/features/explore/models/article_model.dart';
import 'package:nabeey/features/explore/blocs/base/base_bloc.dart';
import 'package:nabeey/features/explore/models/category_model.dart';
import 'package:nabeey/features/explore/blocs/video/video_bloc.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Registering repositories
  getIt.registerLazySingleton<BaseRepository<CategoryModel>>(() => BaseRepository<CategoryModel>());
  getIt.registerFactoryParam<BaseRepository<ArticleModel>, int, void>((categoryId, _) => BaseRepository<ArticleModel>()..categoryId = categoryId);
  getIt.registerFactoryParam<VideoRepository, int, void>((categoryId, _) => VideoRepository()..categoryId = categoryId);
  getIt.registerFactoryParam<BaseRepository<AudioModel>, int, void>((categoryId, _) => BaseRepository<AudioModel>()..categoryId = categoryId);
  getIt.registerFactoryParam<BaseRepository<BookModel>, int, void>((categoryId, _) => BaseRepository<BookModel>()..categoryId = categoryId);

  // Registering BLoCs
  getIt.registerFactory<BaseBloc<CategoryModel>>(() => BaseBloc(getIt<BaseRepository<CategoryModel>>()));
  getIt.registerFactoryParam<BaseBloc<ArticleModel>, int, void>((categoryId, _) => BaseBloc(getIt<BaseRepository<ArticleModel>>(param1: categoryId)));
  getIt.registerFactoryParam<VideoBloc, int, void>((categoryId, _) => VideoBloc(getIt<VideoRepository>(param1: categoryId)));
  getIt.registerFactoryParam<BaseBloc<AudioModel>, int, void>((categoryId, _) => BaseBloc(getIt<BaseRepository<AudioModel>>(param1: categoryId)));
  getIt.registerFactoryParam<BaseBloc<BookModel>, int, void>((categoryId, _) => BaseBloc(getIt<BaseRepository<BookModel>>(param1: categoryId)));
}
