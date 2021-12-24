import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double percentageOfSpending;

  // using positional arguments
  ChartBar(this.label, this.spendingAmount, this.percentageOfSpending);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            //spending
            Container(
              height: constraints.maxHeight * 0.12,
              child: FittedBox(
                child: Text(
                  '₱${spendingAmount.toStringAsFixed(0)}',
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.07,
            ),
            // ignore: sized_box_for_whitespace
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentageOfSpending,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(height: constraints.maxHeight * 0.15, child: Text(label)),
          ],
        );
      },
    );
  }
}
