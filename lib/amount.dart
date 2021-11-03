import 'package:flutter/material.dart';
import 'package:upi/components.dart';
import 'package:upi/payment..dart';

class AmountMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.teal, primarySwatch: Colors.teal),
      debugShowCheckedModeBanner: false,
      home: Amount(),
    );
  }
}

class Amount extends StatefulWidget {
  @override
  _AmountState createState() => _AmountState();
}

class _AmountState extends State<Amount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
        },
        child: Icon(Icons.forward),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('UPI PAYMENT APP'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              autofocus: true,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  amount = double.parse(value);
                  print(amount);
                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'ENTER THE AMOUNT',
                  labelText: 'AMOUNT',
                  helperText: 'AMOUNT SHOULD BE >0'),
            ),
          ],
        ),
      ),
    );
  }
}
