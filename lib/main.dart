// ignore_for_file: unused_import

import 'dart:convert';

import 'package:apostrophe/IntroPage.dart';
import 'package:apostrophe/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

import 'HomePage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final showIntro = prefs.getBool('showIntro') ?? true;

  runApp(MyApp(showIntro: showIntro));
}

class MyApp extends StatelessWidget {
  final bool showIntro;
  const MyApp({
    Key? key,
    required this.showIntro,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.teal,
        fontFamily: GoogleFonts.openSans().fontFamily,
      ),
      home: showIntro ? const Intro() : const LoginPage(),
    );
  }
}
