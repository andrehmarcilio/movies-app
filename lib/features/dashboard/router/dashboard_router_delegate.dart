import 'package:flutter/material.dart';

import '../../../router/base_router_delegate.dart';
import '../dashboard_view.dart';
import 'dashboard_router_configuration.dart';

class DashboardRouterDelegate extends BaseRouterDelegate<DashboardRouterConfiguration> {
  static DashboardRouterDelegate of(BuildContext context) {
    return Router.of(context).routerDelegate as DashboardRouterDelegate;
  }

  var _routerConfiguration = DashboardRouterConfiguration();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        const MaterialPage(child: DashboardView()),
        if (_routerConfiguration.selectedMovieId != null) const MaterialPage(child: SizedBox()),
      ],
    );
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalObjectKey<NavigatorState>(this);

  @override
  Future<void> setNewRoutePath(DashboardRouterConfiguration configuration) async {
    _routerConfiguration = configuration;
  }

  bool _handlePopPage(Route<dynamic> route, dynamic result) {
    final success = route.didPop(result);

    return success;
  }
}
