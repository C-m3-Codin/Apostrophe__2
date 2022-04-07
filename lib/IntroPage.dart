import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginPage.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: listPagesViewModel,
        showSkipButton: true,
        next: const Icon(Icons.navigate_next),
        skip: const Text("Skip"),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        onDone: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('showIntro', true);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => const LoginPage()));
        },
        baseBtnStyle: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        skipStyle: TextButton.styleFrom(primary: Colors.red),
        doneStyle: TextButton.styleFrom(primary: Colors.green),
        nextStyle: TextButton.styleFrom(primary: Colors.blue),
      ),
    );
  }
}

List<PageViewModel> listPagesViewModel = [
  PageViewModel(
    title: "Title of first page",
    body:
        "Here you can write the description of the page, to explain someting...",
    image: const CircleAvatar(
        radius: 120,
        backgroundImage: NetworkImage("https://picsum.photos/200?random=1")),
  ),
  PageViewModel(
    title: "Title of second page",
    body:
        "Here you can write the description of the page, to explain someting...",
    image: const CircleAvatar(
        radius: 120,
        backgroundImage: NetworkImage("https://picsum.photos/200?random=2")),
  ),
  PageViewModel(
    title: "Title of third page",
    body:
        "Here you can write the description of the page, to explain someting...",
    image: const CircleAvatar(
        radius: 120,
        backgroundImage: NetworkImage("https://picsum.photos/200?random=3")),
  )
];
