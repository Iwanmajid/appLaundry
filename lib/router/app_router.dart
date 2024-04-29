import 'package:flutter/material.dart';
import 'package:projek_cuciklik/pages/login/login.dart';
import 'package:projek_cuciklik/pages/splash/page.dart';

class AppRouter {
  static Map<String, WidgetBuilder> routes = {
    SplashPage.route: (context) => const SplashPage(),
    MyLogin.route: (context) => const MyLogin(),
  };
}
