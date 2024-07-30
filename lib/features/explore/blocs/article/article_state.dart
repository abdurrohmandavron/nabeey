import 'package:equatable/equatable.dart';
import 'package:nabeey/features/explore/models/article_model.dart';

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
