import 'package:news_app/features/news/domain/model/news_model.dart';

class NewsFirebase {
  Future<List<Articles>> fetchSavedArticles() async {
    return [Articles(), Articles()];
  }

  Future<void> uploadArticle(Articles article) async {}

  Future<void> deleteArticle(Articles article) async {}
}
