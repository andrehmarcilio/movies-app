import 'package:flutter/material.dart';

class UnanimatedPage extends Page {
  final Widget child;

  const UnanimatedPage({required this.child, super.key, super.name});

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (_, __, ___) => child,
    );
  }
}
