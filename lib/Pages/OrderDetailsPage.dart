import 'dart:convert';
import 'package:apostrophe/Pages/MapForOrder.dart';
import 'package:apostrophe/Models/MapDetailsModel.dart';
import 'package:apostrophe/WebView.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:apostrophe/Models/OrderSpecificsModel.dart';
import 'package:apostrophe/Models/allOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// TODO:
// add more details for order
class OrderDetails extends StatefulWidget {
  final Datum ord;
  final String auth;
  const OrderDetails({Key? key, required this.ord, required this.auth})
      : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late Future<OrderSpecifics> orderDetails;

  late Future<MapTrack> map;
  late Future<MapTrack> map2;
  Future<MapTrack> getLatLong(
      String billingCity, String billingStateName) async {
    var uri = Uri(
        scheme: 'http',
        host: 'api.positionstack.com',
        path: "/v1/forward",
        queryParameters: {
          "access_key": "e1c01ad604d0cc6d25c6680feb61adfb",
          "query": billingCity + " " + billingStateName
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
      // throw Exception('Failed to load album');
      return MapTrack(data: []);
    }
  }

  Future<OrderSpecifics> getOrderSpecsApi() async {
    String token = widget.auth.toString();
    print("token is + ${token}");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };

    var response = await http.get(
        Uri.parse(
            'https://apiv2.shiprocket.in/v1/external/orders/show/${widget.ord.id}'),
        headers: headers);

    if (response.statusCode == 200) {
      // print(response.body.toString());
      return OrderSpecifics.fromJson(json.decode(response.body.toString()));
    } else {
      print(response.body.toString());
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    orderDetails = getOrderSpecsApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Order #" + widget.ord.id.toString())),
        body: FutureBuilder<OrderSpecifics>(
            future: orderDetails,
            builder:
                (BuildContext context, AsyncSnapshot<OrderSpecifics> order) {
              if (order.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                map = getLatLong(order.data!.data.billingCity,
                    order.data!.data.billingStateName);
                return Container(
                    child: SizedBox(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Expanded(
                                      child: Card(
                                        child: Wrap(
                                          spacing: 20,
                                          runSpacing: 20,
                                          runAlignment: WrapAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text("Customer Name: "),
                                                Text(order
                                                    .data!.data.customerName
                                                    .toString()),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text("Customer Email: "),
                                                Text(order
                                                    .data!.data.customerEmail
                                                    .toString()),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text("Customer Phone: "),
                                                Text(order
                                                    .data!.data.customerPhone
                                                    .toString()),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                    "Order Created At: "),
                                                Text(order.data!.data.createdAt
                                                    .toString()),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text("Return Allowed: "),
                                                Text(order.data!.data
                                                            .allowReturn ==
                                                        "1"
                                                    ? "Yes"
                                                    : "No"),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Order Pickup Location: ",
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    order.data!.data
                                                        .pickupLocation
                                                        .toString(),
                                                    textAlign: TextAlign.end,
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                    "Order Shipping title: "),
                                                Text(order
                                                    .data!.data.shippingTitle
                                                    .toString())
                                                // .shippingMethod.toString()),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Order Total:   "),
                                                Text(order.data!.data.total
                                                    .toString()),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text("Order Tax: "),
                                                Text(order.data!.data.tax
                                                    .toString()),
                                              ],
                                            ),
                                            Card(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      launch(
                                                          "tel://21213123123");
                                                    },
                                                    child: Icon(Icons.call),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      String?
                                                          encodeQueryParameters(
                                                              Map<String,
                                                                      String>
                                                                  params) {
                                                        return params.entries
                                                            .map((e) =>
                                                                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                                            .join('&');
                                                      }

                                                      final Uri emailLaunchUri =
                                                          Uri(
                                                              scheme: 'mailto',
                                                              path: order
                                                                  .data!
                                                                  .data
                                                                  .customerEmail,
                                                              query:
                                                                  encodeQueryParameters(
                                                                <String,
                                                                    String>{
                                                                  'subject':
                                                                      'Regarding the order Number ${order.data!.data.id}'
                                                                },
                                                              ));

                                                      launch(emailLaunchUri
                                                          .toString());
                                                    },
                                                    child: Icon(Icons.mail),
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    WeviewPage(
                                                                        url: order
                                                                            .data!
                                                                            .data
                                                                            .trackingUrl
                                                                            .toString())));
                                                      },
                                                      child: Icon(Icons
                                                          .track_changes_outlined))
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  FutureBuilder(
                                      future: Future.wait([
                                        getLatLong(order.data!.data.billingCity,
                                            order.data!.data.billingStateId),
                                        getLatLong(
                                            order.data!.data.customerCity,
                                            order.data!.data.customerState),
                                      ]),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<List<MapTrack>>
                                              snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else {
                                          if (snapshot.data!.isEmpty) {
                                            print(
                                                "location ${order.data!.data.billingCity + order.data!.data.billingStateId}   asdasd location ${order.data!.data.customerCity + order.data!.data.customerState}");
                                            return mapWidgetForDetails(
                                              latitude: snapshot
                                                  .data![0].data[0].latitude,
                                              longitude: snapshot
                                                  .data![0].data[0].longitude,
                                              latitude2: snapshot
                                                  .data![1].data[0].latitude,
                                              longitude2: snapshot
                                                  .data![1].data[0].longitude,
                                            );
                                          } else {
                                            print(
                                                "location ${order.data!.data.billingCity + order.data!.data.billingPincode}   asdasd location ${order.data!.data.customerAddress + order.data!.data.customerPincode}");
                                            print(
                                                "${snapshot.data![0].data[0].latitude}");
                                            return mapWidgetForDetails(
                                              latitude: snapshot
                                                  .data![0].data[0].latitude,
                                              longitude: snapshot
                                                  .data![0].data[0].longitude,
                                              latitude2: snapshot
                                                  .data![1].data[0].latitude,
                                              longitude2: snapshot
                                                  .data![1].data[0].longitude,
                                            );
                                          }
                                        }

                                        // GestureDetector(
                                        //   onTap: () {
                                        //     Navigator.push(
                                        //         context,
                                        //         MaterialPageRoute(
                                        //             builder: (BuildContext context) =>
                                        //                 MapShip(orderDetails: order.data!)));
                                        //   },
                                        //   child: Container(
                                        //     child: Icon(Icons.map_outlined),
                                        //   ),
                                        // )
                                      }),
                                ]))));
              }
            }));
  }

  Container mapWidgetForDetails(
      {double latitude = 28.645093312626376,
      double longitude = 77.07422383707488,
      double latitude2 = 27.645093312626376,
      double longitude2 = 76.07422383707488}) {
    return Container(
      height: 600,
      width: 200,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(latitude2, longitude2),
            zoom: 4.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(markers: [
              Marker(
                  width: 80.0,
                  // height: 80.0,
                  point: LatLng(28.645093312626376, 77.07422383707488),
                  builder: (context) {
                    return Container(
                      child: GestureDetector(
                        onTap: (() {}),
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
              Marker(
                  width: 80.0,
                  // height: 80.0,
                  point: LatLng(latitude2, longitude2),
                  builder: (context) {
                    return Container(
                      child: GestureDetector(
                        onTap: (() {}),
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
        ),
      ),
    );
  }
}
