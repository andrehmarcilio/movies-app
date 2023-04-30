import 'package:get_it/get_it.dart';

class AppInjector {
  static final _provider = GetIt.instance;

  static void get<Type extends Object>() {
    _provider.get<Type>();
  }

  void initializeDependencies({bool testing = false}) {
    if (testing) {
      // TODO: Implements initializeDependencies when testing
      return;
    }
  }
}
