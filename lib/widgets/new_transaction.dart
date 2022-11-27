import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction({this.addTransaction});

  final Function addTransaction;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // String amountInput;
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _transactionDate;

  void _submitData() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text);

    if (title.isNotEmpty && amount != null && amount > 0) {
      widget.addTransaction(
        title: title,
        amount: amount,
        date: _transactionDate,
      );

      Navigator.of(context)..pop();
    }
  }

  void showDatePickerDialog() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
      confirmText: 'OK',
      cancelText: 'Cancel',
    ).then((value) {
      if (value != null) {
        setState(() => _transactionDate = value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Transaction title',
                  ),
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                  // onChanged: (value) => titleInput = value,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Amount',
                  ),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _submitData(),
                ),
                Container(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _transactionDate == null
                            ? 'No date selected.'
                            : 'Picked date: ${DateFormat('dd. MMM. yyyy.').format(_transactionDate)}',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      SizedBox(width: 15),
                      TextButton(
                        child: Text(
                          'Choose date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: showDatePickerDialog,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _submitData,
                  child: Text('Add transaction'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
