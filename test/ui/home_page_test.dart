import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parking_lot_app/ui/pages/home/home_page.dart';

import '../mock/presentation/home_presenter_spy.dart';

void main() {
  late HomePresenterSpy presenter;

  setUp(() {
    presenter = HomePresenterSpy();
  });

  testWidgets('Should show error text', (WidgetTester tester) async {
    presenter.mockFetchError();

    await tester.pumpWidget(MaterialApp(home: HomePage(presenter)));

    await tester.pumpAndSettle();

    expect(
        find.text('Sem dados disponíveis, tente novamente.'), findsOneWidget);
  });

  testWidgets('Should show parking spots if success',
      (WidgetTester tester) async {
    presenter.mockFetchSuccess();

    await tester.pumpWidget(MaterialApp(home: HomePage(presenter)));

    await tester.pumpAndSettle();

    expect(find.byType(GridView), findsWidgets);
  });
}
