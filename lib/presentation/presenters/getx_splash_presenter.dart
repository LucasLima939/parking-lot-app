import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:parking_lot_app/presentation/mixins/navigation_manager.dart';
import 'package:parking_lot_app/ui/pages/splash/splash_presenter.dart';

class GetxSplashPresenter extends GetxController
    with NavigationManager
    implements SplashPresenter {
  @override
  Future<void> init() async {
    await Future.delayed(Duration(seconds: 2));
    navigateTo = '/home';
  }
}
