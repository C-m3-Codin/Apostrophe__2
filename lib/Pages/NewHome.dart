import 'package:apostrophe/Models/UserAuthModel.dart';
import 'package:apostrophe/Models/allOrderModel.dart';
import 'package:apostrophe/Models/track.dart';
import 'package:apostrophe/Pages/AllOrders.dart';
import 'package:apostrophe/Pages/HomePage.dart';
import 'package:apostrophe/Pages/TracksPage.dart';
import 'package:apostrophe/Pages/products.dart';
import 'package:flutter/material.dart';

class NewHome extends StatefulWidget {
  final Profile profile;
  const NewHome({Key? key, required this.profile}) : super(key: key);

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.logout_rounded))
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "SHITROCKET",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: LayoutBuilder(
        builder: ((context, constraints) => SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Hello,",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            (widget.profile.firstName).toString() +
                                " " +
                                (widget.profile.lastName).toString(),
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.cyan),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(),
                  GridView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(parent: null),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    children: [
                      grid(
                          context,
                          Icons.shopping_bag,
                          "Orders",
                          MaterialPageRoute(
                              builder: (context) =>
                                  ShowAllOrders(profile: widget.profile))),
                      grid(
                          context,
                          Icons.track_changes,
                          "Track Orders",
                          MaterialPageRoute(
                              builder: (context) => TrackPage(
                                    profile: widget.profile,
                                    awb: "277553044205",
                                  ))),
                      grid(
                          context,
                          Icons.person,
                          "Profile",
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfilePage(profile: widget.profile))),
                      grid(
                          context,
                          Icons.shopping_bag,
                          "Products",
                          MaterialPageRoute(
                              builder: (context) => ProductPage(
                                  token: widget.profile.token.toString()))),
                      grid(
                          context,
                          Icons.card_membership,
                          "Partner",
                          MaterialPageRoute(
                              builder: (context) => ProductPage(
                                  token: widget.profile.token.toString()))),
                      grid(
                          context,
                          Icons.construction,
                          "Cyril indakum",
                          MaterialPageRoute(
                              builder: (context) => ProductPage(
                                  token: widget.profile.token.toString()))),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  Padding grid(
    BuildContext context,
    IconData icon,
    String title,
    MaterialPageRoute route,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (() {
          Navigator.push(context, route);
        }),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.height * 0.03),
          ),
          elevation: 2,
          // color: Color.fromRGBO(245, 245, 245, 1),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: MediaQuery.of(context).size.height * 0.1,
                color: Colors.teal,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.03),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
