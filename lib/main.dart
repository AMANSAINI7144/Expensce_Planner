import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widgets/user_transaction.dart';

void main() {
  runApp(ExpencePlannerHomePage());
}

class ExpencePlannerHomePage extends StatelessWidget {
  // String titleInput;
  // String amountInput;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter App"),
        ),
        body: SingleChildScrollView(
          // added to add the scrolling function and overcoming the problem of overflowed pixels
          // single child scrollview can be added in while page or at any small peice of page eg ;- in some container of list .
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                // margin: EdgeInsets.only(bottom: 100),
                width: double.infinity, // as much as he can take
                child: Card(
                  // card by default depends upon the size of child unless they itself having a parent
                  color: Colors.indigoAccent,
                  child: Text(
                    "For CHART",
                    style: TextStyle(fontSize: 20),
                  ),
                  elevation: 20, //this is used for the shadow of the card
                ),
              ),
              //A card in Flutter is in rounded corner shape and has a shadow. We mainly used it to store the content and action of a single object.
              UserTransaction(),
            ],
          ),
        ),
      ),
    );
  }
}
