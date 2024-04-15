import 'dart:convert';
import 'dart:io';

import 'package:album_sample/api/photo_api.dart';
import 'package:album_sample/model/photo.dart';
import 'package:dio/src/cancel_token.dart';

import '../util/test_util.dart';

class FakePhotoApi implements PhotoApi {
  @override
  Future<List<Photo>> getPhotos({CancelToken? cancelToken}) => File(testPath('json/photos.json'))
      .readAsString()
      .then((value) => (jsonDecode(value) as List))
      .then((value) => value.map((e) => Photo.fromJson(e)))
      .then((value) => value.toList());
}
