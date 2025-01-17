// import 'dart:js';

import 'package:demo_project/GetX%20Controller/cartController.dart';
import 'package:demo_project/GetX%20Controller/productdetailController.dart';
import 'package:demo_project/GetX%20Controller/shippingControlle.dart';
import 'package:demo_project/GetX Controller/addressControlle.dart';
import 'package:demo_project/Screens/addressScreen.dart';
import 'package:demo_project/Screens/homeScreen.dart';
import 'package:demo_project/Screens/tabNavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class CartScreeen extends StatefulWidget {
  const CartScreeen({Key? key}) : super(key: key);

  @override
  State<CartScreeen> createState() => _CartScreeenState();
}

class _CartScreeenState extends State<CartScreeen> {
  final CartController cartController = Get.put(CartController());
  final ProductDetailContoller productDetailContoller =
      Get.put(ProductDetailContoller());
  final ShippingController shippingController = Get.put(ShippingController());
  final AddressController addressControlle = Get.put(AddressController());
  late Future<List<Map<String, dynamic>>> _futureCartData; // Adjusted type

  void _fetchCartData() {
    _futureCartData = cartController.getCartItems();

    _futureCartData.catchError((error) {
      print("Error occurred while fetching cart items: $error");
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchCartData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
         leading: IconButton(
  icon: Icon(Icons.arrow_back), // Wrap the icon with Icon widget
  onPressed: () {
    Get.to(() => TabNavigation());
  },
),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 12,
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _futureCartData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.data==null || snapshot.data!.isEmpty){
                    // Data is loaded
                    // Data is loaded
                    return Center(
                     
                      child:Image.asset('assets/cart.png', fit: BoxFit.cover,width: 200,height: 200, ));
                  }else{
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return  
                        Container(
                          padding: EdgeInsets.all(10),
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 147, 183, 245)),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.blueGrey[50]),
                                      child: Image.network(
                                        snapshot.data![index]['product_image'],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            iconSize: 18.0,
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text("Confirmation"),
                                                    content: Text(
                                                        "Are you sure you want to decrease the quantity?"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(); // Close the dialog
                                                          cartController
                                                              .minusProductQuantity(
                                                            snapshot.data![
                                                                index]['id'],
                                                            snapshot.data![
                                                                index]['total'],
                                                          )
                                                              .then((_) {
                                                            setState(() {
                                                              _fetchCartData();
                                                            });
                                                          });
                                                        },
                                                        child: Text("Yes"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(); // Close the dialog
                                                        },
                                                        child: Text("No"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            icon: Icon(Icons.remove),
                                          ),
                                          Text(snapshot.data![index]
                                              ['quantity']),
                                          IconButton(
                                            iconSize: 18.0,
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text("Confirmation"),
                                                    content: Text(
                                                        "Are you sure you want to increase the quantity?"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                               CircularProgressIndicator();
                                                               // Close the dialog
                                                          cartController
                                                              .addProductQuantity(
                                                            snapshot.data![
                                                                index]['id'],
                                                            snapshot.data![
                                                                index]['total'],
                                                          )
                                                              .then((_) {
                                                            setState(() {
                                                              _fetchCartData();
                                                            });
                                                          });
                                                        },
                                                        child: Text("Yes"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(); // Close the dialog
                                                        },
                                                        child: Text("No"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            icon: Icon(Icons.add),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            child: Text(
                                              snapshot.data![index]
                                                  ['product_name'],
                                              style: TextStyle(
                                                  overflow: TextOverflow.fade,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Quantity : ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(snapshot.data![index]
                                                  ['quantity']),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "TotalPrice : ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                  "\$ ${snapshot.data![index]['total'].toString().length >= 5 ? snapshot.data![index]['total'].toString().substring(0, 5) : snapshot.data![index]['total'].toString()}"),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: IconButton(
                                          icon: Icon(Icons.info),
                                          onPressed: () {
                                            productDetailContoller
                                                .getProductDetail(snapshot
                                                    .data![index]['id']);
                                          },
                                          color:
                                              Color.fromARGB(255, 6, 104, 11),
                                          iconSize: 20.0,
                                          tooltip: 'Love',
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Confirmation'),
                                                content: Text(
                                                    'Are you sure you want to delete this item?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      // Perform action when "Yes" is pressed
                                                      Navigator.of(context).pop(
                                                          true); // Close the dialog and pass true
                                                    },
                                                    child: Text('Yes'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      // Perform action when "No" is pressed
                                                      Navigator.of(context).pop(
                                                          false); // Close the dialog and pass false
                                                    },
                                                    child: Text('No'),
                                                  ),
                                                ],
                                              );
                                            },
                                          ).then((value) {
                                            if (value != null && value) {
                                              // If user clicks "Yes", proceed with deletion
                                              cartController
                                                  .deleteCartItem(snapshot
                                                      .data![index]['id'])
                                                  .then((_) {
                                                setState(() {
                                                  _fetchCartData();
                                                });
                                              });
                                            }
                                          });
                                        },
                                        color: Color.fromARGB(255, 243, 34, 34),
                                        iconSize: 20.0,
                                        tooltip: 'Delete',
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Obx(() => 
               Expanded(
                  flex: 2,
                  child: Visibility(
                   visible: cartController.cardDataisEmpty.value,
              
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Text("Sub Total - ",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)),
                              FutureBuilder<List<Map<String, dynamic>>>(
                                future: _futureCartData,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else {
                                    double totalAmount = 0;
                                    if (snapshot.hasData) {
                                      snapshot.data!.forEach((item) {
                                        totalAmount += item['total'];
                                      });
                                    }
                                    return Text(
                                        "\$ ${totalAmount.toStringAsFixed(2)}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold));
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 30, right: 30),
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(25)),
                          child: TextButton(
                            onPressed: () {
                              // Get.to(()=>addressScreen());
                              
                              addressControlle.fetchOldAddress1(context);
                            },
                            child: Text("Proceed to Checkout"),
                          ),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
