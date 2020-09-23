import 'package:flutter/material.dart';

class WardrobePage extends StatefulWidget {
  @override
  _WardrobePageState createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xff89F489), size: 30),
        backgroundColor: Color(0xffF7F7F7),
        elevation: 0.0,
        title: Text(
          'Wardrobe',
          style: TextStyle(
            fontSize: 57,
            color: Color(0xff707070),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    WardrobeItem(),
                    WardrobeItem(),
                    WardrobeItem(),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    WardrobeItem(),
                    WardrobeItem(),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class WardrobeItem extends StatelessWidget {
  const WardrobeItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30.0),
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Center(
        child: Icon(
          Icons.add,
          size: 150,
          color: Color(0xffF7F7F7),
        ),
      ),
    );
  }
}
