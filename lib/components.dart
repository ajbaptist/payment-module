import 'package:flutter/material.dart';

double amount = 1;

TextStyle header = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

TextStyle value = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
);

Widget displayTransactionData(title, body) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$title: ".toUpperCase(), style: header),
        Flexible(
            child: Text(
          body,
          style: value,
        )),
      ],
    ),
  );
}
