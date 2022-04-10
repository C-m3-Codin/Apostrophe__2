// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:apostrophe/Constants/Constants.dart';
import 'package:apostrophe/Models/UserAuthModel.dart';
import 'package:apostrophe/Models/allOrderModel.dart';
import 'package:apostrophe/OrderDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutableF
class ShowAllOrders extends StatefulWidget {
  Profile profile;
  ShowAllOrders({Key? key, required this.profile}) : super(key: key);

  @override
  State<ShowAllOrders> createState() => _ShowAllOrdersState();
}

class _ShowAllOrdersState extends State<ShowAllOrders> {
// scroll controller
  ScrollController _scrollController = ScrollController();
  TextEditingController enterFilterFalue = TextEditingController();
  Orders orders = Orders(data: [], meta: null);
  bool channelIDSelected = false;
  bool orderSortUp = true;
  bool FilterOn = false;
  int page = 0;
  String FilterBy = "status";
  String filter = "1";
  String sort = "ASC";
  List<String> dropOptions = statusCodeVals.keys.toList();
  String dropdownValue = "Box Packing";
  String dropDownFilterBy = "status";

  // ["cod", "prepaid orders"];
  ButtonStyle buttonOn = ElevatedButton.styleFrom(primary: Colors.blue);
  ButtonStyle buttonOff = ElevatedButton.styleFrom(primary: Colors.grey);

  Future<bool> getFilteredApi(int page) async {
    print("gonna fetch filter");
    String token = widget.profile.token.toString();
    print("token is + ${token}");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };

    print(
        "filter on  fetch filter url https://apiv2.shiprocket.in/v1/external/orders?filter_by=${FilterBy}&filter=${filter}&page=${page} ");

    var response = await http.get(
        Uri.parse(
            'https://apiv2.shiprocket.in/v1/external/orders?filter_by=${FilterBy}&filter=${filter}&page=${page}&sort=${sort}&sort_by=ID'),
        headers: headers);

