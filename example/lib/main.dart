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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String res = Korapay().initialize(
            authorization: Authorization.pin,
            encryptionKey: "P9EqWkDGApD2FX3jiEUqdXq32zMj6Urp",
            transactionRef: "transactionRef",
            cardNumber: "cardNumber",
            cvv: "cvv",
            pin: 1234,
            expiryMonth: "expiryMonth",
            expiryYear: "expiryYear",
            amount: 679,
            metadata: "metadata",
          );
          print("Result: $res");
          Korapay().charge();
        },
        tooltip: 'Charge',
        child: const Icon(Icons.add),
      ),
    );
  }
}
