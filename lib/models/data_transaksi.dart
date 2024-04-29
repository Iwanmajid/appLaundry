import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:projek_cuciklik/models/model_transaksi.dart';

final dio = Dio();

Future getData() async {
  var uri = Uri.parse('https://cuciklik.000webhostapp.com/tampil.php');
  var response = await http.get(uri);

  print(response.body);
  if (response.statusCode == 200) {
    //log(json.decode(response.body).toString());
    // var mdTransaksi = List<ModelTransaksi>.from(json.decode(response.body)).map((e) => e);
    final res = json.decode(response.body);
    List<ModelTransaksi> list = res.map<ModelTransaksi>((e) => ModelTransaksi.fromJson(e)).toList();
    log(list.toString());
    return list;
  } else {
    log("error");
    return [];
  }
}

Future getDataLimit() async {
  var uri = Uri.parse('https://cuciklik.000webhostapp.com/limittampildata.php');
  var response = await http.get(uri);

  print(response.body);
  if (response.statusCode == 200) {
    //log(json.decode(response.body).toString());
    // var mdTransaksi = List<ModelTransaksi>.from(json.decode(response.body)).map((e) => e);
    final res = json.decode(response.body);
    List<ModelTransaksi> list = res.map<ModelTransaksi>((e) => ModelTransaksi.fromJson(e)).toList();
    log(list.toString());
    return list;
  } else {
    log("error");
    return [];
  }
}

Future<bool> updateStatus(String id, String status) async {
  var formdata = FormData.fromMap({"id": id, "status": status});
  final response = await dio.post('https://cuciklik.000webhostapp.com/update.php', data: formdata);
  print(response);
  if (response.statusCode == 200) {
    //log(json.decode(response.body).toString());
    // var mdTransaksi = List<ModelTransaksi>.from(json.decode(response.body)).map((e) => e);
    // final res = json.decode(response.data);
    // log(res[0]["total"]);
    return true;
  } else {
    log("error");
    return false;
  }
}

Future<ModelTransaksi?> insertData(String nama, String no_hp, String alamat, String tanggal_masuk,
    String tanggal_ambil, String cucian, String berat, String harga, String total_harga) async {
  var formdata = FormData.fromMap({
    "nama": nama,
    "no_hp": no_hp,
    "alamat": alamat,
    "tanggal_masuk": tanggal_masuk,
    "tanggal_ambil": tanggal_ambil,
    "cucian": cucian,
    "berat": berat,
    "harga": harga,
    "total_harga": total_harga
  });
  final response = await dio.post('https://cuciklik.000webhostapp.com/insert.php', data: formdata);
  print(response);
  if (response.statusCode == 200) {
    //log(json.decode(response.body).toString());
    final res = json.decode(response.data);
    List<ModelTransaksi> list = res.map<ModelTransaksi>((e) => ModelTransaksi.fromJson(e)).toList();
    // final res = json.decode(response.data);
    // log(res[0]["total"]);
    return list.length > 0 ? list[0] : null;
  } else {
    log("error");
    return null;
  }
}
