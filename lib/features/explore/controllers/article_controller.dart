import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/exceptions/exceptions.dart';
import 'package:nabeey/data/repositories/article_repository.dart';
import 'package:nabeey/features/explore/models/article_model.dart';

class ArticleController extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepositoryImpl articleRepository = ArticleRepositoryImpl();

  ArticleController() : super(const ArticleLoading()) {
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

// ArticleEvent represents events that the ArticleBloc can react to
abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class LoadArticles extends ArticleEvent {
  const LoadArticles();

  @override
  String toString() => 'LoadArticles';
}

// ArticleState represents the state of the ArticleBloc
abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleLoading extends ArticleState {
  const ArticleLoading();

  @override
  String toString() => 'ArticleLoading';
}

class ArticleLoaded extends ArticleState {
  final List<ArticleModel> articles;

  const ArticleLoaded(this.articles);

  @override
  List<Object> get props => [articles];

  @override
  String toString() => 'ArticleLoaded { Articles: $articles }';
}

class ArticleEmpty extends ArticleState {
  const ArticleEmpty();

  @override
  String toString() => 'ArticleEmpty';
}

class ArticleError extends ArticleState {
  final String message;

  const ArticleError(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'ArticleError { message: $message }';
}
