import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:projek_cuciklik/pages/login/login.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const route = "/splash";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    final box = GetStorage();
    bool? is_login = box.read('is_login');
    if (is_login == null || is_login == false) {
      Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, MyLogin.route),
      );
    } else {
      Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, '/beranda'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(199, 68, 235, 247)),
        child: Center(
          child: Image.asset(
            "assets/logo.png",
            height: 300,
          ),
        ),
      ),
    );
  }
}
