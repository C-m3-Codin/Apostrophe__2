// ignore_for_file: prefer_const_constructors

import 'package:apostrophe/AllOrders.dart';
import 'package:apostrophe/Models/UserAuthModel.dart';
import 'package:apostrophe/TracksPage.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Profile profile;
  const HomePage({Key? key, required this.profile}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apostrophe"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: [
          Container(
            child: ShowAllOrders(
              profile: widget.profile,
            ),
          ),
          Container(
              child: TrackPage(
            profile: widget.profile,
            awb: "277553044205",
          )),
          Container(child: ProfilePage(profile: widget.profile)),
        ],
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.blue,
          ),
          BottomBarItem(
            icon: Icon(Icons.track_changes_outlined),
            title: Text('Track'),
            activeColor: Colors.blue,
          ),
          BottomBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
            activeColor: Colors.blue,
          )
        ],
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final Profile profile;
  const ProfilePage({Key? key, required this.profile}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Card(
              elevation: 5.0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "HELLO!",
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 50),
                      Text(
                        (widget.profile.firstName! +
                                " " +
                                widget.profile.lastName!)
                            .toUpperCase(),
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      )
                    ]),
              ),
            ),
          ),
          Container(
              child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                showdetails("Email", widget.profile.email),
                showdetails("Company", widget.profile.companyId.toString()),
                showdetails(
                    "Created", (widget.profile.createdAt!).split(" ")[0]),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

showdetails(String s, String? email) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              s + " " + ":" + " ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              email!,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            )
          ],
        ),
      ),
    ),
  );
}
