import 'package:flutter/material.dart';
import 'package:kz_worldskills_a201/models/FoodItem.dart';
import 'package:kz_worldskills_a201/pages/Category.dart';
import 'package:kz_worldskills_a201/pages/Checkout.dart';
import 'package:kz_worldskills_a201/pages/Menu.dart';

List<Fooditem> savedItems = [];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPage = 0;
  List<Widget> pages = [Menu(), Category()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(children: pages, index: currentPage),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          currentPage == 0 ? "Menu" : "Category",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(5),
                  side: BorderSide(color: Colors.black),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, setState) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          backgroundColor: Colors.white,
                          contentPadding: EdgeInsets.all(0),
                          insetPadding: EdgeInsets.only(left: 680),

                          content: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                            setState(() {
                                              savedItems.clear();
                                            });
                                          },
                                          child: Text(
                                            "Clear all",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),

                                        Text(
                                          "Cart",
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
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
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "Clear all",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadiusGeometry.circular(
                                                  5,
                                                ),
                                            side: BorderSide(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                backgroundColor: Colors.white,
                                                title: Text("Notice"),
                                                content: Text(
                                                  "Whether to submit an order",
                                                ),
                                                actions: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          left: 100,
                                                        ),
                                                    child: Row(
                                                      spacing: 10,
                                                      children: [
                                                        ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadiusGeometry.circular(
                                                                    5,
                                                                  ),
                                                              side: BorderSide(
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(
                                                              context,
                                                            ).pop();
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
                                                            backgroundColor:
                                                                Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadiusGeometry.circular(
                                                                    5,
                                                                  ),
                                                              side: BorderSide(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Checkout(),
                                                              ),
                                                            );
                                                          },
                                                          child: Text(
                                                            "Yes",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
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
                                          "Submit order",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: savedItems.length,
                                        itemBuilder: (context, index) {
                                          final item = savedItems[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: Colors.grey,
                                                ),
                                              ),

                                              child: Container(
                                                height: 180,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                child: Expanded(
                                                  flex: 4,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Image.asset(
                                                          "assets/images/${item.image_url}",
                                                          height: 180,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                8.0,
                                                              ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "${item.name}",
                                                              ),
                                                              Text(
                                                                "${double.parse(item.price) * item.count}",
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                      Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                8.0,
                                                              ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadiusGeometry.circular(
                                                                          5,
                                                                        ),
                                                                    side: BorderSide(
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    savedItems
                                                                        .removeAt(
                                                                          index,
                                                                        );
                                                                  });
                                                                },
                                                                child: Text(
                                                                  "Delete",
                                                                  style: TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ),
                                                              ),

                                                              Row(
                                                                children: [
                                                                  if (item.count >
                                                                      0)
                                                                    IconButton(
                                                                      onPressed: () {
                                                                        setState(
                                                                          () {
                                                                            item.count--;
                                                                          },
                                                                        );
                                                                      },
                                                                      icon: Icon(
                                                                        Icons
                                                                            .remove_circle_outline,
                                                                        size:
                                                                            30,
                                                                      ),
                                                                    ),
                                                                  if (item.count >
                                                                      0)
                                                                    Text(
                                                                      "${item.count}",
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            25,
                                                                      ),
                                                                    ),

                                                                  IconButton(
                                                                    onPressed: () {
                                                                      setState(
                                                                        () {
                                                                          item.count++;
                                                                        },
                                                                      );
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .add_circle_outline,
                                                                      size: 30,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
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
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
              child: Text("Cart", style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        backgroundColor: Colors.white,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              color: currentPage == 0 ? Colors.blue : Colors.grey,
              width: double.infinity,
              height: 5,
            ),
            label: "Menu",
          ),
          BottomNavigationBarItem(
            icon: Container(
              color: currentPage == 1 ? Colors.blue : Colors.grey,
              width: double.infinity,
              height: 5,
            ),
            label: "Category",
          ),
        ],
      ),
    );
  }
}
