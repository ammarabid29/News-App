import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/core/constants/constant.dart';
import 'package:news_app/features/news/domain/model/news_model.dart';

class NewsDataSource {
  Future<List<Articles>> fetchNewsArticles() async {
    String url = "$newsAPIBaseURL/top-headlines?country=us&apiKey=$newsAPIKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return (body['articles'] as List)
          .map((json) => Articles.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("Failed to fetch news articles: ${response.statusCode}");
    }
  }
}
