import '../enums/home_bottom_tabs.dart';

class HomeRouterConfiguration {
  var _currentTab = HomeBottomTabs.dashboard;

  HomeBottomTabs get currentTab => _currentTab;

  void changeTab(HomeBottomTabs newTab) {
    _currentTab = newTab;
  }
}
