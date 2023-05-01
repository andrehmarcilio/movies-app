import 'package:flutter/material.dart';

import '../../../router/base_router_delegate.dart';
import '../enums/home_bottom_tabs.dart';
import 'home_router_configuration.dart';

class HomeRouterDelegate extends BaseRouterDelegate<HomeRouterConfiguration> {
  static HomeRouterDelegate of(BuildContext context) {
    return Router.of(context).routerDelegate as HomeRouterDelegate;
  }

  var _routerConfiguration = HomeRouterConfiguration();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        _getCurrentPage(),
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

  Page _getCurrentPage() {
    final Widget currentView;
    switch (_routerConfiguration.currentTab) {
      case HomeBottomTabs.dashboard:
        currentView = Container(color: Colors.purpleAccent);
        break;
      case HomeBottomTabs.search:
        currentView = Container(color: Colors.yellow);
        break;
      case HomeBottomTabs.favorites:
        currentView = Container(color: Colors.blue);
        break;
      case HomeBottomTabs.profile:
        currentView = Container(color: Colors.red);
    }

    return MaterialPage(child: currentView);
  }

  bool _handlePopPage(Route<dynamic> route, dynamic result) {
    final success = route.didPop(result);

    return success;
  }
}
