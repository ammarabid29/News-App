import 'package:flutter/material.dart';
import 'package:news_app/features/news/data/repositories/news_repository_imp.dart';
import 'package:news_app/features/news/domain/model/news_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_app/features/news/domain/usecases/news_use_cases.dart';

class AllNewsViewModel extends StateNotifier<NewsArticlesState> {
  AllNewsViewModel() : super(InitialNewsArticlesState());

  final NewsRepository _newsRepository = NewsRepositoryImp();
  late final GetNewsArticlesUseCase _getNewsArticlesUseCase =
      GetNewsArticlesUseCase(_newsRepository);

  void fetchPostsFromApi() async {
    try {
      state = NewsArticlesLoadingState();
      List<Articles> acticles = await _getNewsArticlesUseCase.call();
      state = NewsArticlesLoadedState(articles: acticles);
    } catch (e) {
      state = ErrorNewsArticlesState(
          message: 'Error fetching article from api: $e');
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
