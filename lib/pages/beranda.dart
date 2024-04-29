import 'package:flutter/material.dart';
import 'package:projek_cuciklik/layouts/home_layout.dart';
import 'package:projek_cuciklik/layouts/printer_layout.dart';
import 'package:projek_cuciklik/layouts/rekap_layout.dart';
import 'package:projek_cuciklik/layouts/transaksi_layout.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  int _index = 0;
  // final layouts = [
  //   HomeLayout(),
  //   TransaksiLayout(),
  //   RekapLayout(),
  //   HalPrinter()
  // ];
  @override
  Widget build(BuildContext context) {
    void changePage(int val) {
      setState(() {
        _index = val;
      });
    }

    final layouts = [
      HomeLayout(pageChange: changePage),
      TransaksiLayout(),
      RekapLayout(),
      HalPrinter()
    ];

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/beranda.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: SizedBox(),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: layouts[_index],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            // setState(() {
            //   _index = value;
            // });
            changePage(value);
          },
          currentIndex: _index,
          selectedItemColor: Colors.greenAccent[700],
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Transaksi"),
            BottomNavigationBarItem(icon: Icon(Icons.receipt), label: "Rekapitulasi"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Pengaturan")
          ],
        ),
      ),
    );
  }
}
