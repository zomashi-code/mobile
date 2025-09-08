import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test/config/config.dart';
import 'package:test/model/request/customer_register_req';
import 'package:test/model/response/customer_register_res';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ลงทะเบียนสมาชิกใหม่'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [ 
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 0, 0),
              child: Text("ชื่อ-นามสกุล",
                style: TextStyle(

                ),
              ),
            ),
            Padding(
	          padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextField(
              controller: fullnameController,
              decoration: InputDecoration(
                border:
                  OutlineInputBorder(borderSide: BorderSide(width: 1)))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 30, 0, 0),
              child: Text("หมายเลขโทรศัพท์",
                style: TextStyle(
                ),
              ),
            ),
            Padding(
	          padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextField(
              controller: phoneController,
              decoration: InputDecoration(
                border:
                  OutlineInputBorder(borderSide: BorderSide(width: 1)))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 30, 0, 0),
              child: Text("อีเมล",
                style: TextStyle(
                ),
              ),
            ),
            Padding(
	          padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                border:
                  OutlineInputBorder(borderSide: BorderSide(width: 1)))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 30, 0, 0),
              child: Text("รูปภาพโปรไฟล์",
                style: TextStyle(
                ),
              ),
            ),
            Padding(
	          padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextField(
              controller: imageController,
              decoration: InputDecoration(
                border:
                  OutlineInputBorder(borderSide: BorderSide(width: 1)))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 30, 0, 0),
              child: Text("รหัสผ่าน",
                style: TextStyle(
                ),
              ),
            ),
            Padding(
	          padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border:
                  OutlineInputBorder(borderSide: BorderSide(width: 1)))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 30, 0, 0),
              child: Text("ยืนยันรหัสผ่าน",
                style: TextStyle(
                ),
              ),
            ),
            Padding(
	          padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                border:
                  OutlineInputBorder(borderSide: BorderSide(width: 1)))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                  onPressed: register,
                  child: const Text('สมัครสมาชิก', style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text("หากมีบัญชีอยู่แล้ว?",
                      style: TextStyle(
                        fontSize: 15, 
                      ),
                    ),
                  ),
                  TextButton(
                  onPressed: login,
                  child: const Text('เข้าสู่ระบบ', style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

String url = '';
void initState() {
super.initState();
Configuration.getConfig().then(
  (config) {
	url = config['apiEndpoint'];
  },
);
}
  void register() {
    if (passwordController.text == confirmPasswordController.text) {
      CustomerRegisterPostRequest request = CustomerRegisterPostRequest(
        fullname: fullnameController.text,
        phone: phoneController.text,
        email: emailController.text,
        image: imageController.text,
        password: passwordController.text,
      );
      http
        .post(Uri.parse("$url/customers"),
            headers: {"Content-Type": "application/json; charset=utf-8"},
            body: customerRegisterPostRequestToJson(request))
        .then(
      (value) {
        log(value.body);
        Navigator.pop(context);
      },
    ).catchError((error) {
      log('Error $error');
    });
    }
    else{
      log('paassword not match');
    }
  }

  void login() {
  }
}