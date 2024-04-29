import 'package:flutter/material.dart';
import 'package:projek_cuciklik/pages/login/controller.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);
  static const route = "/login";
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  late final LoginController c;
  bool isHiden = true;
  @override
  void initState() {
    super.initState();
    c = LoginController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/beranda.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 75, top: 125),
            child: const Text(
              "Selamat Datang",
              style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: 35, left: 35, top: MediaQuery.of(context).size.height * 0.5),
              child: Form(
                key: c.formKey,
                child: Column(children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Harus diisi";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Harus diisi";
                      }
                      return null;
                    },
                    obscureText: isHiden,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isHiden = !isHiden;
                            });
                          },
                          child: isHiden ? Icon(Icons.visibility) : Icon(Icons.visibility_off)),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '  Masuk',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xff4c505b),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            // Navigator.pushNamed(context, '/beranda');
                            c.login(context);
                          },
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  //   TextButton(
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, '/register');
                  //     },
                  //     child: const Text(
                  //       'Daftar',
                  //       style: TextStyle(
                  //         decoration: TextDecoration.underline,
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.bold,
                  //         color: Color(0xff4c505b),
                  //       ),
                  //     ),
                  //   ),
                  //   TextButton(
                  //     onPressed: () {},
                  //     child: const Text(
                  //       'Lupa Password',
                  //       style: TextStyle(
                  //         decoration: TextDecoration.underline,
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.bold,
                  //         color: Color(0xff4c505b),
                  //       ),
                  //     ),
                  //   ),
                  // ]),
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
