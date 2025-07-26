import 'package:flutter/material.dart';
import 'package:opencongopay/models/smspattern.dart';
import 'package:opencongopay/services/SmsListener/patterns.dart';
import 'package:opencongopay/widgets/pattern_editor.dart';

class PatternListPage extends StatefulWidget {
  const PatternListPage({super.key});

  @override
  State<PatternListPage> createState() => _PatternListPageState();
}

class _PatternListPageState extends State<PatternListPage> {
  final _repo = PatternRepository();
  List<SmsPattern> _patterns = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final data = await _repo.load();
    setState(() => _patterns = data);
  }

  Future<void> _add() async {
    final pattern = await Navigator.of(context)
        .push<SmsPattern>(MaterialPageRoute(builder: (_) => const PatternEditorPage()));
    if (pattern != null) {
      final updated = [..._patterns, pattern];
      await _repo.save(updated);
      setState(() => _patterns = updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SMS Patterns')),
      body: ListView.builder(
        itemCount: _patterns.length,
        itemBuilder: (_, i) => ListTile(
          title: Text(_patterns[i].source),
          subtitle: Text(_patterns[i].regex),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        child: const Icon(Icons.add),
      ),
    );
  }
}
