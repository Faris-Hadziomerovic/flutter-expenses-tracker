import 'package:flutter/material.dart';

import 'no_transactions_found.dart';
import 'transaction_list_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? const NoTransactionsFound()
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final transaction = transactions[transactions.length - 1 - index];
                return TransactionListItem(
                  key: ValueKey(transaction.id),
                  transaction: transaction,
                  deleteTransaction: deleteTransaction,
                );
              },
            ),
      // : ListView(
      //     children: transactions.reversed.map((transaction) {
      //       return TransactionListItem(
      //         key: ValueKey(transaction.id),
      //         transaction: transaction,
      //         deleteTransaction: deleteTransaction,
      //       );
      //     }).toList(),
      //   ),
    );
  }
}
