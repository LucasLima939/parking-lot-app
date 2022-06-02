import 'package:flutter/material.dart';
import 'package:parking_lot_app/factories/pages/home_page_factory.dart';
import 'package:parking_lot_app/factories/pages/splash_page_factory.dart';

import 'factories/cache/local_storage_configure.dart';
import 'factories/pages/history_page_factory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await makeLocalStorageConfigure().configure();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estacionamento Seu João',
      theme: ThemeData(
        primarySwatch: parkingBlue,
      ),
      routes: <String, Widget Function(BuildContext)>{
        '/splash': (_) => makeSplashPage(),
        '/home': (_) => makeHomePage(),
        '/history': (_) => makeHistoryPage(),
      },
      initialRoute: '/splash',
    );
  }
}

const MaterialColor parkingBlue = MaterialColor(
  0xff0066FF,
  <int, Color>{
    50: Color(0xff0066FF),
    100: Color(0xff0066FF),
    200: Color(0xff0066FF),
    300: Color(0xff0066FF),
    400: Color(0xff0066FF),
    500: Color(0xff0066FF),
    600: Color(0xff0066FF),
    700: Color(0xff0066FF),
    800: Color(0xff0066FF),
    900: Color(0xff0066FF),
  },
);
