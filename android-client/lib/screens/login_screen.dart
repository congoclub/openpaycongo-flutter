import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class LoginScreen extends StatefulWidget {
  final Widget child;
  const LoginScreen({super.key, required this.child});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _authenticated = false;

  Future<void> _check() async {
    try {
      final ok = await auth.authenticate(localizedReason: 'Authentifiez-vous');
      if (ok) setState(() => _authenticated = true);
    } catch (_) {
      // ignore
    }
  }

  @override
  void initState() {
    super.initState();
    _check();
  }

  @override
  Widget build(BuildContext context) {
    if (_authenticated) return widget.child;
    return Scaffold(
      appBar: AppBar(title: const Text('Authentification')),
      body: Center(
        child: ElevatedButton(onPressed: _check, child: const Text('Se connecter')),
      ),
    );
  }
}
