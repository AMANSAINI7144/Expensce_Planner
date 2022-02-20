import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        errorColor: Colors.red,
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

  bool _showChart = false;

  List<Transaction> get recenttransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addNewTransaction(String txtitle, double txamount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txtitle,
      amount: txamount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

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

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
            title: Text(
              "Personal Expenses",
              style: TextStyle(
                fontFamily: 'Opensans',
              ),
            ),
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
          );

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    final recentTxWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: Chart(recenttransaction),
    );

    final pageBody = SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Show Chart',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Switch.adaptive(
                      activeColor: Theme.of(context).accentColor,
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      },
                    ),
                  ],
                ),
              if (!isLandscape)
                Container(
                  height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                      0.3,
                  child: Chart(recenttransaction),
                ),
              if (!isLandscape) txListWidget,
              if (isLandscape) _showChart ? recentTxWidget : txListWidget
            ],
          ),
        ),
    );

    return Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    backgroundColor: Colors.red,
                    onPressed: () => {
                      MyBottomSheet(context),
                    },
                  ),
          );
  }
}
