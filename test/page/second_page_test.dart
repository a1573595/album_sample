import 'package:album_sample/page/second_page.dart';
import 'package:album_sample/repository/photo_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../repository/fake_photo_repository.dart';

void main() {
  group("Second Page", () {
    testWidgets("Loading", (widgetTester) async {
      await widgetTester.pumpWidget(ProviderScope(
        overrides: [
          photoRepository.overrideWith((ref) => FakePhotoRepository()),
        ],
        child: const MaterialApp(home: SecondPage()),
      ));

      final progressIndicator = find.byType(Loader);

      expect(progressIndicator, findsOneWidget);
    });

    testWidgets("Success", (widgetTester) async {
      await widgetTester.pumpWidget(ProviderScope(
        overrides: [
          photoRepository.overrideWith((ref) => FakePhotoRepository()),
        ],
        child: const MaterialApp(home: SecondPage()),
      ));
      await widgetTester.pump(const Duration(seconds: 1));

      final photoItemFinder = find.byType(PhotoItem);
      expect(photoItemFinder, findsAtLeast(4));
    });

    testWidgets("Error", (widgetTester) async {
      await widgetTester.pumpWidget(ProviderScope(
        overrides: [
          photoProvider.overrideWith((ref) => Future.error(Exception())),
        ],
        child: const MaterialApp(home: SecondPage()),
      ));
      await widgetTester.pump(const Duration(seconds: 1));

      final errorTextFinder = find.byKey(const ValueKey("Error"));
      expect(errorTextFinder, findsOneWidget);
    });
  });
}
