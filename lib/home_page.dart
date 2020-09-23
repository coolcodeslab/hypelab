import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hypelab/models/points.dart';
import 'dart:convert';
import 'package:hypelab/progress_indicator.dart';
import 'package:hypelab/wardrobe_page.dart';
import 'package:hypelab/widgets/SneakerCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';

final pointCounter = FirebaseFirestore.instance.collection('points');
Random random = Random();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  final int randomNumber = random.nextInt(30);
  String brand = 'vans';

  String data;
  int myPoint;
  drawerItem1({String url, String name}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          brand = name;
        });
        getData();
        print('done');
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.only(right: 10, left: 10, bottom: 24),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: Color(0xffFF4B66),
          image: DecorationImage(
            image: AssetImage(url),
          ),
        ),
      ),
    );
  }

  getList(String documentData) {
    List<SneakerCard> cards = [];

    for (int i = 0; i < 10; i++) {
      var shoePrice = jsonDecode(documentData)['results'][i]['retailPrice'];
      var shoeName = jsonDecode(documentData)['results'][i]['title'];
      var shoeImage =
          jsonDecode(documentData)['results'][i]['media']['imageUrl'];
      print(shoePrice);

      SneakerCard newCard = SneakerCard(
        url: shoeImage,
        name: shoeName,
        price: shoePrice == null ? 0 : shoePrice,
        randomNumber: randomNumber,
      );
      cards.add(newCard);
    }
    return cards;
  }

  void getData() async {
    http.Response response = await http.get(
      'https://api.thesneakerdatabase.com/v1/sneakers?limit=10&brand=$brand&gender=men',
    );

    if (response.statusCode == 200) {
      setState(() {
        data = response.body;
      });
    } else {
      print(response.statusCode);
    }
  }

  createFloatingActionButton() {
    return StreamBuilder<QuerySnapshot>(
      stream: pointCounter.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return FloatingActionButton(
            onPressed: () {
              print(snapshot.data.docs.toString());
            },
            child: CircularProgressIndicator(),
          );
        }
        final points = snapshot.data.docs;
        for (var point in points) {
          final currentPoints = point.data();
          final myFirebasePoint = currentPoints['points'];

          myPoint = myFirebasePoint;
        }

        return FloatingActionButton(
          onPressed: () {
            print(points);
          },
          child: Text(
            '\$$myPoint',
            style: TextStyle(color: Color(0xff070707)),
          ),
          backgroundColor: Color(0xff89F489),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        width: 91,
        height: MediaQuery.of(context).size.height,
        child: Drawer(
          child: Container(
            padding: EdgeInsets.only(top: 10),
            color: Color(0xffFF6077),
            child: ListView(
              children: <Widget>[
                drawerItem1(
                  url: 'images/Nike-Logo.png',
                  name: 'nike',
                ),
                drawerItem1(
                  url: 'images/580b57fcd9996e24bc43c4f2.png',
                  name: 'adidas',
                ),
                drawerItem1(
                  url: 'images/1200px-Vans_company_logo.svg.png',
                  name: 'vans',
                ),
                drawerItem1(
                  url:
                      'images/kisspng-logo-converse-brand-chuck-taylor-all-stars-sneaker-converse-magic-sneaker-5b8b0324f400d2.5545997715358369649995.png',
                  name: 'converse',
                ),
                drawerItem1(
                  url: 'images/Puma-Logo.png',
                  name: 'puma',
                ),
                drawerItem1(
                  url:
                      'images/kisspng-new-balance-logo-brand-clothing-font-5b203ef4248c85.9376642715288399241497.png',
                  name: 'new balance',
                ),
                drawerItem1(
                  url: 'images/1200px-Under_armour_logo.svg.png',
                  name: 'under armour',
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: createFloatingActionButton(),
      backgroundColor: Color(0xffF7F7F7),
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: getList(data),
            ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  DrawerItem({this.url, this.name});
  final String url;
  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.only(right: 10, left: 10, bottom: 24),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: Color(0xffFF4B66),
          image: DecorationImage(
            image: AssetImage(url),
          ),
        ),
      ),
    );
  }
}
