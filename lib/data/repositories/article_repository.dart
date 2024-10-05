import '../../utils/constants/api_constants.dart';
import '../../features/explore/models/article_model.dart';

import 'base_repository.dart';

class ArticleRepository extends BaseRepository<ArticleModel> {
  @override
  ArticleModel fromJson(Map<String, dynamic> json) => ArticleModel.fromJson(json);

  @override
  ArticleModel empty() => ArticleModel.empty();

  Future<List<ArticleModel>> getArticles() => getAll(ADAPIs.articlesR);

  Future<ArticleModel> getArticle(int articleId) => getById(ADAPIs.articleR, articleId);

  Future<ArticleModel> createArticle(ArticleModel article) => create(ADAPIs.articleC, article.toJson());

  Future<ArticleModel> updateArticle(int articleId, ArticleModel newArticle) => update(ADAPIs.articleU, articleId, newArticle.toJson());

  Future<void> deleteArticle(int articleId) => delete(ADAPIs.articleD, articleId);
}
