import 'package:flutter/material.dart';
import 'package:parking_lot_app/factories/presenters/splash_presenter_factory.dart';
import 'package:parking_lot_app/ui/pages/splash/splash_page.dart';

Widget makeSplashPage() => SplashPage(makeSplashPresenter());
