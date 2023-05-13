import 'package:flutter/material.dart';

import 'dashboard_router_delegate.dart';

class DashboardRouter extends StatelessWidget {
  DashboardRouter({super.key});

  final dashboardRouterDelegate = DashboardRouterDelegate();

  @override
  Widget build(BuildContext context) {
    return Router(
      routerDelegate: dashboardRouterDelegate,
    );
  }
}
