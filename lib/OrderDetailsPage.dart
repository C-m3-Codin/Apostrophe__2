import 'dart:convert';
import 'package:apostrophe/MapForOrder.dart';
import 'package:http/http.dart' as http;
import 'package:apostrophe/Models/OrderSpecificsModel.dart';
import 'package:apostrophe/Models/allOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
        appBar: AppBar(title: Text("Order ID: " + widget.ord.id.toString())),
        body: FutureBuilder<OrderSpecifics>(
            future: orderDetails,
            builder:
                (BuildContext context, AsyncSnapshot<OrderSpecifics> order) {
              if (order.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Container(
                    child: SizedBox(
                        child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
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
                                  children: [
                                    const Text("Customer Name: "),
                                    Text(order.data!.data.customerName
                                        .toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Customer Email: "),
                                    Text(order.data!.data.customerEmail
                                        .toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Customer Phone: "),
                                    Text(order.data!.data.customerPhone
                                        .toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Order Created At: "),
                                    Text(order.data!.data.createdAt.toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Return Allowed: "),
                                    Text(order.data!.data.allowReturn == 1
                                        ? "Yes"
                                        : "No"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Order Pickup Location: "),
                                    Text(order.data!.data.pickupLocation
                                        .toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Order Shipping title: "),
                                    Text(order.data!.data.shippingTitle
                                        .toString())
                                    // .shippingMethod.toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Order Total: "),
                                    Text(order.data!.data.total.toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Order Tax: "),
                                    Text(order.data!.data.tax.toString()),
                                  ],
                                ),
                                Card(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          launch("tel://21213123123");
                                        },
                                        child: Icon(Icons.call),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          String? encodeQueryParameters(
                                              Map<String, String> params) {
                                            return params.entries
                                                .map((e) =>
                                                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                                .join('&');
                                          }

                                          final Uri emailLaunchUri = Uri(
                                              scheme: 'mailto',
                                              path: order
                                                  .data!.data.customerEmail,
                                              query: encodeQueryParameters(
                                                <String, String>{
                                                  'subject':
                                                      'Regarding the order Number ${order.data!.data.id}'
                                                },
                                              ));

                                          launch(emailLaunchUri.toString());
                                        },
                                        child: Icon(Icons.mail),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MapShip(orderDetails: order.data!)));
                        },
                        child: Container(
                          child: Icon(Icons.map_outlined),
                        ),
                      )
                    ],
                  ),
                )));
              }
            }));
  }
}
