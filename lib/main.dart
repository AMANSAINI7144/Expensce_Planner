import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widgets/user_transaction.dart';

void main() {
  runApp(ExpencePlannerHomePage());
}

class ExpencePlannerHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter App"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Card(
                  color: Colors.blue,
                  child: Text(
                    "For CHART",
                    style: TextStyle(
                        fontSize: 20,
                    ),
                  ),
                  elevation: 20,
                ),
              ),
              UserTransaction(),
            ],
          ),
        ),
      ),
    );
  }
}
