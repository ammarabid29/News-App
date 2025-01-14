import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/features/news/domain/model/news_model.dart';

class NewsFirebase {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<Articles>> fetchSavedArticles(String userId) async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection("users")
          .doc(userId)
          .collection("savedArticles")
          .get();
      return querySnapshot.docs.map((doc) {
        return Articles(
          source: ArticleSource(
            id: doc['source']['id'],
            name: doc['source']['name'],
          ),
          author: doc['author'],
          title: doc['title'],
          description: doc['description'],
          url: doc['url'],
          urlToImage: doc['urlToImage'],
          publishedAt: doc['publishedAt'],
          content: doc['content'],
        );
      }).toList();
    } catch (e) {
      throw Exception('Error fetching articles: $e');
    }
  }

  Future<void> addArticle(String userId, Articles article) async {
    try {
      await _firebaseFirestore
          .collection("users")
          .doc(userId)
          .collection("savedArticles")
          .add(
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
      throw Exception('Error adding article: $e');
    }
  }

  Future<void> removeArticle(String userId, Articles article) async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection("users")
          .doc(userId)
          .collection("savedArticles")
          .where("url", isEqualTo: article.url)
          .get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception('Error removing article: $e');
    }
  }
}
