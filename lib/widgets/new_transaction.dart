import 'dart:io';
import '../widgets/adapative_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;

  NewTransaction(this.addtx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();

  DateTime? _selectedDate;

  void _submitData() {
    if (_amountcontroller.text.isEmpty) {
      return;
    }

    final enteredtitle = _titlecontroller.text;
    final enteredAmount = _amountcontroller.text;

    if (enteredtitle.isEmpty ||
        enteredAmount.isEmpty ||
        double.parse(enteredAmount) <= 0 ||
        _selectedDate == null) {
      return;
    }
    widget.addtx(
      enteredtitle,
      double.parse(enteredAmount),
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _percentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                onSubmitted: (_) => _submitData(),
                controller: _titlecontroller,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Amount",
                ),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                controller: _amountcontroller,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Date : ${DateFormat.yMd().format(_selectedDate!)}',
                      ),
                    ),
                    AdaptiveFlatButton('Choose Date', _percentDatePicker),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submitData,
                child: Text(
                  "Add Transaction",
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
