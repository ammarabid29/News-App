import 'package:news_app/features/news/domain/model/news_model.dart';

abstract class NewsRepository {
  Future<List<Articles>> getNewsArticles();

  Future<List<Articles>> getSavedArticles();

  Future<void> saveArticle(Articles article);

  Future<void> removeArticle(Articles article);
}
