import 'package:flutter/material.dart';
import 'package:parking_lot_app/ui/mixins/navigation_manager.dart';
import 'package:parking_lot_app/ui/pages/splash/splash_presenter.dart';

class SplashPage extends StatefulWidget {
  final SplashPresenter presenter;
  const SplashPage(this.presenter, {Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with NavigationManager {
  @override
  void initState() {
    super.initState();
    handleNavigation(widget.presenter.navigateToStream, context, clear: true);
    widget.presenter.init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
