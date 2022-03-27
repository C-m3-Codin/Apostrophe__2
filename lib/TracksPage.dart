// ignore: file_names
// ignore_for_file: avoid_print
// import 'package:flutter_json_view/flutter_json_view.dart';
import 'dart:convert';

import 'package:apostrophe/Map.dart';
import 'package:apostrophe/Models/UserAuthModel.dart';
import 'package:apostrophe/Models/track.dart';
import 'package:flutter/material.dart';
import 'package:flutter_json_view/flutter_json_view.dart';
import 'package:http/http.dart' as http;

// flutter pub add flutter_json_view
// ignore: must_be_immutable
class TrackPage extends StatefulWidget {
  String awb;
  Profile profile;
  TrackPage({Key? key, required this.awb, required this.profile})
      : super(key: key);

  @override
  State<TrackPage> createState() => _TrackState();
}

class _TrackState extends State<TrackPage> {
  bool searched = false;
  TextEditingController searchQueryAWB = TextEditingController();
  TextEditingController searchQuerySHIP = TextEditingController();
  TextEditingController searchQueryORDER = TextEditingController();
  TextEditingController searchQueryCHANNELID = TextEditingController();
  late Future<Track> trackapi;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    // trackapi = getTrack();
    // trackapi=Future.
  }

  Future<Track> getTrackAWB(String ship) async {
    String token = widget.profile.token.toString();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response = await http.get(
        Uri.parse(
            "https://apiv2.shiprocket.in/v1/external/courier/track/awb/${ship}"),
        headers: headers);

    if (response.statusCode == 200) {
      return Track.fromJson(json.decode(response.body.toString()));
    } else {
      print("2121 not worked ${response.body}");
      print(response.body.toString());
      throw Exception('Failed to load album');
    }
  }

  // ignore: non_constant_identifier_names
  Future<Track> getTrackORDER(String channelId, String OrderId) async {
    String token = widget.profile.token.toString();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response = await http.get(
        Uri.parse(
            "https://apiv2.shiprocket.in/v1/external/courier/track?order_id=${OrderId}&channel_id=${channelId}"),
        headers: headers);

    if (response.statusCode == 200) {
      return Track.fromJson(json.decode(response.body.toString()));
    } else {
      print("2121 not worked ${response.body}");
      print(response.body.toString());
      throw Exception('Failed to load album');
    }
  }

  Future<Track> getTrackSHIP(String awb) async {
    String token = widget.profile.token.toString();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response = await http.get(
        Uri.parse(
            "https://apiv2.shiprocket.in/v1/external/courier/track/shipment/${awb}"),
        headers: headers);

    if (response.statusCode == 200) {
      return Track.fromJson(json.decode(response.body.toString()));
    } else {
      print("2121 not worked ${response.body}");
      print(response.body.toString());
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Track Package"),
      // ),
      body: searched == false
          ? SearchBar()
          : FutureBuilder(
              future: trackapi,
              builder: (BuildContext context, AsyncSnapshot<Track> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError) {
                    return const Center(
                        child:
                            Text('Error: No awb order found on that number'));
                  } else {
                    Map<int, String> shipment = {
                      1: "AWB Assigned",
                      2: "Label Generated",
                      3: "Pickup Scheduled/Generated",
                      4: "Pickup Queued",
                      5: "Manifest Generated",
                      6: "Shipped",
                      7: "Delivered",
                      8: "Cancelled",
                      9: "RTO Initiated",
                      10: "RTO Delivered",
                      11: "Pending",
                      12: "Lost",
                      13: "Pickup Error",
                      14: "RTO Acknowledged",
                      15: "Pickup Rescheduled",
                      16: "Cancellation Requested",
                      17: "Out For Delivery",
                      18: "In Transit",
                      19: "Out For Pickup",
                      20: "Pickup Exception",
                      21: "Undelivered",
                      22: "Delayed",
                      23: "Partial_Delivered",
                      24: "Destroyed",
                      25: "Damaged",
                      26: "Fulfilled",
                      38: "Reached at Destination",
                      39: "Misrouted",
                      40: "RTO NDR",
                      41: "RTO OFD",
                      42: "Picked Up",
                      43: "Self Fulfilled",
                      44: "DISPOSED_OFF",
                      45: "CANCELLED_BEFORE_DISPATCHE",
                      46: "DRTO_IN_TRANSIT",
                      47: "QC Failed",
                      48: "Reached Warehouse",
                      49: "Custom Cleared",
                      50: "In Flight",
                      51: "Handover to Courier",
                      52: "Shipment Booked",
                      54: "In Transit Overseas",
                      55: "Connection Aligned",
                      56: "Reached Overseas Warehouse",
                      57: "Custom Cleared Overseas",
                      59: "Box Packing"
                    };
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Icon(Icons.calendar_month),
                                      ],
                                    ),
                                    GestureDetector(
                                      onDoubleTap: () {},
                                      child: Text(snapshot
                                          .data!.trackingData!.etd
                                          .toString()),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("status : "),
                                    Text(shipment[snapshot
                                            .data!.trackingData!.shipmentStatus]
                                        .toString())
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  MapDisplay(
                                                      trackingData: snapshot
                                                          .data!.trackingData!),
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.map))
                                  ],
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.trackingData!
                                        .shipmentTrack.length,
                                    itemBuilder: (context, i) {
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: JsonView.map(snapshot
                                            .data!.trackingData!
                                            .toJson()),
                                      );
                                    })
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }
              },
            ),
    );
  }

  // ignore: non_constant_identifier_names
  ListView SearchBar() {
    return ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // With AWB
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: Card(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      tracking_heading("Track with AWB"),
                      Row(
                        children: [
                          Flexible(
                            flex: 6,
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              child: TextField(
                                  controller: searchQueryAWB,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Enter AWB number',
                                  )),
                            ),
                          ),
                          Flexible(
                            child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                child: IconButton(
                                    onPressed: () {
                                      trackapi = getTrackAWB("277553044205");
                                      searched = true;
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.search))),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          // with shipment
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: Card(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      tracking_heading("Track with shipment number"),
                      Row(
                        children: [
                          Flexible(
                            flex: 6,
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              child: TextField(
                                  controller: searchQuerySHIP,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Enter shipment  number',
                                  )),
                            ),
                          ),
                          Flexible(
                            child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                child: IconButton(
                                    onPressed: () {
                                      trackapi = getTrackSHIP("277553044205");
                                      searched = true;
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.search))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // with order number
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: Card(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      tracking_heading("Track with Order ID & Channel ID"),
                      Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                flex: 6,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(10),
                                  child: TextField(
                                      controller: searchQueryORDER,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Enter Order number',
                                      )),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(10),
                                    child: const Text(" ")),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 6,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(10),
                                  child: TextField(
                                      controller: searchQueryCHANNELID,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Enter channel_id number',
                                      )),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(10),
                                    child: IconButton(
                                        onPressed: () {
                                          trackapi = getTrackORDER(
                                              searchQueryCHANNELID.text,
                                              searchQueryORDER.text);
                                          searched = true;
                                          setState(() {});
                                        },
                                        icon: const Icon(Icons.search))),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // with Channel id number
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Expanded(
          //     child: Card(
          //       child: SizedBox(
          //         width: MediaQuery.of(context).size.width,
          //         height: MediaQuery.of(context).size.height * 0.2,
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             tracking_heading("Track with Channel ID"),
          //             Row(children: [

          //             ]),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // asdfs
        ]);
  }

  // ignore: non_constant_identifier_names
  Padding tracking_heading(String s) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        s,
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.blueGrey),
      ),
    );
  }
}
