import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class LoginPage extends StatefulWidget {
  final Widget child;
  const LoginPage({super.key, required this.child});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LocalAuthentication _auth = LocalAuthentication();
  bool _authorized = false;

  Future<void> _authenticate() async {
    try {
      final available = await _auth.canCheckBiometrics;
      if (!available) {
        setState(() => _authorized = true);
        return;
      }
      final ok = await _auth.authenticate(localizedReason: 'Déverrouiller');
      setState(() => _authorized = ok);
    } catch (_) {
      setState(() => _authorized = true);
    }
  }

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  @override
  Widget build(BuildContext context) {
    if (!_authorized) {
      return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: _authenticate,
            child: const Text('Déverrouiller'),
          ),
        ),
      );
    }
    return widget.child;
  }
}
