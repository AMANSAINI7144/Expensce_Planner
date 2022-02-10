import 'package:flutter/material.dart';
import 'transaction_list.dart';
import 'new_transaction.dart';
import '/models/transaction.dart';

class UserTransaction extends StatefulWidget {

  @override
  _UserTransactionState createState() => _UserTransactionState();

}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> my_transaction_list = [
    Transaction(
        id: 't1',
        amount: 69.099,
        date: DateTime.now(),
        title: "New shoes",
    ),
    Transaction(
        id: 't2',
        amount: 63.099,
        date: DateTime.now(),
        title: "New bag",
    ),
    /*
    // Transaction(
    //     id: 't3',
    //     amount: 16.099,
    //     date: DateTime.now(),
    //     title: "New phone",
    // ),
    // Transaction(
    //     id: 't4',
    //     amount: 89.099,
    //     date: DateTime.now(),
    //     title: "New Grocceries",
    // ),
    */
  ];

  void _addNewTransaction(String txtitle, double txamount) {
    final newTx = Transaction(
        title: txtitle,
        amount: txamount,
        date: DateTime.now(),
        id: DateTime.now().toString());
    setState(() {
      my_transaction_list.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        ourtransactions_list(my_transaction_list),
      ],
    );
  }
}
