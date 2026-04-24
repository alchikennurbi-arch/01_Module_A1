import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kz_worldskills_a201/pages/Success.dart';
import 'package:kz_worldskills_a201/widgets/Home.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (var item in savedItems) {
      item.status = "Order placed";
    }

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        for (var item in savedItems) {
          switch (item.status) {
            case "Order placed":
              item.status = "Cooking";
              break;
            case "Cooking":
              item.status = "Served";
              break;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double total = 0;

    for (var item in savedItems) {
      total += (double.parse(item.price) * item.count);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: SizedBox.shrink(),
        backgroundColor: Colors.white,
        title: Text("Checkout", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: savedItems.length,
              itemBuilder: (context, index) {
                final item = savedItems[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),

                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Expanded(
                        flex: 7,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Image.asset(
                                "assets/images/${item.image_url}",
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${item.name}"),
                                    Text("${item.count}"),
                                  ],
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  Text(
                                    "Status: ",
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  Text(
                                    "${item.status}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: item.status == "Order placed"
                                          ? Colors.black
                                          : item.status == "Cooking"
                                          ? Colors.yellow
                                          : Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              flex: 1,
                              child: Row(
                                spacing: 10,
                                children: [
                                  Text(
                                    "${double.parse(item.price) * item.count}",
                                  ),

                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusGeometry.circular(5),
                                        side: BorderSide(
                                          color: item.status == "Order placed"
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      item.status == "Order placed"
                                          ? setState(() {
                                              savedItems.removeAt(index);
                                            })
                                          : null;
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        10,
                                        70,
                                        10,
                                        70,
                                      ),
                                      child: Text(
                                        "Clear",
                                        style: TextStyle(
                                          color: item.status == "Order placed"
                                              ? Colors.red
                                              : Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 600),
            child: Container(
              width: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Total:", style: TextStyle(fontSize: 20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80),
                          child: Text(
                            "\$ ${total}",
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 30),
                    Container(color: Colors.grey, width: 2, height: 140),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                          },
                          child: Text(
                            "Add dish",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(color: Colors.grey, width: 130, height: 2),

                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Text("Notice"),
                                  content: Text("Whether to submit an order"),
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 100),
                                      child: Row(
                                        spacing: 10,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadiusGeometry.circular(
                                                      5,
                                                    ),
                                                side: BorderSide(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "No",
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),

                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadiusGeometry.circular(
                                                      5,
                                                    ),
                                                side: BorderSide(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Success(),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            "Checkout",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
