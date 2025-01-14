import 'package:news_app/features/news/data/data_source/remote/firebase/news_firebase.dart';
import 'package:news_app/features/news/data/data_source/remote/network/news_data_source.dart';
import 'package:news_app/features/news/domain/model/news_model.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

class NewsRepositoryImp extends NewsRepository {
  final NewsDataSource dataSource = NewsDataSource();
  final NewsFirebase newsFirebase = NewsFirebase();

  @override
  Future<List<Articles>> getNewsArticles() async {
    try {
      return await dataSource.fetchNewsArticles();
    } catch (e) {
      throw Exception('Error in getting artcles from api: $e');
    }
  }

  @override
  Future<List<Articles>> getFirebaseArticles(String userId) async {
    try {
      return await newsFirebase.fetchSavedArticles(userId);
    } catch (e) {
      throw Exception('Error in getting artcles from firebase: $e');
    }
  }

  @override
  Future<void> toggleFirebaseArticle(String userId, Articles article) async {
    try {
      final savedArticles = await newsFirebase.fetchSavedArticles(userId);
      final isArticleSaved =
          savedArticles.any((savedArticle) => savedArticle.url == article.url);

      if (isArticleSaved) {
        await newsFirebase.removeArticle(userId, article);
      } else {
        await newsFirebase.addArticle(userId, article);
      }
    } catch (e) {
      throw Exception('Error toggling article: $e');
    }
  }
}
