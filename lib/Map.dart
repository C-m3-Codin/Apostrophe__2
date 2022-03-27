// ignore: file_names
import 'dart:math';

import 'package:apostrophe/LoginPage.dart';
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

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      var r = Random();
      for (var x = 0; x < 1; x++) {
        allMarkers.add(
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(
              doubleInRange(r, 37, 55),
              doubleInRange(r, -9, 30),
            ),
            builder: (context) => const FlutterLogo(),
          ),
        );
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Geolocation")),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(28.38, 77.12),
          zoom: 5.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
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
                                trackDetails(dataTrack: widget.trackingData),
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
                                trackDetails(dataTrack: widget.trackingData),
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
            // Marker(
            //   width: 80.0,
            //   height: 80.0,
            //   point: LatLng(
            //     54.5,
            //     -0.09,
            //   ),
            //   builder: (context) => const FlutterLogo(),
            // ),
          ]),
        ],
      ),
      // ListView.builder(
      //     shrinkWrap: true,
      //     itemCount: widget.trackingData.shipmentTrack.length,
      //     itemBuilder: (context, i) {
      //       return SingleChildScrollView(
      //         scrollDirection: Axis.horizontal,
      //         child: JsonView.map(widget.trackingData.toJson()),
      //       );
      //     })
    );
  }
}
