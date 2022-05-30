import 'package:flutter/material.dart';
import 'package:parking_lot_app/ui/pages/splash/splash_presenter.dart';

class SplashPage extends StatefulWidget {
  final SplashPresenter presenter;
  const SplashPage(this.presenter, {Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
