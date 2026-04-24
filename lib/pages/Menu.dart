import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kz_worldskills_a201/models/FoodItem.dart';
import 'package:kz_worldskills_a201/widgets/Home.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<Fooditem> recommended = [];
  List<Fooditem> hot = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  Future<void> load() async {
    final String response = await rootBundle.loadString(
      "assets/json/food_menu.json",
    );
    final List<dynamic> data = jsonDecode(response);
    final List<Fooditem> allitems = data
        .map((e) => Fooditem.fromJson(e))
        .toList();

    final List<Fooditem> filtered = allitems
        .where((e) => e.score <= 4.5)
        .toList();

    setState(() {
      hot = filtered.skip(5).take(5).toList();
      recommended = filtered.take(5).toList();
    });
  }

  Widget buildBody(String title, List<Fooditem> items) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (BuildContext context, setState) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.white,
                              contentPadding: EdgeInsets.all(0),

                              content: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Image.asset(
                                          "assets/images/${item.image_url}",
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${item.name}",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              Row(
                                                children: [
                                                  ...List.generate(5, (index) {
                                                    return Icon(
                                                      Icons.star,
                                                      color: Colors.orange,
                                                      size: 30,
                                                    );
                                                  }),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("${item.remark}"),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          if (item.count > 0)
                                                            IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  item.count--;
                                                                });
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .remove_circle_outline,
                                                                size: 30,
                                                              ),
                                                            ),
                                                          if (item.count > 0)
                                                            Text(
                                                              "${item.count}",
                                                              style: TextStyle(
                                                                fontSize: 25,
                                                              ),
                                                            ),

                                                          IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                item.count++;
                                                              });
                                                            },
                                                            icon: Icon(
                                                              Icons
                                                                  .add_circle_outline,
                                                              size: 30,
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.white,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadiusGeometry.circular(
                                                                  10,
                                                                ),
                                                            side: BorderSide(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(
                                                            context,
                                                          ).pop();
                                                          setState(() {
                                                            savedItems.add(
                                                              item,
                                                            );
                                                          });
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                10.0,
                                                              ),
                                                          child: Text(
                                                            "Submit",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
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
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 600,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                "assets/images/${item.image_url}",
                                height: 400,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${item.name}"),
                                    Row(
                                      children: [
                                        ...List.generate(5, (index) {
                                          return Icon(
                                            Icons.star,
                                            color: Colors.orange,
                                            size: 30,
                                          );
                                        }),
                                      ],
                                    ),
                                    Text("${item.remark}"),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildBody('Recommended', recommended),
          buildBody('Hot', hot),
        ],
      ),
    );
  }
}
