// ignore_for_file: prefer_const_constructors

import 'dart:ui';

// import 'package:apostrophe/AllOrders.dart';
import 'package:apostrophe/Models/CoureirModel.dart';
import 'package:apostrophe/Models/UserAuthModel.dart';
import 'package:apostrophe/Pages/AllOrders.dart';
import 'package:apostrophe/Pages/Couriers.dart';
import 'package:apostrophe/Pages/TracksPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                      "Hello!",
                      style: GoogleFonts.alegreyaSansSc(
                        fontSize: 50,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      (widget.profile.firstName! +
                          " " +
                          widget.profile.lastName!),
                      style: GoogleFonts.alegreyaSansSc(
                          fontSize: 40,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor),
                    )
                  ]),
            ),
          ),
        ),
        Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showdetails("Email", widget.profile.email, context),
              showdetails(
                  "Company", widget.profile.companyId.toString(), context),
              showdetails("Created", (widget.profile.createdAt!).split(" ")[0],
                  context),
              ListTile(
                title: Text("Courier Page"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return CouriersPage(
                      token: widget.profile.token.toString(),
                    );
                  }));
                },
              )
            ],
          ),
        ),
      ],
    ));
  }
}

showdetails(String s, String? email, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            s + " " + ":" + " ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            email!,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          )
        ],
      ),
    ),
  );
}
