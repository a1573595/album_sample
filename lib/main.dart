import 'package:album_sample/page/first_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(
    child: SampleApp(),
  ));
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sample",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        textTheme: Typography().white,
      ),
      home: const FirstPage(),
    );
  }
}
