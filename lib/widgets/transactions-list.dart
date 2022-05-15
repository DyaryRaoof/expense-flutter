import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatefulWidget {
  final List<Transaction> transactions;

  const TransactionsList(this.transactions, {Key? key}) : super(key: key);

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  void _deleteTransaction(id){
    setState(() {
      widget.transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          child: ListTile(
            dense: false,
            leading: CircleAvatar(
              radius: 30,
              child: Text(
                '\$${widget.transactions[index].amount.toString()}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
            title: Text(
              widget.transactions[index].title,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(widget.transactions[index].date),
            ),
            trailing: IconButton(icon: const Icon(Icons.delete), color: Colors.red, onPressed: () => _deleteTransaction(widget.transactions[index].id),),
          ),
        );
      },
      itemCount: widget.transactions.length,
    );
  }
}
