import 'package:flutter/material.dart';
import '../models/server_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/config_bloc.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  final _domainCtrl = TextEditingController();
  final _apiCtrl = TextEditingController();
  final _hmacCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ConfigBloc>().add(LoadConfig());
  }

  Future<void> _save() async {
    final c = ServerConfig(
      domain: _domainCtrl.text,
      apiKey: _apiCtrl.text,
      hmacKey: _hmacCtrl.text,
    );
    context.read<ConfigBloc>().add(SaveConfig(c));
    if (context.mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConfigBloc, ConfigState>(
      listener: (context, state) {
        if (state is ConfigLoaded) {
          _domainCtrl.text = state.config.domain;
          _apiCtrl.text = state.config.apiKey;
          _hmacCtrl.text = state.config.hmacKey;
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Configuration')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(controller: _domainCtrl, decoration: const InputDecoration(labelText: 'Domaine')),
              TextField(controller: _apiCtrl, decoration: const InputDecoration(labelText: 'API Key')),
              TextField(controller: _hmacCtrl, decoration: const InputDecoration(labelText: 'HMAC Secret')),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _save, child: const Text('Enregistrer')),
            ],
          ),
        ),
      ),
    );
  }
}
