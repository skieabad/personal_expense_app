import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personalexpense_app/models/transaction.dart';
import 'package:personalexpense_app/widgets/chart_bar.dart';

// ignore: use_key_in_widget_constructors
class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalAmount = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalAmount += recentTransactions[i].amount;
        }
      }

      // // for testing
      // print(DateFormat.E().format(weekDay));
      // print(totalAmount);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount
      };
    }).reversed.toList();
  }

  double get totalSpend {
    return groupedTransactionValues.fold(0.0, (total, item) {
      return total + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 8, 4, 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  e['day'],
                  e['amount'],
                  totalSpend == 0.0
                      ? 0.0
                      : (e['amount'] as double) / totalSpend),
            );
          }).toList(),
        ),
      ),
    );
  }
}
