import 'package:flutter/material.dart';
import '../models/parser_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/parser_bloc.dart';

class ParsersScreen extends StatefulWidget {
  const ParsersScreen({super.key});

  @override
  State<ParsersScreen> createState() => _ParsersScreenState();
}

class _ParsersScreenState extends State<ParsersScreen> {
  List<ParserSource> parsers = [];

  @override
  void initState() {
    super.initState();
    context.read<ParserBloc>().add(LoadParsers());
  }

  Future<void> _add() async {
    final nameCtrl = TextEditingController();
    final regexCtrl = TextEditingController();
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Ajouter une source'),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Nom')),
                TextField(controller: regexCtrl, decoration: const InputDecoration(labelText: 'Regex')),
              ]),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
                TextButton(
                    onPressed: () async {
                      context.read<ParserBloc>().add(AddParser(nameCtrl.text, regexCtrl.text));
                      Navigator.pop(context);
                    },
                    child: const Text('OK')),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ParserBloc, ParserState>(
      listener: (context, state) {
        if (state is ParserLoaded) setState(() => parsers = state.parsers);
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Sources SMS'), actions: [
          IconButton(onPressed: _add, icon: const Icon(Icons.add))
        ]),
        body: ListView.builder(
          itemCount: parsers.length,
          itemBuilder: (context, index) {
            final p = parsers[index];
            return ListTile(title: Text(p.name), subtitle: Text(p.regex));
          },
        ),
      ),
    );
  }
}
