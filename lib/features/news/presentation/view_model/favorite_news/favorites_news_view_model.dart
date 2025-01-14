import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:news_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:news_app/features/news/data/repositories/news_repository_imp.dart';
import 'package:news_app/features/news/domain/model/news_model.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

final favoriteNewsProvider =
    StateNotifierProvider<FavoriteNewsNotifier, FavoriteArticlesState>(
  (ref) => FavoriteNewsNotifier(),
);

class FavoriteNewsNotifier extends StateNotifier<FavoriteArticlesState> {
  FavoriteNewsNotifier() : super(InitialFavoriteArticlesState());
  final NewsRepository _newsRepository = NewsRepositoryImp();
  final AuthRepository _authRepository = AuthRepositoryImpl();

  void fetchPostsFromFirebase() async {
    try {
      final String userId = _authRepository.getCurrentUser()!.uid;
      state = FavoriteArticlesLoadingState();
      List<Articles> acticles =
          await _newsRepository.getFirebaseArticles(userId);
      state = FavoriteArticlesLoadedState(articles: acticles);
    } catch (e) {
      state = ErrorFavoriteArticlesState(message: e.toString());
    }
  }

  void toggleArticleFromFirebase(Articles article) async {
    try {
      final String userId = _authRepository.getCurrentUser()!.uid;
      state = FavoriteArticlesLoadingState();
      await _newsRepository.toggleFirebaseArticle(userId, article);
      fetchPostsFromFirebase();
    } catch (e) {
      state = ErrorFavoriteArticlesState(message: 'Error toggling article: $e');
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
