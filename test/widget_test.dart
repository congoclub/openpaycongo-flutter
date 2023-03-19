// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:opencongopay/main.dart';
import 'package:opencongopay/widgets/opencongopayapp.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const OpenCongoPayApp());

    // Verify that our counter starts at 0.
    expect(find.text('Item 0'), findsOneWidget);
    expect(find.text('Item 100'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.scrollUntilVisible(find.text('Item 100'), 100);

    // Verify that our counter has incremented.
    expect(find.text('Item 0'), findsNothing);
    expect(find.text('Item 100'), findsOneWidget);
  });
}
