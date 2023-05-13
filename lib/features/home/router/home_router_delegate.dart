import 'package:flutter/material.dart';

import '../../../router/base_router_delegate.dart';
import '../../../router/pages/fade_page.dart';
import '../../dashboard/router/dashboard_router.dart';
import '../../search/search_view.dart';
import '../enums/home_bottom_tabs.dart';
import 'home_router_configuration.dart';

class HomeRouterDelegate extends BaseRouterDelegate<HomeRouterConfiguration> {
  static HomeRouterDelegate of(BuildContext context) {
    return Router.of(context).routerDelegate as HomeRouterDelegate;
  }

  var _routerConfiguration = HomeRouterConfiguration();

  final _dashBoardRouter = DashboardRouter();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        FadePage(
          child: AnimatedBuilder(
            animation: this,
            builder: (context, child) {
              return IndexedStack(
                index: currentPage.index,
                children: [
                  _dashBoardRouter,
                  const SearchView(),
                  const SearchView(),
                  const SearchView(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalObjectKey<NavigatorState>(this);

  @override
  Future<void> setNewRoutePath(HomeRouterConfiguration configuration) async {
    _routerConfiguration = configuration;
  }

  HomeBottomTabs get currentPage => _routerConfiguration.currentTab;

  void onTapBottomNavigationBarItem(HomeBottomTabs newTab) {
    _routerConfiguration.changeTab(newTab);
    notifyListeners();
  }

  bool _handlePopPage(Route<dynamic> route, dynamic result) {
    final success = route.didPop(result);

    return success;
  }
}
