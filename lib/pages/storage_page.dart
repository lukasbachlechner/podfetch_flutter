import 'dart:io';

import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import '../hooks/use_memoized_future.dart';
import '../theme.dart';
import '../widgets/base/page_wrap.dart';
import '../widgets/typography/heading.dart';
import '../widgets/utils/network.dart';
import '../widgets/utils/spacer.dart';

class StoragePage extends HookConsumerWidget {
  const StoragePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempDir = useMemoizedFuture(() async {
      final directory = (await getTemporaryDirectory()).path;
      return Future.value(
          Directory('$directory/libCachedImageData').listSync());
    });

    if (tempDir.snapshot.isReady) {
      final files = tempDir.snapshot.data;
      final totalSize = files?.fold<int>(
        0,
        (previousValue, element) => previousValue + element.statSync().size,
      );
      print('size: ${filesize(totalSize)}, items: ${files?.length}');
    }
    /* final auth = ref.watch(authProvider);
    final authNotifier = ref.watch(authProvider.notifier);
    if (!auth.isLoggedIn) {
      return const SizedBox.shrink();
    } */
    return PageWrap(
      useSlivers: true,
      title: 'Cache',
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kPagePadding),
          child:
              Text('The total size of all cached files, e. g. network images.'),
        ),
      ],
    );
  }
}
