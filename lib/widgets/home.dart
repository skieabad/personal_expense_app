import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personalexpense_app/models/transaction.dart';
import 'package:personalexpense_app/widgets/chart.dart';
import 'package:personalexpense_app/widgets/new_transaction.dart';
import 'package:personalexpense_app/widgets/transaction_list.dart';

import 'greetings.dart';

// ignore: use_key_in_widget_constructors
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'Monday Expense',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Tuesday Expense',
    //   amount: 70.99,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  // ignore: unused_element
  void _addNewTransactions(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newtxTransact = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(newtxTransact);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransactions),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  List<Widget> _buildLandScapeContent(
      MediaQueryData mediaQuery, Widget transactionlist) {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            const Text('Show chart'),
            Switch(
                value: _showChart,
                onChanged: (val) {
                  setState(() {
                    _showChart = val;
                  });
                }),
          ],
        ),
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.6,
              child: Chart(_recentTransactions),
            )
          : transactionlist
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, Widget transactionlist) {
    // two arguments
    return [
      Container(
        height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.25,
        child: Chart(_recentTransactions),
      ),
      transactionlist
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final transactionlist = Container(
      height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.6,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Greetings(),
              if (isLandscape)
                ..._buildLandScapeContent(mediaQuery, transactionlist),
              if (!isLandscape)
                ..._buildPortraitContent(mediaQuery, transactionlist),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _startAddNewTransaction(context),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
