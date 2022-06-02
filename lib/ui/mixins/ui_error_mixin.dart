import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parking_lot_app/ui/helpers/message/ui_error.dart';

mixin UiErrorMixin {
  void handleError(BuildContext? context, Stream<UiError> stream) {
    stream.listen((error) {
      if (error != UiError.none && context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red[900],
          content: Text(
            error.description(),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ));
      }
    });
  }
}
