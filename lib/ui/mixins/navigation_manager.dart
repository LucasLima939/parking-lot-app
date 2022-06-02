import 'package:flutter/material.dart';

mixin NavigationManager {
  void handleNavigation(Stream<String> stream, BuildContext context,
      {bool clear = false}) {
    stream.listen((page) {
      if (page.isNotEmpty == true) {
        if (clear == true) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacementNamed(page);
        } else {
          Navigator.of(context).pushNamed(page);
        }
      }
    });
  }
}
