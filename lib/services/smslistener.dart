import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:telephony/telephony.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:developer' as dev;

class SmsService {
  final Telephony _telephony = Telephony.instance;

  Future<void> initialize() async {
    final bool? isSMSAllowed = await _telephony.requestSmsPermissions;

    if (isSMSAllowed != null && isSMSAllowed) {
      _log('SMS permissions granted');
      _telephony.listenIncomingSms(
          onNewMessage: _backgroundMessageHandler,
          onBackgroundMessage: _backgroundMessageHandler);

      _log('SMS listener initialized');
      return;
    }
  }
}

_log(String log) {
  dev.log(log, name: 'SMS Listener');
}

Future<void> _backgroundMessageHandler(SmsMessage message) async {
  _processMessageWithRegex(message);

  if (response.statusCode == 200) {
    _log('Data sent to API successfully');
  } else {
    _log('Error sending data to API: ${response.body}');
  }
}

Future<void> _processMessageWithRegex(SmsMessage message) async {
  final regex = RegExp(
      r'Vous avez recu (\d+(?:\.\d+)?) CDF de (\S+) (\d+)\. Nouveau solde: (\d+(?:\.\d+)?) CDF. Ref: (\S+)');

  final match = regex.firstMatch(message.body ?? '');

  if (match == null) {
    _log('Invalid SMS message format');
    return;
  }

  final amount = match.group(1);
  final name = match.group(2);
  final number = match.group(3);
  final balance = match.group(4);
  final reference = match.group(5);

  _log(
      'Data extracted successfully. Name: $name, Number: $number, Amount: $amount, Balance: $balance, Reference: $reference');

  // Add the extracted data to the database (depends on your database implementation)

  // Send the data to the API
  final response = await http.post(
    Uri.parse('https://6415a3a0c13d8149ed1bbe91.mockapi.io/v1/payment/new/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'sender': number,
      'amount': amount,
      'transactioncode': reference,
    }),
  );
}
