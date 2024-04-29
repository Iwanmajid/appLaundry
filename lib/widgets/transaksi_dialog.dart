import 'package:flutter/material.dart';
import 'package:projek_cuciklik/models/data_transaksi.dart';
import 'package:projek_cuciklik/models/model_transaksi.dart';
import 'package:projek_cuciklik/models/transaksi.dart';

class TransaksiDialog extends StatefulWidget {
  const TransaksiDialog({super.key, required this.item, required this.onChange});
  final ModelTransaksi item;
  final Function(Transaksi, String?) onChange;

  @override
  State<TransaksiDialog> createState() => _TransaksiDialogState();
}

class _TransaksiDialogState extends State<TransaksiDialog> {
  late String status;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    status = widget.item.status ?? "belum diambil";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Informasi'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nama'),
          Text(
            '${widget.item.nama}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5,
          ),
          Text('Tanggal Masuk'),
          Text(
            '${widget.item.tanggalMasuk}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5,
          ),
          Text('Jenis'),
          Text(
            '${widget.item.cucian}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5,
          ),
          Text('Berat'),
          Text(
            '${widget.item.berat}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5,
          ),
          Text('Total'),
          Text(
            'Rp. ${widget.item.totalHarga.toString()}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5,
          ),
          Text('Status'),
          DropdownButton(
            value: status,
            items: [
              DropdownMenuItem(
                child: Text('Sudah Diambil'),
                value: 'sudah diambil',
              ),
              DropdownMenuItem(
                child: Text('Belum Diambil'),
                value: 'belum diambil',
              )
            ],
            onChanged: (value) {
              setState(() {
                status = value!;
              });
            },
          ),
          SizedBox(
            height: 5,
          ),
          Text('Bisa Diambil'),
          Text(
            '${widget.item.tanggalAmbil}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Batal")),
        TextButton(
            onPressed: () async {
              await updateStatus(widget.item.id!, status);
              Navigator.pop(context);
            },
            child: Text("OK"))
      ],
    );
  }
}
