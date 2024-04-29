import 'package:flutter/material.dart';
import 'package:projek_cuciklik/models/model_transaksi.dart';
import 'package:projek_cuciklik/models/transaksi.dart';



class TransaksiItem extends StatelessWidget {
  final ModelTransaksi transaction;
  const TransaksiItem({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF3D538F),
          ),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 132, 187, 232),
                borderRadius: BorderRadius.circular(10)),
            // child: SizedBox(
            //   width: 35,
            //   height: 35,
            //   child: Center(
            //     child: Text(
            //       transaction.pelanggan.split(" ").map((e) => e.substring(0, 1)).toList().join(),
            //       style: const TextStyle(
            //         color: Color(0xFF3D538F),
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            //   // Image.network(
            //   //   this.image,
            //   // ),
            // ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    transaction.nama ?? "-",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xFF3D538F),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  transaction.cucian ?? "-",
                  style: const TextStyle(color: Color(0xFF3D538F), fontSize: 18,fontWeight: FontWeight.bold,),
                ),
                Text(
                  transaction.tanggalMasuk ?? "-",
                  style: const TextStyle(color: Color(0xFF3D538F), fontSize: 18),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  "Rp. ${transaction.totalHarga.toString()}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 0, 184, 95),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "${transaction.berat} Kg" ?? "-",
                style: const TextStyle(color: Color(0xFF3D538F), fontSize: 18),
              ),
              Text(
                transaction.status ?? "-",
                style: TextStyle(color: transaction.status=="belum diambil"?Colors.red:Colors.green,fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
