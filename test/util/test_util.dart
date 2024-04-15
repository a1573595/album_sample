import 'dart:io';

String testPath(String relativePath) {
  Directory current = Directory.current;
  String path = current.path.endsWith('/test') ? current.path : '${current.path}/test';
  return '$path/$relativePath';
}