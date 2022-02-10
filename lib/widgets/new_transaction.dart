import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addtx;
  final titlecontroller = TextEditingController();
  final amountcontroller = TextEditingController();

  NewTransaction(this.addtx);

  void submitData() {
    final enteredTitle = titlecontroller.text;
    final enteredAmount = double.parse(amountcontroller.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0){
      return ;
    }

    addtx(
      titlecontroller.text,
      double.parse(amountcontroller.text),
    );
  }

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
              controller: titlecontroller,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Amount",
              ),
              controller: amountcontroller,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
              onPressed: submitData,
              child: Text(
                "Add Transaction",
                style: TextStyle(
                    color: Colors.purple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
