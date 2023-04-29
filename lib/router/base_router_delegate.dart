import 'package:flutter/material.dart';

abstract class BaseRouterDelegate<T> extends RouterDelegate<T> with ChangeNotifier, PopNavigatorRouterDelegateMixin<T> {
  ChildBackButtonDispatcher? createChildBackButtonDispatcher() {
    final routerContext = navigatorKey?.currentContext;

    if (routerContext == null) {
      return null;
    }
    final backButtonDispatcher = Router.of(routerContext).backButtonDispatcher;

    return backButtonDispatcher?.createChildBackButtonDispatcher();
  }
}
