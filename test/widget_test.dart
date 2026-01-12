import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:thingsay/app.dart';

void main() {
  testWidgets('Home Automation app loads correctly',
      (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const ThingsSayApp());

    // Trigger initial frame
    await tester.pump();

    // Verify AppBar title
    expect(find.text('Home Weather Automation'), findsOneWidget);

    // Verify loading indicator appears initially
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
