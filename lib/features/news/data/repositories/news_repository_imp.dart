import 'package:news_app/core/notification_manager/local_notifications.dart';
import 'package:news_app/core/utils/utils.dart';
import 'package:news_app/features/news/data/data_source/remote/firebase/news_firebase.dart';
import 'package:news_app/features/news/data/data_source/remote/network/news_data_source.dart';
import 'package:news_app/features/news/domain/model/news_model.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

class NewsRepositoryImp extends NewsRepository {
  final NewsDataSource dataSource = NewsDataSource();
  final NewsFirebase newsFirebase = NewsFirebase();
  final Utils _utils = Utils();

  @override
  Future<List<Articles>> getNewsArticles() async {
    try {
      return await dataSource.fetchNewsArticles();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Articles>> getFirebaseArticles(String userId) async {
    try {
      return await newsFirebase.fetchSavedArticles(userId);
    } catch (e) {
      rethrow;
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

        LocalNotifications.showNotification(
          title: "Removed from favorites.",
          body: "${article.title} Removed",
          payload: "payload",
        );

        _utils.toastSuccessMessage("Removed from favorites");
      } else {
        await newsFirebase.addArticle(userId, article);

        LocalNotifications.showNotification(
          title: "Added to favorites.",
          body: "${article.title} Added",
          payload: "payload",
        );

        _utils.toastSuccessMessage("Added to favorites");
      }
    } catch (e) {
      rethrow;
    }
  }
}
