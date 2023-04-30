import 'package:flutter/material.dart';

import '../features/splash/splash_view_controller.dart';
import 'base_router_delegate.dart';
import 'root_router_configuration.dart';

class RootRouterDelegate extends BaseRouterDelegate<RootRouterConfiguration> {
  static RootRouterDelegate of(BuildContext context) {
    return Router.of(context).routerDelegate as RootRouterDelegate;
  }

  var _routerConfiguration = RootRouterConfiguration();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        if (_routerConfiguration.isInitialLoading) const MaterialPage(child: SplashViewController()),
        if (_routerConfiguration.appLoaded) MaterialPage(child: Scaffold(body: Container())),
      ],
    );
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(RootRouterConfiguration configuration) async {
    _routerConfiguration = configuration;
  }

  bool _handlePopPage(Route<dynamic> route, dynamic result) {
    final success = route.didPop(result);

    return success;
  }

  void finishInitialLoading() {
    _routerConfiguration.finishLoading();
    notifyListeners();
  }
}
