import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/utils/utils.dart';
import 'package:news_app/features/news/domain/model/news_model.dart';
import 'package:news_app/features/news/presentation/view_model/favorite_news/favorites_news_view_model.dart';

class EachNewsView extends ConsumerWidget {
  final Articles article;
  const EachNewsView({required this.article, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final format = DateFormat("MMMM dd, yyyy");
    DateTime dateTime = DateTime.parse(article.publishedAt.toString());

    final state = ref.watch(favoriteNewsProvider);
    final isArticleSaved = state is FavoriteArticlesLoadedState &&
        state.articles.any((savedArticle) => savedArticle.url == article.url);

    return Scaffold(
      floatingActionButton: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          if (state is FavoriteArticlesLoadingState) {
            return FloatingActionButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
          return FloatingActionButton(
            onPressed: () {
              ref
                  .read(favoriteNewsProvider.notifier)
                  .toggleArticleFromFirebase(article);
            },
            child: isArticleSaved
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
          );
        },
      ),
      appBar: Utils().customAppbar(
        context,
        title: article.source?.name ?? "News Article",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article.urlToImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    article.urlToImage!,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 16),
              if (article.title != null)
                Text(
                  article.title!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 8),
              if (article.author != null || article.publishedAt != null)
                Wrap(
                  children: [
                    if (article.author != null)
                      Text(
                        "By: ${article.author}",
                        style: const TextStyle(fontSize: 14),
                      ),
                    if (article.publishedAt != null)
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          format.format(dateTime),
                          style: TextStyle(fontSize: 14, color: Colors.blue),
                        ),
                      ),
                  ],
                ),
              const SizedBox(height: 16),
              if (article.description != null)
                Text(
                  textAlign: TextAlign.center,
                  article.description!,
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(height: 16),
              if (article.content != null)
                Text(
                  textAlign: TextAlign.center,
                  article.content!,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                )
            ],
          ),
        ),
      ),
    );
  }
}
