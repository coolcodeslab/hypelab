import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Points {
  final int points;
  Points({this.points});

  factory Points.fromDocument(DocumentSnapshot doc) {
    return Points(
      points: doc.get('points'),
    );
  }
}
