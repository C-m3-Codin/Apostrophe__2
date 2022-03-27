// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:apostrophe/Models/UserAuthModel.dart';
import 'package:apostrophe/Models/allOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShowAllOrders extends StatefulWidget {
  Profile profile;
  ShowAllOrders({Key? key, required this.profile}) : super(key: key);

  @override
  State<ShowAllOrders> createState() => _ShowAllOrdersState();
}

class _ShowAllOrdersState extends State<ShowAllOrders> {
  late Future<Orders> orders;

  Future<Orders> getOrdersApi() async {
    String token = widget.profile.token.toString();
    print("token is + ${token}");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    var request = http.Request(
        'GET', Uri.parse('https://apiv2.shiprocket.in/v1/external/orders'));

    request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();
    var response = await http.get(
        Uri.parse('https://apiv2.shiprocket.in/v1/external/orders'),
        headers: headers);

    if (response.statusCode == 200) {
      // print(response.body.toString());
      return Orders.fromJson(json.decode(response.body.toString()));
    } else {
      print(response.body.toString());
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    orders = getOrdersApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('All Orders'),
      // ),
      body: FutureBuilder(
        future: orders,
        builder: (BuildContext context, AsyncSnapshot<Orders> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else {
              // print(snapshot.data?.toJson().toString());
              List<Datum> list = snapshot.data!.data!;
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        print(list[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 2.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Column(
                              children: [
                                // name
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text("ID:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.blueGrey)),
                                        Text(
                                          list[index].id.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text("Name:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.blueGrey)),
                                        Text(
                                          list[index].customerName!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Email:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blueGrey,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      list[index].customerEmail!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Phone:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blueGrey,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      list[index].customerPhone!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                          ),
                        ),
                      ),
                    );
                  });
              // Center(
              //     child: Text(
              //         "${snapshot.data!.data![0].customerEmail.toString()}"));
            }
          }
        },
      ),
    );
  }
}
