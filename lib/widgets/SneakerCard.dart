import 'dart:ui';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hypelab/home_page.dart';
import 'package:hypelab/constants.dart';

int counter = 10;

class SneakerCard extends StatefulWidget {
  SneakerCard({this.name, this.url, this.price, this.randomNumber});
  final String name;
  final String url;
  final int price;
  final int randomNumber;

  @override
  _SneakerCardState createState() => _SneakerCardState();
}

class _SneakerCardState extends State<SneakerCard> {
  @override
  int onChangedPrice = 10;
  int onSubmittedPrice = 10;
  bool submitted = false;
  int startingValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('this is the random ${widget.randomNumber}');
  }

  incrementCounterTest(String result) {
    if (result == 'perfect') {
      setState(() {
        counter = counter + 10;
      });
    } else if (result == 'close') {
      setState(() {
        counter = counter + 5;
      });
    } else {
      setState(() {
        counter++;
      });
    }

    pointCounter.doc('1000100100').set({
      'points': counter,
    });

    print(counter.toString());
  }

  onChangedStart(double val) {
    setState(() {
      startingValue = val.round();
      submitted = false;
    });
  }

  onChangedEnd(double val) {
    setState(() {
      onSubmittedPrice = val.round();
      submitted = true;
    });
  }

  onSliderChanged(double value) {
    setState(() {
      onChangedPrice = value.round();
    });
  }

  buildReturnText() {
    if (onSubmittedPrice == widget.price) {
      incrementCounterTest('perfect');
      return Text(
        'perfect',
        style: kPerfectReturnTextStyle,
      );
    } else if (onSubmittedPrice <= widget.price &&
        onSubmittedPrice >= widget.price - 10) {
      incrementCounterTest('close');

      return Text(
        'close',
        style: kCloseReturnTextStyle,
      );
    } else if (onSubmittedPrice >= widget.price &&
        onSubmittedPrice <= widget.price + 10) {
      incrementCounterTest('close');

      return Text(
        'close',
        style: kCloseReturnTextStyle,
      );
    } else {
      return Text(
        'the price is ${widget.price}',
        style: kWrongReturnTextStyle,
      );
    }
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        color: Colors.white,
      ),
      height: 528,
      width: 327,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            widget.name,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color(0xff707070),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 39,
          ),
          widget.url == null
              ? Container(
                  width: 200,
                  height: 189,
                  child: Center(
                    child: Text(
                      'could not load image :( ',
                      style: TextStyle(
                        color: Color(0xff707070),
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              : Container(
                  width: 264,
                  height: 189,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.url),
                    ),
                  ),
                ),
          SizedBox(
            height: 39,
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Color(0xffFF6077),
              inactiveTrackColor: Colors.red[100],
              thumbColor: Color(0xffFF6077),
              trackHeight: 12,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 10.0),
              overlappingShapeStrokeColor: Color(0xffFF6077),
              disabledActiveTrackColor: Color(0xffFF6077),
              disabledInactiveTrackColor: Colors.red[100],
              disabledThumbColor: Color(0xffFF6077),
            ),
            child: Slider(
              onChangeStart: onChangedStart,
              onChangeEnd: onChangedEnd,
              value: onChangedPrice.toDouble(),
              min: 10,
              max: widget.price.toDouble() + widget.randomNumber.toDouble(),
              onChanged: submitted ? null : onSliderChanged,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '\$${onChangedPrice.toString()}',
            style: TextStyle(
              color: Color(0xffFF6077),
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          submitted ? buildReturnText() : Text(''),
        ],
      ),
    );
  }
}
