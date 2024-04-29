import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projek_cuciklik/models/data_cucian.dart';
import 'package:projek_cuciklik/models/data_transaksi.dart';
import 'package:projek_cuciklik/models/model_cucian.dart';
import 'package:projek_cuciklik/models/model_transaksi.dart';

class TransaksiLayout extends StatefulWidget {
  const TransaksiLayout({super.key});

  @override
  State<TransaksiLayout> createState() => _TransaksiLayoutState();
}

class _TransaksiLayoutState extends State<TransaksiLayout> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController dateout = TextEditingController();
  ModelCucian? pilih;
  TextEditingController cNama = TextEditingController();
  TextEditingController cNohp = TextEditingController();
  TextEditingController cAlamat = TextEditingController();
  TextEditingController cBerat = TextEditingController();
  TextEditingController cHarga = TextEditingController();
  TextEditingController cTotalHarga = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // List<ModelCucian> kategoriCucian = [];
  List<ModelCucian> kategoriCucian = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCucian();
  }

  Future fetchCucian() async {
    List<ModelCucian> tmp = await getDataCucian();
    setState(() {
      kategoriCucian = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    log("hasil: ${kategoriCucian}");
    return ListView(
      children: [
        Container(
          // height: MediaQuery.of(context).size.height * 0.5,
          // width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
            color: Color.fromARGB(250, 245, 245, 245),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'TRANSAKSI',
                      style: TextStyle(
                        // color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Harus diisi";
                    }
                    return null;
                  },
                  controller: cNama,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Nama',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Harus diisi";
                    }
                    return null;
                  },
                  controller: cNohp,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Nomor HP',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Harus diisi";
                    }
                    return null;
                  },
                  controller: cAlamat,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Alamat',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Harus diisi";
                    }
                    return null;
                  },
                  controller: dateinput,
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Tanggal masuk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? tanggalMasuk = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime(2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (tanggalMasuk != null) {
                      print(tanggalMasuk); //tanggalMasuk output format => 2021-03-10 00:00:00.000
                      String tglMasuk = DateFormat('yyyy-MM-dd').format(tanggalMasuk);
                      print(tglMasuk); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        dateinput.text = tglMasuk; //set output date to TextField value.
                      });
                    } else {
                      print("Tanggal tidak dipilih");
                    }
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Harus diisi";
                    }
                    return null;
                  },
                  controller: dateout,
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Tanggal ambil",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? tanggalAmbil = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime(2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (tanggalAmbil != null) {
                      print(tanggalAmbil); //tanggalAmbil output format => 2021-03-10 00:00:00.000
                      String tglAmbil = DateFormat('yyyy-MM-dd').format(tanggalAmbil);
                      print(tglAmbil); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        dateout.text = tglAmbil; //set output date to TextField value.
                      });
                    } else {
                      print("Tanggal tidak dipilih");
                    }
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        hint: Text("Pilih Jenis Cucian"),
                        value: pilih,
                        items: kategoriCucian.map<DropdownMenuItem<ModelCucian>>((item) {
                          return DropdownMenuItem<ModelCucian>(
                              value: item, child: Text(item.cucian ?? "-"));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            pilih = value;
                          });
                        }),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Harus diisi";
                    }
                    return null;
                  },
                  controller: cBerat,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Berat Cucian',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
                  onPressed: () async {
                    // log("total harga : ${int.parse(cBerat.text) * int.parse(pilih!.harga ?? "0")}");
                    if (formKey.currentState!.validate()) {
                      var tglMasuk = DateFormat("yyyy-MM-dd")
                          .format(DateTime.parse(dateinput.text))
                          .toString();
                      var tglKeluar =
                          DateFormat("yyyy-MM-dd").format(DateTime.parse(dateout.text)).toString();
                      var totalHarga = int.parse(cBerat.text) * int.parse(pilih!.harga ?? "0");
                      ModelTransaksi? res = await insertData(
                          cNama.text,
                          cNohp.text,
                          cAlamat.text,
                          tglMasuk,
                          tglKeluar,
                          pilih!.id!,
                          cBerat.text,
                          pilih!.harga!,
                          totalHarga.toString());
                      if (res != null) {
                        Navigator.pushNamed(context, '/hasil', arguments: {
                          'nama': res.nama,
                          'cucian': res.cucian,
                          'tgl_masuk': res.tanggalMasuk,
                          'berat': res.berat,
                          'total_harga': res.totalHarga
                        });
                      }
                    } else {
                      //validasi
                      showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                          title: Text('Error'),
                          content: Text("Harus diisi"),
                        ),
                      );
                    }
                  },
                  child: const Text('PROSES', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
