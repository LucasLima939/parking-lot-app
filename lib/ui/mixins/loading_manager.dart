import 'dart:async';

import 'package:flutter/material.dart';

mixin LoadingManager {
  void handleLoading(BuildContext context, Stream<bool> stream) {
    StreamSubscription? subscription;
    Route? dialog;
    subscription = stream.listen((isLoading) {
      if (isLoading) {
        try {
          dialog = DialogRoute(
              context: context,
              barrierColor: Colors.transparent,
              barrierDismissible: false,
              useSafeArea: false,
              builder: (_) => WillPopScope(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onWillPop: () async => false));
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).push(dialog!);
          });
        } catch (ex) {
          dialog == null;
          subscription?.cancel();
        }
      } else {
        if (dialog != null) {
          try {
            Navigator.of(context).removeRoute(dialog!);
            dialog = null;
          } catch (e) {
            return;
          }
        }
      }
    });
  }
}
