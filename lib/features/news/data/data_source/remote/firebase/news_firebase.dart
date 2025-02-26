import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/core/constants/firebase.dart';
import 'package:news_app/features/news/domain/model/news_model.dart';

class NewsFirebase {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<List<Articles>> fetchSavedArticles(String userId) async {
    try {
      final querySnapshot = await DBCollections.users
          .doc(userId)
          .collection("savedArticles")
          .get();

      final List<Articles> articlesList = querySnapshot.docs.map((doc) {
        return Articles.fromJson(doc);
      }).toList();

      return articlesList;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> addArticle(String userId, Articles article) async {
    try {
      await DBCollections.users.doc(userId).collection("savedArticles").add(
        {
          'source': {
            'id': article.source?.id,
            'name': article.source?.name,
          },
          'author': article.author,
          'title': article.title,
          'description': article.description,
          'url': article.url,
          'urlToImage': article.urlToImage,
          'publishedAt': article.publishedAt,
          'content': article.content,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeArticle(String userId, Articles article) async {
    try {
      final querySnapshot = await DBCollections.users
          .doc(userId)
          .collection("savedArticles")
          .where("url", isEqualTo: article.url)
          .get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      rethrow;
    }
  }
}
