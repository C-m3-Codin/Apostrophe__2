// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:apostrophe/Models/UserAuthModel.dart';
import 'package:apostrophe/Models/allOrderModel.dart';
import 'package:apostrophe/OrderDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ShowAllOrders extends StatefulWidget {
  Profile profile;
  ShowAllOrders({Key? key, required this.profile}) : super(key: key);

  @override
  State<ShowAllOrders> createState() => _ShowAllOrdersState();
}

class _ShowAllOrdersState extends State<ShowAllOrders> {
  late Future<Orders> orders;
  bool orderSortUp = true;

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

  Map<int, String> orderStatusMap = {
    1: "New Order",
    2: "Invoiced",
    3: "Ready To Ship",
    4: "Pickup Scheduled",
    5: "Canceled",
    6: "Shipped",
    7: "Delivered",
    8: "ePayment Failed",
    9: "Returned",
    10: "Unmapped",
    11: "Unfulfillable",
    12: "Pickup Queue",
    13: "Pickup Rescheduled",
    14: "Pickup Error// Created when there is an error on pickup schedule",
    15: "RTO Initiated",
    16: "RTO Delivered",
    17: "RTO Acknowledged",
    18: "Cancellation Requested",
    19: "Out for Delivery",
    20: "In Transit",
    21: "Return Pending",
    22: "Return Initiated",
    23: "Return Pickup Queued",
    24: "Return Pickup Error",
    25: "Return In Transit",
    26: "Return Delivered",
    27: "Return Cancelled",
    28: "Return Pickup Generated",
    29: "Return Cancellation Requested",
    30: "Return Pickup Cancelled",
    31: "Return Pickup Rescheduled",
    32: "Return Pickedup",
    33: "Lost",
    34: "Out For Pickup",
    35: "Pickup Exception",
    36: "Undelivered",
    37: "Delayed",
    38: "Partial Delivered",
    39: "Destroyed",
    40: "Damaged",
    41: "Fulfilled",
    42: "Archived",
    43: "Reached Destination Hub",
    44: "Misrouted",
    45: "RTO OFD",
    46: "RTO NDR",
    47: "Return Out For Pickup",
    48: "Return Out For Delivery",
    49: "Return Pickup Exception",
    50: "Return Undelivered",
    51: "Picked Up",
    52: "Self Fulfilled",
    53: "Disposed Of",
    54: "Canceled before Dispatched",
    55: "RTO In-Transit",
    57: "QC Failed",
    58: "Reached Warehouse",
    59: "Custom Cleared",
    60: "In Flight",
    61: "Handover to Courier",
    62: "Order booked",
    64: "In Transit Overseas",
    65: "Connection Aligned",
    66: "Reached Overseas Warehouse",
    67: "Custom Cleared Overseas",
    69: "Box Packing"
  };
  Future<Orders> getOrdersApiByID(String sortOrder) async {
    String token = widget.profile.token.toString();
    print("token is + ${token}");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://apiv2.shiprocket.in/v1/external/orders?sort_by=status&sort=${sortOrder}'));

    request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();
    var response = await http.get(
        Uri.parse(
            'https://apiv2.shiprocket.in/v1/external/orders?sort_by=status&sort=${sortOrder}'),
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
      body: SingleChildScrollView(
        // physics: ScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        orders = orderSortUp
                            ? getOrdersApiByID("ASC")
                            : getOrdersApiByID("DESC");
                        setState(() {
                          orderSortUp = !orderSortUp;
                        });
                      },
                      child: Row(children: [
                        Text("sort"),
                        orderSortUp
                            ? Icon(Icons.arrow_upward)
                            : Icon(Icons.arrow_downward),
                      ])),
                  ElevatedButton(
                      onPressed: () {
                        orders = getOrdersApi();
                        setState(() {
                          // orderSortUp = !orderSortUp;
                        });
                      },
                      child: Text("Remove sort")),
                  ElevatedButton(
                      onPressed: null,
                      child: FutureBuilder(
                          future: orders,
                          builder: (BuildContext context,
                              AsyncSnapshot<Orders> snapshot) {
                            if (snapshot.hasData)
                              return Text(
                                  "Order Count ${snapshot.data!.data!.length}");
                            else
                              return CircularProgressIndicator();
                          })),
                ],
              ),
            ),
            FutureBuilder(
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
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              print(list[index]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      OrderDetails(order: list[index]),
                                ),
                              );
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                            "status:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blueGrey,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            list[index].status.toString(),
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
          ],
        ),
      ),
    );
  }
}
