// import 'package:apostrophe/Models/allOrderModel.dart';
import 'dart:convert';

import 'package:apostrophe/Models/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  String token;
  ProductPage({Key? key, required this.token}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ScrollController _scrollController = ScrollController();
  String FilterBy = "";
  String filter = "";
  int page = 0;
  String sort = "";
  late Future<bool> loading;

  Product product = Product(data: [], meta: null);

  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    // trackapi = getTrack();
    // trackapi=Future.
    loading = getProductApi(0);
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        print("end of scroll reached");
        if (product.meta != null) {
          page++;
          getProductApi(page);
        }
        if (product.meta != null) {
          if (product.meta!.pagination.currentPage ==
              (product.meta!.pagination.totalPages)) {
            print("stop scrolling");
          } else {
            // page++;
            // FilterOn ? getFilteredApi(page) : getOrdersApi();
          }
        }
        // orders=

      }
    });
  }

  Future<bool> getProductApi(int page) async {
    print("gonna fetch filter");
    String token = widget.token;
    print("token is + ${token}");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    print(
        "filter on  fetch filter url https://apiv2.shiprocket.in/v1/external/orders?filter_by=${FilterBy}&filter=${filter}&page=${page} ");

    var response = await http.get(
        Uri.parse(
            'https://apiv2.shiprocket.in/v1/external/products?filter_by=${FilterBy}&filter=${filter}&page=${page}&sort=${sort}&sort_by=ID'),
        headers: headers);

    if (response.statusCode == 200) {
      // print(response.body.toString());
      Product temp = Product.fromJson(json.decode(response.body.toString()));
      product.data.addAll(temp.data);
      product.meta = temp.meta;
      setState(() {});

      return true;
    } else {
      print(response.body.toString());
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(child: Text("prod")),
            // FilterOptions(context),
            FutureBuilder(
                future: loading,
                builder: (_, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                        // Container(
                        height: MediaQuery.of(context).size.height - 100,
                        child: product.data.length == 0
                            ? Center(
                                child: Text("No Data to show"),
                              )
                            : ListView.builder(
                                controller: _scrollController,
                                itemCount: product.data.length,
                                itemBuilder: (_, i) {
                                  return Card(
                                    child: ListTile(
                                      title: Text(product.data[i].name),
                                      subtitle:
                                          Text(product.data[i].categoryName),
                                      trailing: Text(
                                          " quantity:${product.data[i].quantity.toString()}"),
                                    ),
                                  );
                                }));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
