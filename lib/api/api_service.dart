import 'dart:io';

import 'package:album_sample/api/photo_api.dart';
import 'package:album_sample/configs.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static final ApiService _instance = ApiService._();

  factory ApiService() => _instance;

  late PhotoApi _photoApi;

  PhotoApi get photoApi => _photoApi;

  ApiService._() {
    final options = BaseOptions(
      baseUrl: "https://jsonplaceholder.typicode.com",
      connectTimeout: Configs.defaultTimeout,
      receiveTimeout: Configs.defaultTimeout,
      sendTimeout: Configs.defaultTimeout,
      headers: {
        HttpHeaders.contentTypeHeader: Headers.jsonContentType,
        HttpHeaders.acceptHeader: Headers.jsonContentType,
      },
    );

    final dio = Dio()
      ..options = options
      ..interceptors.add(PrettyDioLogger(
        responseBody: false,
      ));

    _photoApi = PhotoApiImp(dio: dio);
  }
}