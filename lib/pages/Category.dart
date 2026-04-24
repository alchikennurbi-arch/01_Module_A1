import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kz_worldskills_a201/models/FoodItem.dart';
import 'package:kz_worldskills_a201/widgets/Home.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<dynamic> category = [];
  List<Fooditem> foods = [];
  String first = "1";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  Future<void> load() async {
    final String responseF = await rootBundle.loadString(
      "assets/json/food_menu.json",
    );
    final String responseC = await rootBundle.loadString(
      "assets/json/food_type.json",
    );

    final List<dynamic> dataC = jsonDecode(responseC);
    final List<dynamic> dataF = jsonDecode(responseF);

    setState(() {
      category = dataC;
      foods = dataF.map((e) => Fooditem.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentFood = foods.where((e) => e.type_id == first).toList();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          SizedBox(
            width: 120,
            child: ListView.builder(
              itemCount: category.length,
              itemBuilder: (context, index) {
                bool selected = category[index]["id"] == first;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        first = category[index]["id"];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: selected ? Colors.blue : Colors.grey,
                        ),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          category[index]['name'],
                          style: TextStyle(
                            color: selected ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: currentFood.length,
              itemBuilder: (context, index) {
                final item = currentFood[index];
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
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                "assets/images/${item.image_url}",
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${item.name}"),
                                    Text(
                                      "${double.parse(item.price) * item.count}",
                                    ),
                                    Text("${item.remark}"),

                                    Padding(
                                      padding: const EdgeInsets.only(left: 640),
                                      child: Row(
                                        children: [
                                          if (item.count > 0)
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  item.count--;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.remove_circle_outline,
                                                size: 30,
                                              ),
                                            ),
                                          if (item.count > 0)
                                            Text(
                                              "${item.count}",
                                              style: TextStyle(fontSize: 25),
                                            ),

                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                item.count++;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.add_circle_outline,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      ),
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
    );
  }
}
