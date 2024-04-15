import 'package:album_sample/page/first_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets("First Page", (widgetTester) async {
    await widgetTester.pumpWidget(const ProviderScope(child: MaterialApp(home: FirstPage())));

    final titleTextFinder = find.text("JSON Placeholder");
    final requestApuTextButtonFinder = find.byType(TextButton);

    expect(titleTextFinder, findsOneWidget);
    expect(requestApuTextButtonFinder, findsOneWidget);

    await widgetTester.tap(requestApuTextButtonFinder);
    await widgetTester.pumpAndSettle();

    expect(titleTextFinder, findsNothing);
    expect(requestApuTextButtonFinder, findsNothing);
  });
}
