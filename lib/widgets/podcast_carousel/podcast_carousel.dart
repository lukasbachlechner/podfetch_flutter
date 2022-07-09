import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_flutter/theme.dart';
import 'package:podfetch_flutter/widgets/page/page_header.dart';
import 'package:podfetch_flutter/widgets/podcast_carousel/podcast_carousel_item.dart';

import '../../hooks/use_memoized_future.dart';
import '../typography/heading.dart';

class PodcastCarousel extends HookWidget {
  const PodcastCarousel({Key? key, required this.request, this.requestKey})
      : super(key: key);

  final Future<List<Podcast>> request;
  final UniqueKey? requestKey;

  @override
  Widget build(BuildContext context) {
    final fetch =
        useMemoizedFuture<List<Podcast>>(() => request, keys: [requestKey]);
    final currentPage = useState<int>(0);

    final snapshot = fetch.snapshot;
    if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 2.0,
            child: PageView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final podcast = snapshot.data![index];
                return PodcastCarouselItem(podcast: podcast);
              },
              onPageChanged: (value) => currentPage.value = value,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                snapshot.data!.length,
                (index) {
                  final isCurrentPage = index == currentPage.value;
                  return AnimatedContainer(
                    width: isCurrentPage ? 32.0 : 8.0,
                    height: 4.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      color: isCurrentPage
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    duration: const Duration(milliseconds: 200),
                  );
                },
              ),
            ],
          ),
        ],
      );
    }

    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
