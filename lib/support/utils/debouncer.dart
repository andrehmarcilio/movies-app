import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  Timer? _timer;
  final Duration duration;

  Debouncer({required this.duration});

  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(duration, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
