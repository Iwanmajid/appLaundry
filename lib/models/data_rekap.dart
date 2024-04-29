import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

final dio = Dio();

Future<int> getHttp() async {
  final response = await dio.get('https://cuciklik.000webhostapp.com/rekap.php');
  print(response);
  if (response.statusCode == 200) {
    //log(json.decode(response.body).toString());
    // var mdTransaksi = List<ModelTransaksi>.from(json.decode(response.body)).map((e) => e);
    final res = json.decode(response.data);
    log(res[0]["total"]);
    return int.parse(res[0]["total"]);
  } else {
    log("error");
    return 0;
  }
}

Future<int> getPendapatan(String tanggal) async {
  log(tanggal);
  var formdata = FormData.fromMap({"search": tanggal});
  final response = await dio
      .post('https://cuciklik.000webhostapp.com/carirekap.php', data: formdata);
  print(response);
  if (response.statusCode == 200) {
    //log(json.decode(response.body).toString());
    // var mdTransaksi = List<ModelTransaksi>.from(json.decode(response.body)).map((e) => e);
    final res = json.decode(response.data);
    log(res[0]["total"]);
    return int.parse(res[0]["total"]);
  } else {
    log("error");
    return 0;
  }
}
