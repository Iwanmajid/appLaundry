import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:projek_cuciklik/models/data_user.dart';

class LoginController {
  final formKey = GlobalKey<FormState>();
  final unameController = TextEditingController();
  final passwordController = TextEditingController();
  final box = GetStorage();

  void login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final res = await userLogin(unameController.text, passwordController.text);
      if (res) {
        box.write('is_login', true);
        Navigator.pushNamed(context, '/beranda');
      } else {
        //menunjukkan kalau akun tidak ada
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text('Error'),
            content: Text("Username atau Password salah!"),
          ),
        );
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
  }
}
