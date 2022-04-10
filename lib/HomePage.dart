// ignore_for_file: prefer_const_constructors

import 'package:apostrophe/AllOrders.dart';
import 'package:apostrophe/Models/UserAuthModel.dart';
import 'package:apostrophe/TracksPage.dart';
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
        title: Text(
          "Apostrophe",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
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
          ShowAllOrders(
            profile: widget.profile,
          ),
          TrackPage(
            profile: widget.profile,
            awb: "277553044205",
          ),
          ProfilePage(profile: widget.profile),
        ],
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        elevation: 5.0,
        iconSize: 30.0,
        selectedFontSize: 16.0,
        unselectedFontSize: 13.0,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes_outlined),
            label: 'Track',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
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
        body: Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: Card(
            elevation: 5.0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "HELLO!",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
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
        Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showdetails("Email", widget.profile.email),
              showdetails("Company", widget.profile.companyId.toString()),
              showdetails("Created", (widget.profile.createdAt!).split(" ")[0]),
            ],
          ),
        ),
      ],
    ));
  }
}

showdetails(String s, String? email) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
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
  );
}
