import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/utils/utils.dart';
import 'package:news_app/features/news/domain/model/news_model.dart';
import 'package:news_app/features/news/presentation/view/all_news/widgets/card_widget.dart';
import 'package:news_app/features/news/presentation/view/each_news/each_news_view.dart';
import 'package:news_app/features/news/presentation/view_model/favorite_news/favorites_news_view_model.dart';

class FavoriteNewsView extends ConsumerStatefulWidget {
  const FavoriteNewsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllNewsViewState();
}

class _AllNewsViewState extends ConsumerState<FavoriteNewsView> {
  final Utils _utils = Utils();
  // late final

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ref.read(favoriteNewsProvider.notifier).fetchPostsFromFirebase());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _utils.customAppbar(
        title: "Favorite News Screen",
        context,
      ),
      body: Center(
        child: Consumer(
          builder: (ctx, ref, child) {
            FavoriteArticlesState state = ref.watch(favoriteNewsProvider);

            if (state is FavoriteArticlesLoadingState) {
              return Center(
                child: _utils.spinKit(),
              );
            }
            if (state is ErrorFavoriteArticlesState) {
              return Text(state.message);
            }
            if (state is FavoriteArticlesLoadedState) {
              if (state.articles.isEmpty) {
                return Center(
                  child: Text("Try adding some favorites"),
                );
              } else {
                return ListView.builder(
                  itemCount: state.articles.length,
                  itemBuilder: (ctx, index) {
                    Articles article = state.articles[index];

                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EachNewsView(
                            article: article,
                          ),
                        ));
                      },
                      child: CardWidget(article: article),
                    );
                  },
                );
              }
            }
            return const Text("Nothing found");
          },
        ),
      ),
    );
  }
}
