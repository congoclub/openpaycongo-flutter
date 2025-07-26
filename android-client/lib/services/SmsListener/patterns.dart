import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/smspattern.dart';

class PatternRepository {
  static const _key = 'sms_patterns';

  Future<List<SmsPattern>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? <String>[];
    return data
        .map((e) => SmsPattern.fromMap(jsonDecode(e) as Map<String, dynamic>))
        .toList();
  }

  Future<void> save(List<SmsPattern> patterns) async {
    final prefs = await SharedPreferences.getInstance();
    final list = patterns.map((e) => jsonEncode(e.toMap())).toList();
    await prefs.setStringList(_key, list);
  }
}
