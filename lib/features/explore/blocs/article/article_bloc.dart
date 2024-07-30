import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/exceptions/exceptions.dart';
import 'package:nabeey/data/repositories/article_repository.dart';
import 'package:nabeey/features/explore/blocs/article/article_event.dart';
import 'package:nabeey/features/explore/blocs/article/article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepositoryImpl articleRepository = ArticleRepositoryImpl();

  ArticleBloc() : super(const ArticleLoading()) {
    on<LoadArticles>((event, emit) async {
      try {
        final articles = await articleRepository.getArticles();
        emit(ArticleLoaded(articles));
      } on SocketException {
        emit(const ArticleError("Server bilan bog'lanib bo'lmadi."));
      } catch (e) {
        ADException(e);
        emit(ArticleError('ArticleError: $e'));
      }
    });
  }
}
