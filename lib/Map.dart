// ignore: file_names
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapDisplay extends StatefulWidget {
  const MapDisplay({Key? key}) : super(key: key);

  @override
  State<MapDisplay> createState() => _MapDisplayState();
}

class _MapDisplayState extends State<MapDisplay> {
  double doubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;
  List<Marker> allMarkers = [];
// int maxMarkersCount = 5000;
  int _sliderVal = 5000 ~/ 10;

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
    return FlutterMap(
      options: MapOptions(
        center: LatLng(51.5, -0.09),
        zoom: 13.0,
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
            point: LatLng(
              51.5,
              -0.09,
            ),
            builder: (context) => const FlutterLogo(),
          ),
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(
              52.5,
              -0.09,
            ),
            builder: (context) => const FlutterLogo(),
          ),
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(
              54.5,
              -0.09,
            ),
            builder: (context) => const FlutterLogo(),
          ),
        ]),
      ],
    );
  }
}
