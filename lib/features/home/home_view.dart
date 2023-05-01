import 'package:flutter/material.dart';

import '../../router/root_router_delegate.dart';
import 'components/home_bottom_navigation.dart';
import 'router/home_router_delegate.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homeRouterDelegate = HomeRouterDelegate();

  @override
  Widget build(BuildContext context) {
    final childBackButtonDispatcher = RootRouterDelegate.of(context).createChildBackButtonDispatcher();
    childBackButtonDispatcher?.takePriority();

    return Scaffold(
      body: Router(
        routerDelegate: homeRouterDelegate,
        backButtonDispatcher: childBackButtonDispatcher,
      ),
      bottomNavigationBar: UnconstrainedBox(
        constrainedAxis: Axis.horizontal,
        child: AnimatedBuilder(
          animation: homeRouterDelegate,
          builder: (_, __) {
            return HomeBottomNavigationBar(
              currentTab: homeRouterDelegate.currentPage,
              onTap: homeRouterDelegate.onTapBottomNavigationBarItem,
            );
          },
        ),
      ),
    );
  }
}
