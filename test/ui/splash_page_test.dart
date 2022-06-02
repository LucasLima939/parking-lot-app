import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:parking_lot_app/ui/pages/splash/splash_page.dart';
import 'package:parking_lot_app/ui/pages/splash/splash_presenter.dart';

import '../mock/presentation/splash_presenter_spy.dart';

void main() {
  late SplashPresenter presenter;

  setUp(() {
    presenter = SplashPresenterSpy();
  });
  testWidgets('Show app logo correctly', (WidgetTester tester) async {
    await tester.pumpWidget(SplashPage(presenter));

    await tester.pumpAndSettle();

    expect(find.image(AssetImage('assets/logo.png')), findsOneWidget);
  });
}
