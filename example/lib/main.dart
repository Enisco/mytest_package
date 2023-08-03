// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:mytest_package/mytest_package.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Korapay',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'Korapay'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final res = await Korapay().initialize(
            secretKey: "sk_test_od3bvdEUj1kMTQM4KAq1MhBrqzPMmPFEZWZgUYq7",
            encryptionKey: "P9EqWkDGApD2FX3jiEUqdXq32zMj6Urp",
            transactionRef:
                "transactionRef-${DateTime.now().toIso8601String()}",
            cardNumber: "5442056106072595", // Otp card
            // cardNumber: "5188513618552975", // Pin card
            // cardNumber: "4084127883172787", // No auth
            cvv: "123",
            expiryMonth: "09",
            expiryYear: "30",
            // pin: '1234',
            amount: 350,
            email: "kpay@gmail.com",
            metadata: "enisco_trial",
            redirectUrl: "https://ktest.com",
          );
          print(">>>>>>>>>>>>>>>>>>>>>>Result: ${res.toString()}");
        },
        tooltip: 'Charge',
        child: const Icon(Icons.add),
      ),
    );
  }
}
