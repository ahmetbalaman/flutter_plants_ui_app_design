import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/plant_model.dart';

class PlantScreen extends StatefulWidget {
  const PlantScreen({Key? key, required this.plant}) : super(key: key);

  final Plant plant;
  @override
  State<PlantScreen> createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 30, right: 30, top: 60),
                      height: 520,
                      color: Colors.green.shade500,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back),
                                iconSize: 30,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              Icon(
                                Icons.shopping_cart,
                                size: 30.0,
                                color: Colors.white,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            widget.plant.category!.toUpperCase(),
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          Text(
                            widget.plant.name!,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            "From",
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                          Text(
                            "\$${widget.plant.price!}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            "Size",
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                          Text(
                            "${widget.plant.size!}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          RawMaterialButton(
                            onPressed: () {
                              print("Has been added");
                            },
                            padding: EdgeInsets.all(15),
                            shape: CircleBorder(),
                            elevation: 2,
                            fillColor: Colors.black,
                            child: Icon(
                              Icons.add_shopping_cart,
                              color: Colors.white,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: 20,
                      bottom: 30,
                      child: Hero(
                          tag: widget.plant.imageUrl!,
                          child: Image(
                            image: AssetImage(widget.plant.imageUrl!),
                            fit: BoxFit.cover,
                            width: 280,
                            height: 280,
                          )),
                    ),
                  ],
                ),
                Container(
                  height: 400,
                  transform: Matrix4.translationValues(
                    0,
                    -20,
                    0,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 30, right: 30, top: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "All to know...",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.plant.description!,
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          value: SystemUiOverlayStyle.light),
    );
  }
}
