import 'package:flutter/material.dart';
import 'package:opencongopay/models/smspattern.dart';
import 'package:opencongopay/widgets/regex_builder.dart';

class PatternEditorPage extends StatefulWidget {
  const PatternEditorPage({super.key});

  @override
  State<PatternEditorPage> createState() => _PatternEditorPageState();
}

class _PatternEditorPageState extends State<PatternEditorPage> {
  final _source = TextEditingController();
  final _regex = TextEditingController();

  void _buildWithHelper() async {
    final result = await Navigator.of(context)
        .push<String>(MaterialPageRoute(builder: (_) => const RegexBuilderPage()));
    if (result != null) {
      _regex.text = result;
    }
  }

  void _save() {
    if (_source.text.isNotEmpty && _regex.text.isNotEmpty) {
      Navigator.of(context).pop(SmsPattern(source: _source.text, regex: _regex.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un pattern')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _source, decoration: const InputDecoration(labelText: 'Source')),
            TextField(controller: _regex, decoration: const InputDecoration(labelText: 'Regex')),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _buildWithHelper, child: const Text('Construire depuis un SMS')),
            const Spacer(),
            ElevatedButton(onPressed: _save, child: const Text('Enregistrer')),
          ],
        ),
      ),
    );
  }
}
