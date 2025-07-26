import 'package:flutter/material.dart';
import 'package:opencongopay/widgets/login.dart';
import 'package:opencongopay/widgets/pattern_list.dart';

class OpenCongoPayApp extends StatefulWidget {
  const OpenCongoPayApp({super.key});

  @override
  State<OpenCongoPayApp> createState() => _OpenCongoPayAppState();
}

class _OpenCongoPayAppState extends State<OpenCongoPayApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Open Congo Pay",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(child: const PatternListPage()),
    );
  }
}

