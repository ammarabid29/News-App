import 'package:flutter/material.dart';
import 'package:news_app/features/news/data/repositories/news_repository_imp.dart';
import 'package:news_app/features/news/domain/model/news_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

class NewsArticlesNotifier extends StateNotifier<NewsArticlesState> {
  NewsArticlesNotifier() : super(InitialNewsArticlesState());
  final NewsRepository _newsRepository = NewsRepositoryImp();

  void fetchPosts() async {
    try {
      state = NewsArticlesLoadingState();
      List<Articles> posts = await _newsRepository.getNewsArticles();
      state = NewsArticlesLoadedState(articles: posts);
    } catch (e) {
      state = ErrorNewsArticlesState(message: e.toString());
    }
  }
}

@immutable
abstract class NewsArticlesState {}

class InitialNewsArticlesState extends NewsArticlesState {}

class NewsArticlesLoadingState extends NewsArticlesState {}

class NewsArticlesLoadedState extends NewsArticlesState {
  final List<Articles> articles;
  NewsArticlesLoadedState({required this.articles});
}

class ErrorNewsArticlesState extends NewsArticlesState {
  final String message;
  ErrorNewsArticlesState({required this.message});
}
