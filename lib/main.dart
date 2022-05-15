import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widgets/transactions-list.dart';
import './widgets/new-transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense',
      theme: ThemeData(primarySwatch: Colors.purple, fontFamily: 'Quicksand'),
      home: MyHomePage(title: 'Expense'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [];

  void addNewTransaction(title, amount, selectedDate) {
    var transaction = Transaction(
      title: title,
      amount: amount,
      date: selectedDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      transactions.add(transaction);
    });
  }

  void showBottomSheetNow(ctx) => {
        showModalBottomSheet(
            context: ctx,
            builder: (bCTX) {
              return NewTransaction(addNewTransaction);
            })
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () => showBottomSheetNow(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: transactions.isNotEmpty
          ? TransactionsList(transactions)
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'No Transaction Added Yet, Add one!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  Image.asset('assets/images/waiting.png'),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => {showBottomSheetNow(context)}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
