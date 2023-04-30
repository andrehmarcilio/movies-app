import 'package:flutter/material.dart';

mixin PostFrameCallBack<T extends StatefulWidget> on State<T> {
  void postFrameCallback() {}

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      postFrameCallback();
    });
  }
}
