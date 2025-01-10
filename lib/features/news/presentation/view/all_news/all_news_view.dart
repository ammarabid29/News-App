import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/utils/utils.dart';
import 'package:news_app/features/news/domain/model/news_model.dart';
import 'package:news_app/features/news/presentation/view/all_news/widgets/card_widget.dart';
import 'package:news_app/features/news/presentation/view_model/all_news/all_news_view_model.dart';

class AllNewsView extends ConsumerStatefulWidget {
  const AllNewsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllNewsViewState();
}

class _AllNewsViewState extends ConsumerState<AllNewsView> {
  final newsArticlesProvider =
      StateNotifierProvider<NewsArticlesNotifier, NewsArticlesState>(
    (ref) => NewsArticlesNotifier(),
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(newsArticlesProvider.notifier).fetchPosts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils().customAppbar(title: "News Screen", context),
      body: Center(
        child: Consumer(
          builder: (ctx, ref, child) {
            NewsArticlesState state = ref.watch(newsArticlesProvider);

            if (state is InitialNewsArticlesState) {
              return const Text("Press FAB to Fetch Data");
            }
            if (state is NewsArticlesLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ErrorNewsArticlesState) {
              return Text(state.message);
            }
            if (state is NewsArticlesLoadedState) {
              return ListView.builder(
                itemCount: state.articles.length,
                itemBuilder: (ctx, index) {
                  Articles articles = state.articles[index];

                  return CardWidget(article: articles);
                },
              );
            }
            return const Text("Nothing found");
          },
        ),
      ),
    );
  }
}
