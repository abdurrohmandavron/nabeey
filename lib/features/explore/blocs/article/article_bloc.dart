import 'package:nabeey/data/repositories/article_repository.dart';
import 'package:nabeey/features/explore/blocs/article/article_event.dart';
import 'package:nabeey/features/explore/blocs/article/article_state.dart';

import '../base/base_bloc.dart';

class ArticleBloc extends BaseBloc<ArticleEvent, ArticleState> {
  final ArticleRepository articleRepository;

  ArticleBloc(this.articleRepository) : super(const ArticleLoading()) {
    on<LoadArticles>((event, emit) async {
      try {
        final articles = await articleRepository.getArticles();
        emit(ArticleLoaded(articles));
      } catch (e) {
        handleError(emit, e);
      }
    });
  }
}
