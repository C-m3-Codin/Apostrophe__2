import 'dart:convert';

import 'package:apostrophe/Models/UserAuthModel.dart';
import 'package:apostrophe/Models/track.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    // TODO: implement initState
    super.initState();
    // trackapi = getTrack();
    // trackapi=Future.
  }

  Future<Track> getTrackAWB(String ship) async {
    String token = widget.profile.token.toString();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
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

  Future<Track> getTrackORDER(String channelId, String OrderId) async {
    String token = widget.profile.token.toString();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
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
      'Authorization': 'Bearer ${token}'
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
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError)
                    return Center(
                        child:
                            Text('Error: No awb order found on that number'));
                  else {
                    return Center(
                        child: Text(
                            "${snapshot.data!.trackingData!.trackUrl.toString()}"));
                  }
                }
              },
            ),
    );
  }

  Column SearchBar() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // With AWB
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
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
                                    icon: Icon(Icons.search))),
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
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
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
                                    icon: Icon(Icons.search))),
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
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      tracking_heading("Track with Order ID"),
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
                                  child: Text(" ")))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // with Channel id number
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      tracking_heading("Track with Channel ID"),
                      Row(children: [
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
                                  icon: Icon(Icons.search))),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // asdfs
        ]);
  }

  Padding tracking_heading(String s) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        s,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
      ),
    );
  }
}
