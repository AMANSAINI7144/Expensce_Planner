import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/transaction_list.dart';
import 'widgets/new_transaction.dart';
import 'widgets/chart.dart';
import 'models/transaction.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Personal Expenses",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: TextStyle(
                fontFamily: 'Opensans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              /*
              button: TextStyle(
                color: Colors.white,
              ),
              */
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontFamily: 'Opensans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: Tracking(),
    );
  }
}

class Tracking extends StatefulWidget {
  @override
  TrackingState createState() => TrackingState();
}

class TrackingState extends State<Tracking> {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get recenttransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addNewTransaction(String txtitle, double txamount) {
    final newTx = Transaction(
        title: txtitle,
        amount: txamount,
        date: DateTime.now(),
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void MyBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (MyContext) {
          return GestureDetector(
            onTap: () => {},
            child: NewTransaction(addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Expenses",
            style: TextStyle(
              fontFamily: 'Opensans',
            )),
        actions: <Widget>[
          IconButton(
            onPressed: () => {
              showModalBottomSheet(
                  context: context,
                  builder: (MyContext) {
                    return Container(
                      child: NewTransaction(addNewTransaction),
                    );
                  })
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () => {},
            icon: Icon(Icons.add_a_photo_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Chart(recenttransaction),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        onPressed: () => {
          MyBottomSheet(context),
        },
      ),
    );
  }
}
