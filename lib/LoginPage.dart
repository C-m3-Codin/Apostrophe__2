// ignore_for_file: unused_import

import 'dart:convert';

import 'package:apostrophe/AllOrders.dart';
import 'package:apostrophe/Map.dart';
import 'package:apostrophe/HomePage.dart';
import 'package:apostrophe/TestPage.dart';
import 'package:apostrophe/TracksPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/UserAuthModel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

  login() async {
    // var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST',
        Uri.parse('https://apiv2.shiprocket.in/v1/external/auth/login'));
    ;
    request.body = json.encode({
      "email": nameController.text,
      "password": passwordController.text,
      // "email": "ashish.kataria+hackathon@shiprocket.com",
      // "password": "hackathon@2022"
    });
    print("asdasdasdasdasd ${nameController.text}");

    var response = await http.post(request.url,
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*",
          "Vary": "Origin",
          "Vary": "Access-Control-Request-Method",
          "Vary": "Access-Control-Request-Headers",
          "Access-Control-Allow-Headers": "Content-Type, Origin, Accept, token",
          "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
        },
        body: request.body);

    Profile profile = new Profile();
    if (response.statusCode == 200) {
      // print(response.body.toString());
      profile = await Profile.fromJson(json.decode(response.body.toString()));
      print(profile.firstName);
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          // builder: (BuildContext context) => TestPage(profile: profile),
          builder: (BuildContext context) => HomePage(profile: profile),
          // builder: (BuildContext context) => TrackPage(
          //   profile: profile,
          //   awb: "277553044205",
          // ),
          // builder: (BuildContext context) => MapDisplay(),
        ),
      );
    } else {
      String errorMessage = "password does not match";
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
    // print(profile.firstName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Login Page',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      )),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //forgot password screen
                    },
                    child: const Text(
                      'Forgot Password',
                    ),
                  ),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child: const Text('Login'),
                        onPressed: login,
                      )),
                  Row(
                    children: <Widget>[
                      const Text('Does not have account?'),
                      TextButton(
                        child: const Text(
                          'Sign up',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () async {},
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
