import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'podcast_carousel_item.dart';

class PodcastCarousel extends HookWidget {
  const PodcastCarousel({
    Key? key,
    this.isLoading = true,
    this.podcasts,
  }) : super(key: key);

  final bool isLoading;
  final List<Podcast>? podcasts;

  @override
  Widget build(BuildContext context) {
    final currentPage = useState<int>(0);

    if (!isLoading && podcasts != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 2.0,
            child: PageView.builder(
              itemCount: podcasts!.length,
              itemBuilder: (BuildContext context, int index) {
                final podcast = podcasts![index];
                return PodcastCarouselItem(podcast: podcast);
              },
              onPageChanged: (value) => currentPage.value = value,
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                podcasts!.length,
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AspectRatio(
          aspectRatio: 2.0,
          child: PodcastCarouselItemSkeleton(),
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              5,
              (index) {
                final isCurrentPage = index == 0;
                return Container(
                  width: isCurrentPage ? 32.0 : 8.0,
                  height: 4.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: isCurrentPage
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
