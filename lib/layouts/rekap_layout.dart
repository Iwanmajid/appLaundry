import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projek_cuciklik/models/data_rekap.dart';
import 'package:projek_cuciklik/models/model_transaksi.dart';

class RekapLayout extends StatefulWidget {
  const RekapLayout({super.key});

  @override
  State<RekapLayout> createState() => _RekapLayoutState();
}

class _RekapLayoutState extends State<RekapLayout> {
  TextEditingController cariTanggal = TextEditingController();
  List<ModelTransaksi> transaksi = [];
  int total = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cariTanggal.text = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
    // fetchData();
  }

  // void fetchData() async {
  //   final res = await getData();
  //   setState(() {
  //     transaksi = res;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white70),
          padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(padding: EdgeInsets.only(left: 10)),
                  const Text(
                    'REKAPITULASI PENDAPATAN',
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 10)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // Container(
              //   color: Colors.white,
              //   height: MediaQuery.of(context).size.height * 0.7,
              //   child: FutureBuilder(
              //     future: getData(),
              //     builder: (context, snapshot) {
              //       log(snapshot.connectionState.toString());
              //       if (snapshot.connectionState == ConnectionState.done) {
              //         if (snapshot.hasData) {
              //           final data = snapshot.data;
              //           log(data.toString());
              //           return ListView.builder(
              //             itemCount: data.length,
              //             itemBuilder: (context, index) {
              //               log(data[index].totalHarga);
              //               total += int.parse(data[index].totalHarga);

              //               return ListTile(
              //                 title: Text(
              //                   data[index].totalHarga ?? "",
              //                   style: TextStyle(color: Colors.black),
              //                 ),
              //               );
              //             },
              //           );
              //         }
              //       } else if (snapshot.connectionState == ConnectionState.waiting) {
              //         return Center(
              //           child: CircularProgressIndicator(),
              //         );
              //       }
              //       return SizedBox();
              //     },
              //   ),
              // ),
              TextField(
                controller: cariTanggal,
                decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: "Cari berdasarkan tanggal",
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
                      cariTanggal.text = tglMasuk; //set output date to TextField value.
                    });
                  } else {
                    print("Tanggal tidak dipilih");
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Center(child: Text("Pendapatan per tanggal ${cariTanggal.text}",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: Center(
                  child: FutureBuilder(
                    future: getPendapatan(cariTanggal.text),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Text("Rp. ${snapshot.data}",
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                          );
                        }else{
                          return Text(
                            "Rp. 0",
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                          );
                        }
                      } else if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(child: CircularProgressIndicator());
                      }
                      return SizedBox();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
