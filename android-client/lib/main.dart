import 'package:flutter/material.dart';
import 'widgets/opencongopayapp.dart';
import 'services/Telemetry/telemetry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Telemetry.instance.init();
  runApp(const OpenCongoPayApp());
}
