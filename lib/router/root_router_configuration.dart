class RootRouterConfiguration {
  bool isInitialLoading = true;
  bool appLoaded = false;

  void finishLoading() {
    isInitialLoading = false;
    appLoaded = true;
  }
}
