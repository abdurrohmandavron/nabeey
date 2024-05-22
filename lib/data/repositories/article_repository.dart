import 'package:flutter/material.dart';
import 'package:nabeey/utils/http/http_client.dart';
import 'package:nabeey/features/explore/models/article_model.dart';

abstract class ArticleRepository {
  @protected
  Future<List<ArticleModel>> getArticles();

  Future<ArticleModel?> getArticle(int articleId);

  Future<void> createArticle(ArticleModel article);

  Future<void> updateArticle(ArticleModel article);

  Future<void> deleteArticle(int articleId);
}

class ArticleRepositoryImpl implements ArticleRepository {
  final HttpHelper _httpClient = HttpHelper();

  ArticleRepositoryImpl();

  @override
  Future<List<ArticleModel>> getArticles() async {
    final response = await _httpClient.get(HttpHelper.articlesR);
    final List<dynamic> articleListJson = response['data'];
    final List<ArticleModel> articles = articleListJson.map((articleJson) => ArticleModel.fromJson(articleJson)).toList();
    return articles;
  }

  @override
  Future<ArticleModel?> getArticle(int articleId) async {
    final response = await _httpClient.get(HttpHelper.articleR);
    // Handle API response (error checking, data parsing)
    return response['data'] != null ? ArticleModel.fromJson(response['data']) : null;
  }

  @override
  Future<void> createArticle(ArticleModel article) async {
    // Send create Article request to API
    await _httpClient.post(HttpHelper.articleC, article.toJson());
  }

  @override
  Future<void> updateArticle(ArticleModel article) async {
    // Send update Article request to API
    await _httpClient.put(HttpHelper.articleU + article.id.toString(), article.toJson());
  }

  @override
  Future<void> deleteArticle(int articleId) async {
    // Send delete Article request to API
    await _httpClient.delete(HttpHelper.articleD + articleId.toString());
  }
}
