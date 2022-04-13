// ignore_for_file: unused_import

import 'dart:convert';

// import 'package:apostrophe/AllOrders.dart';
// import 'package:apostrophe/Map.dart';
// import 'package:apostrophe/HomePage.dart';
import 'package:apostrophe/Models/UserAuthModel.dart';
import 'package:apostrophe/Pages/HomePage.dart';
import 'package:apostrophe/Pages/NewHome.dart';
import 'package:apostrophe/TestPage.dart';
import 'package:apostrophe/Pages/TracksPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import 'Models/UserAuthModel.dart';

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
      // "email": nameController.text,
      // "password": passwordController.text,
      "email": "ashish.kataria+hackathon@shiprocket.com",
      "password": "hackathon@2022"
    });
    print("asdasdasdasdasd ${nameController.text}");

    var response = await http.post(request.url,
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*",
          "Vary": "Access-Control-Request-Method",
          "Access-Control-Allow-Headers": "Content-Type, Origin, Accept, token",
          "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
        },
        body: request.body);

    Profile profile = Profile();
    if (response.statusCode == 200) {
      // print(response.body.toString());
      profile = await Profile.fromJson(json.decode(response.body.toString()));
      print(profile.firstName);
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          // builder: (BuildContext context) => TestPage(profile: profile),
          // builder: (BuildContext context) => HomePage(profile: profile),
          builder: (BuildContext context) => NewHome(profile: profile),
          // builder: (BuildContext context) => TrackPage(
          //   profile: profile,
          //   awb: "277553044205",
          // ),
          // builder: (BuildContext context) => MapDisplay(),
        ),
      );
    } else {
      String errorMessage = "password does not match";
      ScaffoldMessenger.of(context).showSnackBar(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.w500,
                            fontSize: 34),
                      )),
                  // Container(
                  //     alignment: Alignment.center,
                  //     padding: const EdgeInsets.all(10),
                  //     child: const Text(
                  //       'Sign in',
                  //       style: TextStyle(fontSize: 20),
                  //     )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        labelText: 'User Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //forgot password screen
                      dialoguebox(context);
                    },
                    child: const Text(
                      'Forgot Password',
                    ),
                  ),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50)),
                        child: const Text('Login'),
                        onPressed: login,
                      )),
                  Row(
                    children: <Widget>[
                      const Text('Haven\'t joined us yet?'),
                      TextButton(
                        child: const Text(
                          'Sign up',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => dialoguebox(context),
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

  Future<dynamic> dialoguebox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context));
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Center(child: Text('Ooops...')),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Center(
            child: Icon(
              Icons.warning_amber_rounded,
              size: 50,
            ),
          ),
        ),
        Center(
            child: Text(
          "This feature is yet to be implemented. Please wait",
          textAlign: TextAlign.center,
        )),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
  );
}
