import 'package:flutter/material.dart';

import '../../router/root_router_delegate.dart';
import '../../support/mixins/post_frame_callback.dart';
import 'splash_view.dart';

class SplashViewController extends StatefulWidget {
  const SplashViewController({super.key});

  @override
  State<SplashViewController> createState() => _SplashViewControllerState();
}

class _SplashViewControllerState extends State<SplashViewController>
    with PostFrameCallBack, SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void postFrameCallback() {
    final ticker = _controller.forward();
    Future.wait([ticker]).whenComplete(() {
      routerDelegate.finishInitialLoading();
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SplashView(controller: _controller);
  }

  RootRouterDelegate get routerDelegate {
    return RootRouterDelegate.of(context);
  }
}
