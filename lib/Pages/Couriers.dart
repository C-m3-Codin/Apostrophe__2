import 'dart:convert';
import 'dart:io';

import 'package:apostrophe/Models/CoureirModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/image.dart' as Image2;

class CouriersPage extends StatefulWidget {
  String token;
  CouriersPage({Key? key, required this.token}) : super(key: key);

  @override
  State<CouriersPage> createState() => _CouriersPageState();
}

class _CouriersPageState extends State<CouriersPage> {
  late Couriers couriers;
  late Future<bool> loading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = apiGetCourier();
  }

  @override
  Future<bool> apiGetCourier() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.token}'
    };
    var response = await http.get(
        Uri.parse(
            'https://apiv2.shiprocket.in/v1/external/courier/courierListWithCounts'),
        headers: headers);

    if (response.statusCode == 200) {
      // print(response.body.toString());
      Couriers temp = Couriers.fromJson(json.decode(response.body.toString()));
      couriers = temp;
      setState(() {});
      return true;
    } else {
      print(response.body.toString());
      throw Exception('Failed to load album');
    }

    // return true;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Couriers")),
      body: FutureBuilder<bool>(
          future: loading,
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(
                  child: ListView.builder(
                itemBuilder: (_, i) {
                  if (i == 0) {
                    return Container(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                              "Total Available Partners: ${couriers.totalCourierCount}"),
                        ],
                      ),
                    );
                  } else {
                    return ListTile(
                      leading: Image2.Image.network(
                        "https://shiprocket.co/" +
                            couriers.courierData[i - 1].image.logo,
                        errorBuilder: (_, Object exception, error) {
                          return Text("asd");
                        },
                        width: 50,
                      ),
                      title: Text(couriers.courierData[i - 1].name),
                    );
                  }
                },
                itemCount: couriers.courierData.length + 1,
              ));
            }
          }),
    );
  }
}
