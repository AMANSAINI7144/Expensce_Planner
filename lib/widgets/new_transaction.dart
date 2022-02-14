import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;

  NewTransaction(this.addtx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  void submitData() {
    final enteredtitle = titlecontroller.text;
    final enteredAmount = amountcontroller.text;

    if (enteredtitle.isEmpty ||
        enteredAmount.isEmpty ||
        double.parse(enteredAmount) < 0) {
      return;
    }
    widget.addtx(
      enteredtitle,
      double.parse(enteredAmount),
    );
    Navigator.of(context).pop();
  }

  final titlecontroller = TextEditingController();
  final amountcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: "Title",
              ),
              onSubmitted: (_) => submitData(),
              controller: titlecontroller,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Amount",
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              controller: amountcontroller,
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Text('No Date Chosen!'),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                        'Chose One',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: submitData,
              child: Text(
                "Add Transaction",
              ),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
    ;
  }
}
