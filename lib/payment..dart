import 'dart:math';
import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';
import 'package:upi_india/upi_response.dart';
import 'components.dart';

var random = Random();

var _char =
    'ahgHTjhtfnjrfvjhT578hjgfhggAFGjghfhgdhfghdgfrf64yt754fhJHGHFbhgdcdt465646tfgd4tf74gfgyFHDVF53586gHFGE';
String getString(int length) {
  return String.fromCharCodes(Iterable.generate(
      length, (_) => _char.codeUnitAt(random.nextInt(_char.length))));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<UpiResponse>? _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: 'onefarmer@icici',
      receiverName: 'ONEFARMER',
      transactionRefId: getString(15),
      merchantId: 'BCR2DN6TY6QLX7YB',
      amount: amount,
    );
  }

  Widget displayUpiApps() {
    if (apps == null)
      return Center(child: CircularProgressIndicator());
    else if (apps!.length == 0)
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: header,
        ),
      );
    else
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () {
                  _transaction = initiateTransaction(app);
                  setState(() {});
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: Column(
                    children: <Widget>[
                      Image.memory(
                        app.icon,
                        height: 60,
                        width: 60,
                      ),
                      Text(app.name),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('PAY USING'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: displayUpiApps(),
          ),
          Expanded(
            child: FutureBuilder(
              future: _transaction,
              builder:
                  (BuildContext context, AsyncSnapshot<UpiResponse> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'ERROR OCCURED',
                        style: header,
                      ), // Print's text message on screen
                    );
                  }

                  UpiResponse _upiResponse = snapshot.data!;

                  String status =
                      _upiResponse.status ?? 'THERE IS NO DATA FOUND';

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        displayTransactionData('Status', status.toUpperCase()),
                      ],
                    ),
                  );
                } else
                  return Center(
                    child: Text('SELECT YOUR UPI APP'),
                  );
              },
            ),
          )
        ],
      ),
    );
  }
}
