import 'package:apostrophe/Models/track.dart';
import 'package:flutter/material.dart';
import 'package:flutter_json_view/flutter_json_view.dart';

class trackDetails extends StatefulWidget {
  TrackingData dataTrack;
  trackDetails({Key? key, required this.dataTrack}) : super(key: key);

  @override
  State<trackDetails> createState() => trackDetailsState();
}

class trackDetailsState extends State<trackDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details of the order")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: JsonView.map(widget.dataTrack.toJson()),
          ),
        ),
      ),
    );
  }
}
