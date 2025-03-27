import 'package:get_it/get_it.dart';

import 'package:nabeey/data/models/category_model.dart';
import 'package:nabeey/data/models/user_model.dart';
import 'package:nabeey/data/repositories/base_repository.dart';
import 'package:nabeey/data/repositories/video_repository.dart';
import 'package:nabeey/features/authentication/blocs/profile/profile_bloc.dart';
import 'package:nabeey/features/authentication/blocs/user/user_bloc.dart';
import 'package:nabeey/features/explore/blocs/base/base_bloc.dart';
import 'package:nabeey/features/explore/blocs/video/video_bloc.dart';
import 'package:nabeey/features/explore/models/article_model.dart';
import 'package:nabeey/features/explore/models/audio_model.dart';
import 'package:nabeey/features/explore/models/book_model.dart';
import 'package:nabeey/features/quiz/models/quiz_model.dart';
import 'package:nabeey/utils/helpers/network_manager.dart';

import '../features/authentication/blocs/signup/signup_bloc.dart';
import 'package:nabeey/data/repositories/auth_repository.dart';
import 'package:nabeey/features/authentication/blocs/login/login_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {
  _registerRepositories();
  _registerBlocs();
  _registerServices();
}

void _registerRepositories() {
  // Base repositories
  getIt.registerLazySingleton<BaseRepository<CategoryModel>>(
    () => BaseRepository<CategoryModel>(),
  );
  getIt.registerLazySingleton<BaseRepository<QuizModel>>(
    () => BaseRepository<QuizModel>(),
  );
  getIt.registerLazySingleton<BaseRepository<UserModel>>(
    () => BaseRepository<UserModel>(),
  );

  // Add AuthRepository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      userRepository: getIt<BaseRepository<UserModel>>(),
      networkManager: getIt<NetworkManager>(),
    ),
  );

  // Parameterized repositories
  getIt.registerFactoryParam<BaseRepository<ArticleModel>, int, void>(
    (categoryId, _) => BaseRepository<ArticleModel>()..categoryId = categoryId,
  );
  getIt.registerFactoryParam<VideoRepository, int, void>(
    (categoryId, _) => VideoRepository()..categoryId = categoryId,
  );
  getIt.registerFactoryParam<BaseRepository<AudioModel>, int, void>(
    (categoryId, _) => BaseRepository<AudioModel>()..categoryId = categoryId,
  );
  getIt.registerFactoryParam<BaseRepository<BookModel>, int, void>(
    (categoryId, _) => BaseRepository<BookModel>()..categoryId = categoryId,
  );
}

void _registerBlocs() {
  // Base blocs
  getIt.registerFactory<BaseBloc<CategoryModel>>(
    () => BaseBloc(getIt<BaseRepository<CategoryModel>>()),
  );
  getIt.registerFactory<BaseBloc<QuizModel>>(
    () => BaseBloc(getIt<BaseRepository<QuizModel>>()),
  );
  getIt.registerFactory<BaseBloc<UserModel>>(
    () => BaseBloc(getIt<BaseRepository<UserModel>>()),
  );
  getIt.registerFactory<ProfileBloc>(
    () => ProfileBloc(authRepository: getIt<AuthRepository>()),
  );

  // User bloc
  getIt.registerFactory<UserBloc>(
    () => UserBloc(
      baseRepository: getIt<BaseRepository<UserModel>>(),
      networkManager: getIt<NetworkManager>(),
    ),
  );

  // Parameterized blocs
  getIt.registerFactoryParam<BaseBloc<ArticleModel>, int, void>(
    (categoryId, _) => BaseBloc(
      getIt<BaseRepository<ArticleModel>>(param1: categoryId),
    ),
  );
  getIt.registerFactoryParam<VideoBloc, int, void>(
    (categoryId, _) => VideoBloc(
      videoRepository: getIt<VideoRepository>(param1: categoryId),
      networkManager: getIt<NetworkManager>(),
    ),
  );
  getIt.registerFactoryParam<BaseBloc<AudioModel>, int, void>(
    (categoryId, _) => BaseBloc(
      getIt<BaseRepository<AudioModel>>(param1: categoryId),
    ),
  );
  getIt.registerFactoryParam<BaseBloc<BookModel>, int, void>(
    (categoryId, _) => BaseBloc(
      getIt<BaseRepository<BookModel>>(param1: categoryId),
    ),
  );

  // Auth blocs
  getIt.registerFactory(
      () => SignupBloc(authRepository: getIt<AuthRepository>()));
  getIt.registerFactory(
      () => LoginBloc(authRepository: getIt<AuthRepository>()));
}

void _registerServices() {
  getIt.registerLazySingleton<NetworkManager>(() => NetworkManager());
}
