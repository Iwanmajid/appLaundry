import 'package:flutter/material.dart';
import 'package:projek_cuciklik/models/data_transaksi.dart';
import 'package:projek_cuciklik/widgets/transaksi_dialog.dart';
import 'package:projek_cuciklik/widgets/transaksi_item.dart';

class TransaksiDetail extends StatefulWidget {
  const TransaksiDetail({Key? key}) : super(key: key);

  @override
  State<TransaksiDetail> createState() => _TransaksiDetailState();
}

class _TransaksiDetailState extends State<TransaksiDetail> {
  String search = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50, bottom: 10, left: 8, right: 8),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_ios),
              ),
              const Text(
                "RIWAYAT TRANSAKSI",
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFF3D538F),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: TextField(
            onChanged: (e) {
              setState(() {
                search = e;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
              hintText: 'Cari...',
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
        ),
        Expanded(
            child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                var data = snapshot.data;
                if (search.isNotEmpty) {
                  data = snapshot.data
                      .where((item) =>
                          item.nama.toString().toLowerCase().contains(search.toLowerCase()) || item.status.toString().toLowerCase().contains(search.toLowerCase()))
                      .toList();
                }
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (_) => TransaksiDialog(
                              item: snapshot.data[index],
                              onChange: (item, status) {
                                // setState(() {
                                //   transaksi[index].status = status!;
                                // });
                              },
                            ),
                          );
                          setState(() {});
                        },
                        child: TransaksiItem(transaction: data[index]));
                  },
                  itemCount: data.length,
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
    );
  }
}
