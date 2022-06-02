import 'dart:async';

import 'package:mocktail/mocktail.dart';
import 'package:parking_lot_app/ui/pages/splash/splash_presenter.dart';

class SplashPresenterSpy extends Mock implements SplashPresenter {
  Stream<String> get navigateToStream => StreamController<String>().stream;

  @override
  Future<void> init() async {}
}
