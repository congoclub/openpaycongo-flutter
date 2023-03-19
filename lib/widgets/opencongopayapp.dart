import 'package:flutter/material.dart';

class OpenCongoPayApp extends StatefulWidget {
  const OpenCongoPayApp({super.key});

  @override
  State<OpenCongoPayApp> createState() => _OpenCongoPayAppState();
}

class _OpenCongoPayAppState extends State<OpenCongoPayApp> {
  int item = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Open Congo Pay',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Open Congo Pay'),
            backgroundColor: Colors.blue,
          ),
          body: ListView.builder(
            itemBuilder: (_, index) {
              return Text('Item $index');
            },
            addAutomaticKeepAlives: false,
          ),
        ));
  }
}
