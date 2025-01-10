import 'package:news_app/features/news/data/data_source/remote/network/news_data_source.dart';
import 'package:news_app/features/news/domain/model/news_model.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

class NewsRepositoryImp extends NewsRepository {
  final NewsDataSource dataSource = NewsDataSource();

  @override
  Future<List<Articles>> getNewsArticles() async {
    final articlesJson = await dataSource.fetchNewsArticles();
    return articlesJson;
  }

  @override
  Future<List<Articles>> getSavedArticles() async {
    return [Articles(), Articles()];
  }

  @override
  Future<void> saveArticle(Articles article) async {}

  @override
  Future<void> removeArticle(Articles article) async {}
}
