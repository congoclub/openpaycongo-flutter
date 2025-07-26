import 'dart:developer' as dev;
import 'package:telephony/telephony.dart';
import 'package:opencongopay/models/paymentdetail.dart';
import 'package:opencongopay/models/smspattern.dart';
import 'package:opencongopay/services/SmsListener/patterns.dart';

class SmsParser {
  final Telephony _telephony = Telephony.instance;
  final PatternRepository _repo = PatternRepository();
  List<SmsPattern> _patterns = const [];

  Future<void> initialize() async {
    final bool? allowed = await _telephony.requestSmsPermissions;
    if (allowed == true) {
      _log('SMS permissions granted');
      _patterns = await _repo.load();
      _telephony.listenIncomingSms(
        onNewMessage: _backgroundMessageHandler,
        onBackgroundMessage: _backgroundMessageHandler,
      );
      _log('SMS listener initialized');
    }
  }

  Future<void> updatePatterns(List<SmsPattern> patterns) async {
    _patterns = patterns;
    await _repo.save(patterns);
  }

  PaymentDetail? tryParse(SmsMessage message) {
    for (final p in _patterns) {
      final reg = RegExp(p.regex);
      final match = reg.firstMatch(message.body ?? '');
      if (match != null && match.groupCount >= 6) {
        return PaymentDetail(
          name: match.group(3) ?? '',
          sender: match.group(4) ?? '',
          amount: match.group(1) ?? '',
          currency: match.group(2) ?? '',
          balance: match.group(5) ?? '',
          reference: match.group(6) ?? '',
        );
      }
    }
    return null;
  }
}

_log(String log) {
  dev.log(log, name: 'SMS Listener');
}

Future<void> _backgroundMessageHandler(SmsMessage message) async {
  final parser = SmsParser();
  parser.initialize();
  final detail = parser.tryParse(message);
  if (detail != null) {
    _log('Parsed transaction from ' + detail.sender);
  } else {
    _log('No pattern matched incoming SMS');
  }
}
