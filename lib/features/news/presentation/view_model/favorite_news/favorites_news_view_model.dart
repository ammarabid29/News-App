import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/features/news/data/repositories/news_repository_imp.dart';
import 'package:news_app/features/news/domain/model/news_model.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_app/features/news/domain/usecases/news_use_cases.dart';

final favoriteNewsProvider =
    StateNotifierProvider<FavoriteNewsNotifier, FavoriteArticlesState>(
  (ref) => FavoriteNewsNotifier(),
);

class FavoriteNewsNotifier extends StateNotifier<FavoriteArticlesState> {
  FavoriteNewsNotifier() : super(InitialFavoriteArticlesState());

  final NewsRepository _newsRepository = NewsRepositoryImp();
  late final GetFirebaseArticlesUseCase _getFirebaseArticlesUseCase =
      GetFirebaseArticlesUseCase(_newsRepository);
  late final ToggleFirebaseArticleUseCase _toggleFirebaseArticleUseCase =
      ToggleFirebaseArticleUseCase(_newsRepository);
  late final GetCurrentUserUseCase _getCurrentUserUseCase =
      GetCurrentUserUseCase(_newsRepository);

  void fetchPostsFromFirebase() async {
    try {
      final String userId = _getCurrentUserUseCase.call()!.uid;
      state = FavoriteArticlesLoadingState();
      List<Articles> acticles = await _getFirebaseArticlesUseCase.call(userId);
      state = FavoriteArticlesLoadedState(articles: acticles);
    } catch (e) {
      state = ErrorFavoriteArticlesState(
          message: 'Error fetching articles from firebase: $e');
    }
  }

  void toggleArticleFromFirebase(Articles article) async {
    try {
      final String userId = _getCurrentUserUseCase.call()!.uid;
      state = FavoriteArticlesLoadingState();
      await _toggleFirebaseArticleUseCase.call(userId, article);
      fetchPostsFromFirebase();
    } catch (e) {
      state = ErrorFavoriteArticlesState(
          message: 'Error toggling article from firebases: $e');
    }
  }
}

@immutable
abstract class FavoriteArticlesState {}

class InitialFavoriteArticlesState extends FavoriteArticlesState {}

class FavoriteArticlesLoadingState extends FavoriteArticlesState {}

class FavoriteArticlesLoadedState extends FavoriteArticlesState {
  final List<Articles> articles;
  FavoriteArticlesLoadedState({required this.articles});
}

class ErrorFavoriteArticlesState extends FavoriteArticlesState {
  final String message;
  ErrorFavoriteArticlesState({required this.message});
}
