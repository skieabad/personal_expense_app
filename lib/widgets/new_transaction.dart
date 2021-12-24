import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: use_key_in_widget_constructors
class NewTransaction extends StatefulWidget {
  final Function nxTxt;
  // ignore: use_key_in_widget_constructors
  // ignore: prefer_const_constructors_in_immutables
  NewTransaction(this.nxTxt);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final submitTitleController = _titleController.text;
    final submitAmountController = double.parse(_amountController.text);

    if (submitTitleController.isEmpty ||
        submitAmountController <= 0 ||
        _selectedDate == null) {
      return;
    }

    widget.nxTxt(submitTitleController, submitAmountController, _selectedDate);

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((context) {
      if (context == null) {
        return;
      } else {
        setState(() {
          _selectedDate = context;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          margin: EdgeInsets.only(
              left: 10,
              top: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
                onSubmitted: (_) => _submitData(),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: _selectedDate == null
                        ? const TextSpan(
                            text: 'No chosen date',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          )
                        : TextSpan(
                            text:
                                'Chosen Date: ${DateFormat.yMd().format(_selectedDate)}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.indigo,
                    ),
                    onPressed: _showDatePicker,
                    child: const Text('Choose Date'),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigoAccent,
                  onPrimary: Colors.white,
                ),
                onPressed: _submitData,
                child: const Text('Add a Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
