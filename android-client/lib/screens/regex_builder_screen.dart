import 'package:flutter/material.dart';

class RegexBuilderScreen extends StatefulWidget {
  const RegexBuilderScreen({super.key});

  @override
  State<RegexBuilderScreen> createState() => _RegexBuilderScreenState();
}

class _RegexBuilderScreenState extends State<RegexBuilderScreen> {
  final smsCtrl = TextEditingController();
  final regexCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Constructeur Regex')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(controller: smsCtrl, maxLines: 3, decoration: const InputDecoration(labelText: 'Exemple SMS')),
          const SizedBox(height: 8),
          TextField(controller: regexCtrl, decoration: const InputDecoration(labelText: 'Regex résultant')),
          const SizedBox(height: 8),
          Text('Entrez un SMS et écrivez la regex correspondante. Cette page est un modèle simplifié.'),
        ]),
      ),
    );
  }
}
