import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:projek_cuciklik/printer/print.dart';

class HasilIsiTransaksi extends StatefulWidget {
  const HasilIsiTransaksi({super.key});

  @override
  State<HasilIsiTransaksi> createState() => _HasilIsiTransaksiState();
}

class _HasilIsiTransaksiState extends State<HasilIsiTransaksi> {
  final prText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    log("hasil: ${json.encode(args)}");
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/beranda.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(250, 245, 245, 245),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'CUCI KLIK',
                        style: TextStyle(
                          // color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Center(
                      child: Text('_____________________________', style: TextStyle(fontSize: 20))),
                  Center(
                      child: Text(
                    '${args["tgl_masuk"]}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )),
                  SizedBox(
                    height: 50,
                  ),
                  Text('Nama Pelanggan'),
                  Text(
                    '${args["nama"]}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Jenis Cucian'),
                  Text(
                    '${args["cucian"]}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Berat'),
                  Text(
                    '${args["berat"]} Kg',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Total Harga'),
                  Text(
                    'Rp. ${args["total_harga"]}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Center(
                      child: Text('_____________________________', style: TextStyle(fontSize: 20))),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                      child: Text(
                    'Terima Kasih',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )),
                  Center(
                      child: Text(
                    'Atas Kepercayaan Anda',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
                    onPressed: () {
                      Print.cPrinter.printReceive(args);
                      Navigator.pushNamed(context, '/beranda');
                    },
                    child: const Text('CETAK',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
