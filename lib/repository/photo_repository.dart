import 'package:album_sample/api/api_service.dart';
import 'package:album_sample/api/photo_api.dart';
import 'package:album_sample/model/photo.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final photoRepository = Provider<PhotoRepository>((ref) => PhotoRepositoryImp(ref));

abstract class PhotoRepository {
  Future<List<Photo>> getPhotos({CancelToken? cancelToken});
}

class PhotoRepositoryImp extends PhotoRepository {
  final ProviderRef ref;
  final PhotoApi photoApi;

  PhotoRepositoryImp(this.ref, {PhotoApi? photoApi}) : photoApi = photoApi ?? ApiService().photoApi;

  @override
  Future<List<Photo>> getPhotos({CancelToken? cancelToken}) => photoApi.getPhotos();
}
