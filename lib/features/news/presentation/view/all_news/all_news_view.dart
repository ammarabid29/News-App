import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/notification_manager/notifications_services.dart';
import 'package:news_app/core/utils/utils.dart';
import 'package:news_app/features/auth/presentation/view_model/signout/logout_view_model.dart';
import 'package:news_app/features/news/domain/model/news_model.dart';
import 'package:news_app/features/news/presentation/view/all_news/widgets/card_widget.dart';
import 'package:news_app/features/news/presentation/view/each_news/each_news_view.dart';
import 'package:news_app/features/news/presentation/view/favorite_news/favorite_news_view.dart';
import 'package:news_app/features/news/presentation/view_model/all_news/all_news_view_model.dart';

class AllNewsView extends ConsumerStatefulWidget {
  const AllNewsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllNewsViewState();
}

class _AllNewsViewState extends ConsumerState<AllNewsView> {
  final LogoutViewModel _logoutViewModel = LogoutViewModel();
  final NotificationsServices _notificationsServices = NotificationsServices();

  final Utils _utils = Utils();

  final newsArticlesProvider =
      StateNotifierProvider<NewsArticlesNotifier, NewsArticlesState>(
    (ref) => NewsArticlesNotifier(),
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(newsArticlesProvider.notifier).fetchPostsFromApi());
    super.initState();
    _notificationsServices.requestNotificationPermission();
    _notificationsServices.firebaseInit(context);
    _notificationsServices.setupInteractMessage(context);
    _notificationsServices.isTokenRefresh();
    _notificationsServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print("Device token $value");
      }
    });
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
              _logoutViewModel.logout(context);
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
