import 'package:flutter/material.dart';
import 'package:parking_lot_app/factories/presenters/home_presenter_factory.dart';
import 'package:parking_lot_app/ui/pages/home/home_page.dart';

Widget makeHomePage() => HomePage(makeHomePresenter());
