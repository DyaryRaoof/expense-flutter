import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  const NewTransaction(this.addTransaction, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime? _date;

  void submitData() {
    String title = _titleController.text;
    String price = _priceController.text;

    if (title.isNotEmpty && price.isNotEmpty && _date != null) {
      double amount = double.parse(_priceController.text);
      if (!amount.isNegative) {
        widget.addTransaction(title, double.parse(amount.toStringAsFixed(2)), _date);
        Navigator.of(context).pop();
      }
    }
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
    ).then((dateReceived) {
      if (dateReceived == null) {
        return;
      }
      setState(() {
        _date = dateReceived;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(hintText: 'Title'),
            controller: _titleController,
            onSubmitted: (_) => submitData(),
          ),
          TextField(
            decoration: const InputDecoration(hintText: 'Price'),
            controller: _priceController,
            onSubmitted: (_) => submitData(),
            keyboardType: TextInputType.number,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextButton(
                onPressed: _presentDatePicker,
                child: Text(
                  _date == null
                      ? 'No Date Chosen'
                      : DateFormat.yMd().format(_date!).toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: _presentDatePicker,
                child: const Text(
                  'Select Date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
                onPressed: submitData, child: const Text('Add Transaction')),
          )
        ],
      ),
    );
  }
}
