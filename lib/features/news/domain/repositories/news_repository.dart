import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/features/news/domain/model/news_model.dart';

abstract class NewsRepository {
  Future<List<Articles>> getNewsArticles();

  Future<List<Articles>> getFirebaseArticles(String userId);

  Future<void> toggleFirebaseArticle(String userId, Articles article);

  Future<void> logoutUser();

  User? getCurrentUser();
}
