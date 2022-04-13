import 'package:apostrophe/Models/UserAuthModel.dart';
import 'package:apostrophe/Models/allOrderModel.dart';
import 'package:apostrophe/Models/track.dart';
import 'package:apostrophe/Pages/AllOrders.dart';
import 'package:apostrophe/Pages/Couriers.dart';
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
                      gridTile(
                          widget: widget,
                          icon: Icons.shopping_bag,
                          name: "Orders",
                          route: 1),
                      gridTile(
                          widget: widget,
                          icon: Icons.track_changes,
                          name: "Track Orders",
                          route: 2),
                      gridTile(
                          widget: widget,
                          icon: Icons.person,
                          name: "Profile",
                          route: 3),
                      gridTile(
                          widget: widget,
                          icon: Icons.shopping_bag,
                          name: "Products",
                          route: 4),
                      gridTile(
                          widget: widget,
                          icon: Icons.card_membership,
                          name: "Partner",
                          route: 5),
                      gridTile(
                          widget: widget,
                          icon: Icons.card_membership,
                          name: "Partner",
                          route: 5)
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}

class gridTile extends StatelessWidget {
  int route;
  IconData icon;
  String name;
  gridTile(
      {Key? key,
      required this.widget,
      required this.icon,
      required this.name,
      required this.route})
      : super(key: key);

  final NewHome widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (() {
          switch (route) {
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new ShowAllOrders(profile: widget.profile)),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => new TrackPage(
                          profile: widget.profile,
                          awb: "277553044205",
                        )),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new ProfilePage(profile: widget.profile)),
              );
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => new ProductPage(
                        token: widget.profile.token.toString())),
              );
              break;
            case 5:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => new CouriersPage(
                        token: widget.profile.token.toString())),
              );
              break;
          }
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
                name,
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
