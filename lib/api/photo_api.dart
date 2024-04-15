import 'package:album_sample/model/photo.dart';
import 'package:dio/dio.dart';

abstract class PhotoApi {
  Future<List<Photo>> getPhotos({CancelToken? cancelToken});
}

class PhotoApiImp extends PhotoApi {
  final Dio dio;

  PhotoApiImp({required this.dio});

  @override
  Future<List<Photo>> getPhotos({CancelToken? cancelToken}) async => dio
      .get('https://jsonplaceholder.typicode.com/photos', cancelToken: cancelToken)
      .then((value) => value.data as List)
      .then((value) => value.map((e) => Photo.fromJson(e)))
      .then((value) => value.toList());
}
