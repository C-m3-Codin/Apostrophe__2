// ignore: file_names
import 'package:apostrophe/Models/UserAuthModel.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  final Profile profile;
  const TestPage({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              'Hello ${profile.firstName}',
              style: const TextStyle(fontSize: 30),
            ),
            Text(profile.token.toString())
          ],
        ),
      ),
    );
  }
}
