import 'package:flutter/material.dart';

class FadePage extends Page {
  final Widget child;

  const FadePage({required this.child, super.key, super.name});

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
