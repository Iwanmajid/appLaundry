import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:projek_cuciklik/models/model_cucian.dart';

Future getDataCucian() async {
  var uri = Uri.parse('https://cuciklik.000webhostapp.com/tampilcucian.php');
  var response = await http.get(uri);

  print(response.body);
  if (response.statusCode == 200) {
    //log(json.decode(response.body).toString());
    // var mdTransaksi = List<ModelTransaksi>.from(json.decode(response.body)).map((e) => e);
    final res = json.decode(response.body);
    List<ModelCucian> list = res.map<ModelCucian>((e) => ModelCucian.fromJson(e)).toList();
    log(list.toString());
    return list;
  } else {
    log("error");
    return [];
  }
}
