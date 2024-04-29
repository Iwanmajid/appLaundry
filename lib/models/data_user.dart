import 'package:dio/dio.dart';

final dio = Dio();


Future<bool> userLogin(String user, String password) async {
  var formdata = FormData.fromMap({"user": user, "password": password});
  final response = await dio.post('https://cuciklik.000webhostapp.com/login.php', data: formdata);
  print(response);
  if (response.statusCode == 200) {
    //log(json.decode(response.body).toString());
    // var mdTransaksi = List<ModelTransaksi>.from(json.decode(response.body)).map((e) => e);
    // final res = json.decode(response.data);
    // log(res[0]["total"]);
    return true;
  } else {
    return false;
  }
}
