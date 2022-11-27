import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Charts extends StatelessWidget {
  Charts(this.recentTransactions);

  final List<Transaction> recentTransactions;

  double get totalSum {
    return recentTransactions.fold(0.0, (previousValue, element) {
      return previousValue + element.amount;
    });
  }

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final dayOfWeek = DateTime.now().subtract(Duration(days: index));

      double sum = 0.0;

      for (var transaction in recentTransactions) {
        if (transaction.date.year == dayOfWeek.year &&
            transaction.date.month == dayOfWeek.month &&
            transaction.date.day == dayOfWeek.day) {
          sum += transaction.amount;
        }
      }

      return {
        'day': DateFormat.E().format(dayOfWeek), // abreviation for day of week
        'amount': sum, // sum of all amounts for that day
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...groupedTransactionValues.reversed.map((transaction) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: transaction['day'],
                  spendingAmount: transaction['amount'],
                  // change to percentage of max allowed amount
                  spendingPercentOfTotal:
                      totalSum <= 0.0 ? 0.0 : (transaction['amount'] as double) / totalSum,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
