import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 10,
      ),
      child: ListTile(
        // leading: CircleAvatar(
        //   radius: 22,
        //   child: Padding(
        //     padding: const EdgeInsets.all(4.0),
        //     child: FittedBox(
        //       child: Text(transaction.amount.toStringAsFixed(2)),
        //     ),
        //   ),
        // ),
        leading: Container(
          width: 75,
          height: 40,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: FittedBox(
            child: Text(
              '\$${transaction.amount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headline6.copyWith(
                    fontSize: 17,
                    color: Colors.white,
                  ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('E, dd. MMMM yyyy.').format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 450
            ? TextButton.icon(
                onPressed: () => deleteTransaction(transaction),
                icon: const Icon(Icons.delete_forever_rounded),
                label: const Text('Remove'),
                style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(
                    Theme.of(context).errorColor,
                  ),
                ),
              )
            : IconButton(
                onPressed: () => deleteTransaction(transaction),
                icon: Icon(
                  Icons.delete_forever_rounded,
                  color: Theme.of(context).errorColor,
                ),
              ),
      ),
      // child: Row(
      //   children: [
      //     // Amount
      //     Container(
      //       margin: EdgeInsets.all(10),
      //       padding: EdgeInsets.all(10),
      //       decoration: BoxDecoration(
      //         color: Colors.green,
      //         borderRadius: BorderRadius.all(Radius.circular(10)),
      //       ),
      //       child: Text(
      //         '\$${transaction.amount.toStringAsFixed(2)}',
      //         style: TextStyle(
      //           fontSize: 17,
      //           fontWeight: FontWeight.w700,
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //     // Title & Date
      //     Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text(
      //           transaction.title,
      //           style: TextStyle(
      //             fontSize: 17,
      //             fontWeight: FontWeight.w600,
      //           ),
      //         ),
      //         Text(
      //           DateFormat('E, dd. MMMM yyyy.')
      //               .format(transaction.date),
      //           style: TextStyle(
      //             fontSize: 15,
      //             fontWeight: FontWeight.w400,
      //             color: Color.fromARGB(255, 175, 175, 175),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}
