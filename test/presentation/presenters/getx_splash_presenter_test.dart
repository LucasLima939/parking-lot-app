import 'package:flutter_test/flutter_test.dart';
import 'package:parking_lot_app/presentation/presenters/getx_splash_presenter.dart';

void main() {
  late GetxSplashPresenter sut;

  setUp(() {
    sut = GetxSplashPresenter();
  });

  test('Should go to home on success', () async {
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/home')));
    await sut.init();
  });
}
