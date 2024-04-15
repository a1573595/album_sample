import 'dart:convert';
import 'dart:io';

import 'package:album_sample/model/photo.dart';
import 'package:album_sample/repository/photo_repository.dart';
import 'package:dio/src/cancel_token.dart';

import '../util/test_util.dart';

class FakePhotoRepository implements PhotoRepository {
  @override
  Future<List<Photo>> getPhotos({CancelToken? cancelToken}) async {
    final str = File(testPath('json/photos.json')).readAsStringSync();
    return (jsonDecode(str) as List).map((e) => Photo.fromJson(e)).toList();
  }
}
