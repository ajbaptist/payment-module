import 'package:flutter/material.dart';
import 'package:upi/amount.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.teal, primarySwatch: Colors.teal),
      debugShowCheckedModeBanner: false,
      home: AmountMain(),
    );
  }
}
