import 'package:flutter/material.dart';

class RegexBuilderPage extends StatefulWidget {
  const RegexBuilderPage({super.key});

  @override
  State<RegexBuilderPage> createState() => _RegexBuilderPageState();
}

class _RegexBuilderPageState extends State<RegexBuilderPage> {
  final _sms = TextEditingController();
  final _amount = TextEditingController();
  final _phone = TextEditingController();
  final _balance = TextEditingController();
  final _reference = TextEditingController();
  String _regex = '';

  void _generate() {
    var pattern = _sms.text;
    if (_amount.text.isNotEmpty) {
      pattern = pattern.replaceFirst(_amount.text, r'(\\d+(?:\\.\\d+)?)');
    }
    if (_phone.text.isNotEmpty) {
      pattern = pattern.replaceFirst(_phone.text, r'(\\d+)');
    }
    if (_balance.text.isNotEmpty) {
      pattern = pattern.replaceFirst(_balance.text, r'(\\d+(?:\\.\\d+)?)');
    }
    if (_reference.text.isNotEmpty) {
      pattern = pattern.replaceFirst(_reference.text, r'(\\S+)');
    }
    setState(() => _regex = pattern);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Regex Builder')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _sms, decoration: const InputDecoration(labelText: 'SMS exemple')),
            TextField(controller: _amount, decoration: const InputDecoration(labelText: 'Montant')),
            TextField(controller: _phone, decoration: const InputDecoration(labelText: 'Numéro')),
            TextField(controller: _balance, decoration: const InputDecoration(labelText: 'Solde')),
            TextField(controller: _reference, decoration: const InputDecoration(labelText: 'Référence')),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _generate, child: const Text('Générer')),
            const SizedBox(height: 16),
            SelectableText(_regex),
            const Spacer(),
            ElevatedButton(
              onPressed: _regex.isEmpty ? null : () => Navigator.of(context).pop(_regex),
              child: const Text('Utiliser ce regex'),
            )
          ],
        ),
      ),
    );
  }
}
