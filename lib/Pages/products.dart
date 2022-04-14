// import 'package:apostrophe/Models/allOrderModel.dart';
import 'dart:convert';

import 'package:apostrophe/Constants/Constants.dart';
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
  String FilterBy = "name";
  String filter = "";
  int page = 0;
  String sort = "";
  late Future<bool> loading;

  // ScrollController _scrollController = ScrollController();
  TextEditingController enterFilterFalue = TextEditingController();
  // Orders orders = Orders(data: [], meta: null);
  bool channelIDSelected = true;
  bool orderSortUp = true;
  bool FilterOn = false;
  // int page = 0;
  // String FilterBy = "status";
  // String filter = "1";
  // String sort = "ASC";
  List<String> dropOptions = statusCodeVals.keys.toList();
  String dropdownValue = "Box Packing";
  String dropDownFilterBy = "name";

  // ["cod", "prepaid orders"];
  ButtonStyle buttonOn = ElevatedButton.styleFrom(primary: Colors.blue);
  ButtonStyle buttonOff = ElevatedButton.styleFrom(primary: Colors.grey);
  late Future<bool> loaded;

  Product product = Product(data: [], meta: null);

  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    // trackapi = getTrack();
    // trackapi=Future.
    loading = getProductApi(0);
    loaded = loading;
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        print("end of scroll reached");
        if (product.meta != null) {
          page++;
          loaded = getProductApi(page);
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

  Card FilterOptions(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Row(
          children: const [
            Text(
              " Filter",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    product.data = [];
                    page = 0;
                    product.meta = null;
                    sort = orderSortUp ? "ASC" : "DESC";
                    getProductApi(page);

                    setState(() {
                      orderSortUp = !orderSortUp;
                    });
                  },
                  child: Row(children: [
                    Text("Sort"),
                    orderSortUp
                        ? Icon(Icons.arrow_upward)
                        : Icon(Icons.arrow_downward),
                  ])),

              ElevatedButton(
                  onPressed: null,
                  child: FutureBuilder<bool>(
                      future: loaded,
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return Text("Order Count ${product.data!.length}");
                        }
                      })),

              // ElevatedButton(onPressed: null, child: )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButton<String>(
                value: dropDownFilterBy,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  // width: 50,
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  // FilterBy = "status";
                  FilterBy = newValue!;
                  page = 0;
                  channelIDSelected = true;

                  setState(() {
                    if (FilterOn) {
                      FilterOn = false;
                    }
                    dropDownFilterBy = newValue!;
                  });
                },
                items: ["name", "id", "sku"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              channelIDSelected
                  ? Container(
                      // height: 100,
                      width: 100,
                      child: TextField(
                        onChanged: (value) {
                          print("value changed ${value}");
                          filter = value.toString();
                        },
                        controller: enterFilterFalue,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: FilterBy,
                            hintText: 'Enter Channel id'),
                      ),
                    )
                  : DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        width: 50,
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        // FilterBy = "status";
                        filter = FilterBy == "status"
                            ? statusCodeVals[newValue].toString()
                            : newValue.toString();

                        setState(() {
                          if (FilterOn) {
                            FilterOn = false;
                          }
                          dropdownValue = newValue!;
                        });
                      },
                      items: dropOptions
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                //to do change coor of button depending on the status of the button
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
                onPressed: () {
                  print("pressed Filter on");
                  FilterOn = true;
                  page = 0;
                  product.data = [];
                  product.meta = null;

                  loaded = getProductApi(page);
                  setState(() {});
                },
                child: Text("Apply Filters"),
              ),
              ElevatedButton(
                //to do change coor of button depending on the status of the button
                style: ElevatedButton.styleFrom(primary: Colors.grey),
                onPressed: () {
                  print("pressed Filter off");
                  FilterOn = false;
                  page = 0;
                  product.data = [];
                  product.meta = null;
                  FilterBy = "";
                  filter = "";
                  loaded = getProductApi(page);
                  setState(() {});
                },
                child: Text("Clear Filters"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(child: Text("prod")),
            FilterOptions(context),
            ProductList(context),
          ],
        ),
      ),
    );
  }

  FutureBuilder<bool> ProductList(BuildContext context) {
    return FutureBuilder(
        future: loading,
        builder: (_, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                // Container(
                height: MediaQuery.of(context).size.height - 20,
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
                              subtitle: Text(product.data[i].categoryName),
                              trailing: Text(
                                  " quantity:${product.data[i].quantity.toString()}"),
                            ),
                          );
                        }));
          }
        });
  }
}
