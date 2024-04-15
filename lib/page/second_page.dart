import 'package:album_sample/model/photo.dart';
import 'package:album_sample/repository/photo_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final photoProvider = FutureProvider.autoDispose((ref) {
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());

  return ref.read(photoRepository).getPhotos(cancelToken: cancelToken);
});

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.black,
        leading: CupertinoNavigationBarBackButton(
          previousPageTitle: "Back",
          color: Colors.blueAccent,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const Body(),
    );
  }
}

class Body extends ConsumerWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(photoProvider).when(
          data: (data) => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) => PhotoItem(data[index]),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              key: const ValueKey("Error"),
              error.toString(),
            ),
          ),
          loading: () => const Center(
            child: Loader(),
          ),
        );
  }
}

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoActivityIndicator(
      radius: 24,
      color: Colors.blueAccent,
    );
  }
}

class PhotoItem extends StatelessWidget {
  const PhotoItem(this.photo, {super.key});

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CachedNetworkImage(
          imageUrl: photo.thumbnailUrl,
          placeholder: (context, url) => const Loader(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(photo.id.toString()),
            Text(
              photo.title,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}