    if (response.statusCode == 200) {
      // print(response.body.toString());
      Orders temp = Orders.fromJson(json.decode(response.body.toString()));
      orders.data!.addAll(temp.data!);
      orders.meta = temp.meta;
      setState(() {});
      return true;
    } else {
      print(response.body.toString());
      throw Exception('Failed to load album');
    }
  }

  Future<bool> getOrdersApi({int page = 0}) async {
    String token = widget.profile.token.toString();
    print("token is + ${token}");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };

    var response = await http.get(
        Uri.parse(
            'https://apiv2.shiprocket.in/v1/external/orders?per_page=40&page=${page}'),
        headers: headers);

    if (response.statusCode == 200) {
      // print(response.body.toString());
      Orders temp = Orders.fromJson(json.decode(response.body.toString()));
      orders.data!.addAll(temp.data!);
      orders.meta = temp.meta;
      setState(() {});
      return true;
    } else {
      print(response.body.toString());
      throw Exception('Failed to load album');
    }
  }

  // orderStatusMap.values.first.toString();
  Future<bool> getOrdersApiByID() async {
    String token = widget.profile.token.toString();
    print("token is + ${token}");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };

    // http.StreamedResponse response = await request.send();
    var response = await http.get(
        Uri.parse(
            'https://apiv2.shiprocket.in/v1/external/orders?filter_by=${FilterBy}&filter=${filter}&page=${page}&sort=${sort}&sort_by=ID'),
        headers: headers);

    if (response.statusCode == 200) {
      // print(response.body.toString());
      Orders temp = Orders.fromJson(json.decode(response.body.toString()));
      orders.data!.addAll(temp.data!);
      setState(() {});
      return true;
    } else {
      print(response.body.toString());
      throw Exception('Failed to load album');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    getOrdersApi();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        print("end of scroll reached");
        if (orders.meta != null) {
          page++;
          getOrdersApi(page: page);
        }
        if (orders.meta != null) {
          if (orders.meta!.pagination!.currentPage ==
              (orders.meta!.pagination!.totalPages)) {
            print("stop scrolling");
          } else {
            page++;
            FilterOn ? getFilteredApi(page) : getOrdersApi();
          }
        }
        // orders=

      }
    });
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
                // height: 250,
                child: Card(
                    child: ExpansionTile(
              title: Row(
                children: [
                  Text(
                    " Filter Options",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  // Text(
                  //   "Filter Options",
                  //   style:
                  //       TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  // ),
                  // Text(
                  //   "Filter Options",
                  //   style:
                  //       TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  // ),
                ],
              ),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          orders.data = [];
                          page = 0;
                          orders.meta = null;
                          sort = orderSortUp ? "ASC" : "DESC";
                          getOrdersApiByID();

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
                        onPressed: null,
                        child: FutureBuilder(
                            // future: orders,
                            builder: (BuildContext context,
                                AsyncSnapshot<Orders> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else
                            return Text("Order Count ${orders.data!.length}");
                        })),

                    // ElevatedButton(onPressed: null, child: )
                  ],
                ),
                ElevatedButton(

                    //to do change coor of button depending on the status of the button
                    style: ElevatedButton.styleFrom(
                        primary: FilterOn ? Colors.blue : Colors.grey),
                    onPressed: () {
                      print("pressed Filter");
                      FilterOn = !FilterOn;
                      page = 0;
                      orders.data = [];
                      orders.meta = null;
                      getFilteredApi(page);
                      setState(() {});
                    },
                    child: FilterOn ? Text("Filter On") : Text("Filter Off")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DropdownButton<String>(
                      value: dropDownFilterBy,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        // width: 50,
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        // FilterBy = "status";
                        if (newValue == "payment") {
                          FilterBy = newValue.toString();
                          // filter =
                          channelIDSelected = false;
                          dropOptions = ["cod", "payment"];

                          filter = dropOptions[0];
                          dropdownValue = filter;
                        } else if (newValue == "status") {
                          FilterBy = newValue.toString();
                          channelIDSelected = false;
                          dropOptions = statusCodeVals.keys.toList();
                          filter = dropOptions[0];
                          dropdownValue = filter;
                        } else {
                          FilterBy = "channel_order_id";
                          channelIDSelected = true;
                        }

                        setState(() {
                          if (FilterOn) {
                            FilterOn = false;
                          }
                          dropDownFilterBy = newValue!;
                        });
                      },
                      items: ["payment", "status", "channel"]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    channelIDSelected
                        ? Container(
                            // height: 100,
                            width: 100,
                            child: TextField(
                              onChanged: (value) {
                                print("value changed ${value}");
                                filter = value.toString();
                              },
                              controller: enterFilterFalue,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Channel id',
                                  hintText: 'Enter Channel id'),
                            ),
                          )
                        : DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              width: 50,
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              // FilterBy = "status";
                              filter = FilterBy == "status"
                                  ? statusCodeVals[newValue].toString()
                                  : newValue.toString();

                              setState(() {
                                if (FilterOn) {
                                  FilterOn = false;
                                }
                                dropdownValue = newValue!;
                              });
                            },
                            items: dropOptions
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                  ],
                )
              ],
            ))),
            FutureBuilder(
              // future: orders,
              builder: (BuildContext context, AsyncSnapshot<Orders> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError)
                    return Center(child: Text('Error: ${snapshot.error}'));
                  else {
                    // for (int i = 0; i < orders.data!.length;i++){
                    //   orders.data[i].shipments[0].deliveredDate=="ON WAY'"
                    // }
                    // print(snapshot.data?.toJson().toString());
                    List<Datum> list = orders.data!;
                    return Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                      // Container(
                      height: MediaQuery.of(context).size.height - 100,
                      child: list.length == 0
                          ? Center(
                              child: Text("No Data to show"),
                            )
                          : ListView.builder(
                              controller: _scrollController,
                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              itemCount: list.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    print(list[index]);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                OrderDetails(
                                                  ord: list[index],
                                                  auth: widget.profile.token
                                                      .toString(),
                                                )));
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text("ID:",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                            color: Colors
                                                                .blueGrey)),
                                                    Text(
                                                      list[index].id.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                            color: Colors
                                                                .blueGrey)),
                                                    Text(
                                                      list[index]
                                                                  .customerName!
                                                                  .length <
                                                              17
                                                          ? list[index]
                                                              .customerName!
                                                          : list[index]
                                                                  .customerName!
                                                                  .substring(
                                                                      0, 16) +
                                                              "...",
                                                      overflow:
                                                          TextOverflow.fade,
                                                      maxLines: 1,
                                                      softWrap: false,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "status:",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.blueGrey,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  list[index].status.toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.blue,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Email:",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.blueGrey,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  list[index].customerEmail!,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.blue,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Phone:",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.blueGrey,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  list[index].customerPhone!,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
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
                              }),
                    );
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
