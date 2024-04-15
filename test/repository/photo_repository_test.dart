import 'package:album_sample/repository/photo_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/fake_photo_api.dart';

void main() {
  test("Photo Repository", () async {
    final container = ProviderContainer(
      overrides: [
        photoRepository.overrideWith((ref) => PhotoRepositoryImp(ref, photoApi: FakePhotoApi())),
      ],
    );

    final photos = await container.read(photoRepository).getPhotos();
    expect(photos.length, 5000);
  });
}
