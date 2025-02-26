import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/utils/utils.dart';
import 'package:news_app/features/news/data/repositories/news_repository_imp.dart';
import 'package:news_app/features/news/domain/model/news_model.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_app/features/news/domain/usecases/news_use_cases.dart';
import 'package:news_app/features/news/presentation/view/all_news/widgets/card_widget.dart';
import 'package:news_app/features/news/presentation/view/each_news/each_news_view.dart';
import 'package:news_app/features/news/presentation/view/favorite_news/favorite_news_view.dart';
import 'package:news_app/features/news/presentation/view_model/all_news/all_news_view_model.dart';
import 'package:news_app/features/news/presentation/view_model/logout/logout_view_model.dart';

class AllNewsView extends ConsumerStatefulWidget {
  const AllNewsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllNewsViewState();
}

class _AllNewsViewState extends ConsumerState<AllNewsView> {
  final Utils _utils = Utils();

  final newsArticlesProvider =
      StateNotifierProvider<AllNewsViewModel, NewsArticlesState>(
    (ref) => AllNewsViewModel(),
  );

  late final LogoutViewModel logoutViewModel;
  late final NewsRepository newsRepository;
  late final LogoutUserUseCase logoutUserUseCase;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(newsArticlesProvider.notifier).fetchPostsFromApi());
    super.initState();

    newsRepository = NewsRepositoryImp();

    logoutUserUseCase = LogoutUserUseCase(newsRepository);

    logoutViewModel = LogoutViewModel(logoutUserUseCase);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils().customAppbar(
        context,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FavoriteNewsView(),
            ));
          },
          icon: Icon(
            Icons.favorite,
            color: Colors.white,
          ),
        ),
        title: "News Screen",
        actions: [
          IconButton(
            onPressed: () {
              logoutViewModel.logout(context);
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: Consumer(
          builder: (ctx, ref, child) {
            NewsArticlesState state = ref.watch(newsArticlesProvider);

            if (state is InitialNewsArticlesState) {
              return const Text("Press FAB to Fetch Data");
            }
            if (state is NewsArticlesLoadingState) {
              return Center(
                child: _utils.spinKit(),
              );
            }
            if (state is ErrorNewsArticlesState) {
              return Text(state.message);
            }
            if (state is NewsArticlesLoadedState) {
              if (state.articles.isEmpty) {
                return Center(
                  child: Text("No News Article found!"),
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
