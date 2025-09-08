import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:test/config/config.dart';
import 'package:test/model/request/customer_login_post_req.dart';
import 'package:test/model/response/customer_login_post_res.dart';

import 'package:test/pages/register.dart';
import 'package:test/pages/showtrip.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String text = '';
  int number = 0;
  String phoneNo = '';
  String url = '';
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [ 
            InkWell(
              onTap: register,
              child: Image.asset('assets/images/logo.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  "หมายเลขโทรศัพท์",
                  style: TextStyle(fontSize: 20),
                  ),
                  TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                  ),
                  ),
                  Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    "รหัสผ่าน",
                    style: TextStyle(fontSize: 20),
                  ),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1))),
                    )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                  onPressed: register,
                  child: const Text('ลงทะเบียนใหม่', style: TextStyle(fontSize: 20)),
                  ),
                  FilledButton(
                  onPressed: login,
                  child: const Text('เข้าสู่ระบบ', style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Align(child: Text(text,style: TextStyle()),
            alignment: Alignment.center,),
          ],
        ),
      ),
    );
  }

  void register() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegisterPage(),
        ));
  }



@override
void initState() {
    super.initState();
    Configuration.getConfig().then(
      (config) {
      url = config['apiEndpoint'];
      },
    );
}
  void login() async {
    CustomerLoginPostRequest req =
        CustomerLoginPostRequest(phone: phoneController.text, password: passwordController.text);
    http
        .post(Uri.parse("$url/customers/login"),
            headers: {"Content-Type": "application/json; charset=utf-8"},
            body: customerLoginPostRequestToJson(req))
        .then(
      (value) {
        phoneController.clear();
        passwordController.clear();
        log(value.body);
        CustomerLoginPostResponse customerLoginPostResponse =
            customerLoginPostResponseFromJson(value.body);
        log(customerLoginPostResponse.customer.fullname);
        log(customerLoginPostResponse.customer.email);
        if(customerLoginPostResponse.message == 'Login successful') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowTripPage(cid: customerLoginPostResponse.customer.idx,),
            ));

        } else {
          log('Login failed: ${customerLoginPostResponse.message}');
        }
      },
    ).catchError((error) {
      log('Error $error');
    });
  }


  // void login() {
  //   log(phoneController.text);
  //   if (phoneController.text == '111' && passwordController.text == '1234') {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const ShowTripPage(),
  //       ));
  //   } else {
  //     setState(() {
  //       text = 'Phone or password is incorrect';
  //     });
  //   }
  // }

  // void login(String phone, String password) {
  //   number++;
  //   setState(() {
  //     text = 'Login time: '+number.toString();
  //   });
  // }
}
