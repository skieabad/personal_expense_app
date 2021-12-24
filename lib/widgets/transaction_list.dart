import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:personalexpense_app/models/transaction.dart';
import 'package:personalexpense_app/widgets/transaction_item.dart';

// ignore: use_key_in_widget_constructors
// ignore: must_be_immutable
class TransactionList extends StatelessWidget {
  List<Transaction> usertransactions = [];
  final Function deletetransactions;

  TransactionList(this.usertransactions, this.deletetransactions);

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return usertransactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    height: constraints.maxHeight * 0.7,
                    child: Image.asset(
                      'assets/sad.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'No transaction added',
                  style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            );
          })
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
                child: RichText(
                  text: const TextSpan(
                    text: 'List of ',
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 2,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: 'expenses',
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 2,
                          color: Colors.indigoAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: usertransactions
                      .map(
                        (e) => TransactionItem(
                            key: ValueKey(e.id),
                            usertransactions: e,
                            deleteTransactions: deletetransactions),
                      )
                      .toList(),
                ),
              ),
            ],
          );
  }
}
