import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:personalexpense_app/models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.usertransactions,
    @required this.deleteTransactions,
  }) : super(key: key);

  final Transaction usertransactions;
  final Function deleteTransactions;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color randomBorderColors;

  @override
  void initState() {
    const listofColors = [
      Colors.black,
      Colors.indigoAccent,
      Colors.blue,
      Colors.amber,
    ];

    randomBorderColors = listofColors[Random().nextInt(4)];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                border: Border.all(width: 2, color: randomBorderColors),
              ),
              padding: const EdgeInsets.fromLTRB(6, 10, 6, 10),
              child: Text(
                '₱${widget.usertransactions.amount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 4, top: 6),
              child: Text(
                widget.usertransactions.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                DateFormat.yMEd().format(widget.usertransactions.date),
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
            trailing: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: MediaQuery.of(context).size.width > 460
                    ? TextButton.icon(
                        style: TextButton.styleFrom(
                          primary: Colors.indigoAccent,
                        ),
                        onPressed: () => widget
                            .deleteTransactions(widget.usertransactions.id),
                        icon: const Icon(Icons.delete),
                        label: const Text('delete'),
                      )
                    : IconButton(
                        color: Colors.indigoAccent,
                        icon: const Icon(Icons.delete),
                        onPressed: () => widget
                            .deleteTransactions(widget.usertransactions.id),
                      )),
          ),
        ),
      ],
    );
  }
}
