import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:projek_cuciklik/pages/beranda.dart';
import 'package:projek_cuciklik/pages/hasil_isi_transaksi.dart';
import 'package:projek_cuciklik/pages/login/login.dart';
import 'package:projek_cuciklik/pages/login/register.dart';
import 'package:projek_cuciklik/pages/splash/page.dart';

void main() async {
  await GetStorage.init();
  
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/splash',
    routes: {
      '/splash': (context) => SplashPage(),
      '/login': (context) => MyLogin(),
      '/register': (context) => MyRegister(),
      '/beranda': (context) => Beranda(),
      '/hasil': (context) => HasilIsiTransaksi(),
    },
  ));
}
