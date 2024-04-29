import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:projek_cuciklik/models/data_transaksi.dart';
import 'package:projek_cuciklik/widgets/transaksi_detail.dart';
import 'package:projek_cuciklik/widgets/transaksi_item.dart';

class HomeLayout extends StatefulWidget {
  void Function(int) pageChange;
  HomeLayout({super.key, required this.pageChange});

  // HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(padding: EdgeInsets.only(left: 5)),
                  const Text(
                    'Halo, Admin',
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final box = GetStorage();
                      box.remove('is_login');

                      Navigator.pushNamed(context, '/login');
                    },
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: Color.fromARGB(255, 219, 53, 53),
                      child: Icon(Icons.logout),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 5)),
                ],
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(250, 245, 245, 245),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(45),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Transaksi Terakhir",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext ctx) {
                                    return const TransaksiDetail();
                                  },
                                );
                              },
                              child: const Text(
                                'Lihat Semua',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: FutureBuilder(
                        future: getDataLimit(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  return TransaksiItem(
                                    transaction: snapshot.data[index],
                                  );
                                },
                                itemCount: snapshot.data.length,
                              );
                            }
                          } else if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return SizedBox();
                        },
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                widget.pageChange(1);
              },
              child: Icon(Icons.add),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  minimumSize: Size(60, 60),
                  shape: CircleBorder()),
            )),
      ],
    );
  }
}
