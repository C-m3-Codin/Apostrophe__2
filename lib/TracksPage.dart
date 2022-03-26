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
      appBar: AppBar(
        title: Text("Track Package"),
      ),
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              Flexible(
                flex: 6,
                child: Container(
                  // width: 400,
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
                    // width: 400,
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
          ),
          Text("Or"),
          Row(
            children: [
              Flexible(
                flex: 6,
                child: Container(
                  // width: 400,
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
                    // width: 400,
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
          Text("Or"),
          Column(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 6,
                    child: Container(
                      // width: 400,
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
                          // width: 400,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          child: Text(" ")))
                ],
              ),
              Row(children: [
                Flexible(
                  flex: 6,
                  child: Container(
                    // width: 400,
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
                      // width: 400,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: IconButton(
                          onPressed: () {
                            trackapi = getTrackORDER(searchQueryCHANNELID.text,
                                searchQueryORDER.text);
                            searched = true;
                            setState(() {});
                          },
                          icon: Icon(Icons.search))),
                ),
              ])
            ],
          ),
        ]);
  }
}
