import 'package:apostrophe/Models/allOrderModel.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  final Datum order;
  const OrderDetails({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order ID: " + widget.order.id.toString())),
      body: SizedBox(
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
                          Text(widget.order.customerName.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Customer Email: "),
                          Text(widget.order.customerEmail.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Customer Phone: "),
                          Text(widget.order.customerPhone.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Order Created At: "),
                          Text(widget.order.createdAt.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Return Allowed: "),
                          Text(widget.order.allowReturn == 1 ? "Yes" : "No"),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Order Pickup Location: "),
                          Text(widget.order.pickupLocation.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Order Shipping Method: "),
                          Text(widget.order.shippingMethod.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Order Total: "),
                          Text(widget.order.total.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Order Tax: "),
                          Text(widget.order.tax.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
