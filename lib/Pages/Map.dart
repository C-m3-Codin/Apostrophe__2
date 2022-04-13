// ignore: file_names
import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'package:apostrophe/Models/MapDetailsModel.dart';
import 'package:http/http.dart' as http;
// import 'package:apostrophe/LoginPage.dart';
import 'package:apostrophe/Models/track.dart';
import 'package:apostrophe/TrackDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_json_view/flutter_json_view.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapDisplay extends StatefulWidget {
  TrackingData trackingData;
  MapDisplay({Key? key, required this.trackingData}) : super(key: key);

  @override
  State<MapDisplay> createState() => _MapDisplayState();
}

class _MapDisplayState extends State<MapDisplay> {
  double doubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;
  List<Marker> allMarkers = [];
// int maxMarkersCount = 5000;
  int _sliderVal = 5000 ~/ 10;
  bool mapOneTapped = false;
  bool maptwoTapped = false;
  String delivered = "";
  String destination = "";
  String origin = "";
  List<Map<String, String>> cordinates = [];

  late Future<MapTrack> map;
  Future<MapTrack> getLatLong(String placeName) async {
    var uri = Uri(
        scheme: 'http',
        host: 'api.positionstack.com',
        path: "/v1/forward",
        queryParameters: {
          "access_key": "e1c01ad604d0cc6d25c6680feb61adfb",
          "query": placeName
        });

    // request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();
    print("url is ${uri} ");
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      print("\n\n\n response from map ok ${response.body.toString()}");
      // print(response.body.toString());
      return MapTrack.fromJson(json.decode(response.body.toString()));
    } else {
      print("\n\n\n response from map bad ${response.body.toString()}");
      print(response.body.toString());
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    var k = widget.trackingData.shipmentTrack.forEach((element) {
      delivered = element.deliveredTo.toString();
      destination = element.destination.toString();
      origin = element.origin.toString();
    });

// getLatLong

// GetlatLong
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Geolocation")),
      body: FutureBuilder(
          future: Future.wait([
            getLatLong(widget.trackingData.shipmentTrack[0].origin.toString()),
            getLatLong(
                widget.trackingData.shipmentTrack[0].destination.toString()),
          ]),
          builder:
              (BuildContext context, AsyncSnapshot<List<MapTrack>> snapshot) {
            if (snapshot.hasData) {
              return FlutterMap(
                options: MapOptions(
                  center: LatLng(28.38, 77.12),
                  zoom: 5.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayerOptions(markers: [
                    Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(snapshot.data![1].data[0].latitude,
                            snapshot.data![1].data[0].longitude),
                        builder: (context) {
                          return Container(
                            child: GestureDetector(
                              onTap: (() {
                                mapOneTapped = true;
                                setState(() {});
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        trackDetails(
                                            dataTrack: widget.trackingData),
                                  ),
                                );
                              }),
                              child: const Icon(
                                Icons.person,
                                size: 20,
                                color: Colors.red,
                              ),
                            ),
                          );
                        }),
                    Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(snapshot.data![0].data[0].latitude,
                            snapshot.data![0].data[0].longitude),
                        builder: (context) {
                          return Container(
                            child: GestureDetector(
                              onTap: (() {
                                mapOneTapped = true;
                                setState(() {});
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        trackDetails(
                                            dataTrack: widget.trackingData),
                                  ),
                                );
                              }),
                              child: const Icon(
                                Icons.person,
                                size: 20,
                                color: Colors.red,
                              ),
                            ),
                          );
                        }
                        // Icon(Icons.room_rounded),
                        ),

                    // ),
                  ]),
                ],
              );

              // Center(
              //   child:
              //       Container(child: Text("${snapshot.data!.data.toString()}")),
              // );
            }
            return FlutterMap(
              options: MapOptions(
                center: LatLng(28.38, 77.12),
                zoom: 5.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(markers: [
                  Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(33.76750416182363, 74.09102457035667),
                      builder: (context) {
                        return Container(
                          child: GestureDetector(
                            onTap: (() {
                              mapOneTapped = true;
                              setState(() {});
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      trackDetails(
                                          dataTrack: widget.trackingData),
                                ),
                              );
                            }),
                            child: const Icon(
                              Icons.person,
                              size: 20,
                              color: Colors.red,
                            ),
                          ),
                        );
                      }),
                  Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(28.645093312626376, 77.07422383707488),
                      builder: (context) {
                        return Container(
                          child: GestureDetector(
                            onTap: (() {
                              mapOneTapped = true;
                              setState(() {});
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      trackDetails(
                                          dataTrack: widget.trackingData),
                                ),
                              );
                            }),
                            child: const Icon(
                              Icons.person,
                              size: 20,
                              color: Colors.red,
                            ),
                          ),
                        );
                      }
                      // Icon(Icons.room_rounded),
                      ),

                  // ),
                ]),
              ],
            );
          }),
    );
  }
}
