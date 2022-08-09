import 'package:flutter/material.dart';
import 'package:podfetch_api/models/podcast.dart';
import '../../theme.dart';
import 'podcasts_grid_item.dart';

class SliverPodcastsGrid extends StatelessWidget {
  const SliverPodcastsGrid({Key? key, required this.podcasts})
      : super(key: key);
  final List<Podcast>? podcasts;
  @override
  Widget build(BuildContext context) {
    if (podcasts != null && podcasts!.isNotEmpty) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final leftIndex = index * 2;
            final rightIndex = leftIndex + 1;
            final hasRightItem = rightIndex < podcasts!.length;

            return Container(
              margin: const EdgeInsets.only(bottom: kPagePadding),
              padding: const EdgeInsets.symmetric(horizontal: kPagePadding),
              child: Row(
                children: [
                  Expanded(
                    child: PodcastsGridItem(
                      podcast: podcasts![leftIndex],
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: hasRightItem
                        ? PodcastsGridItem(
                            podcast: podcasts![rightIndex],
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            );
          },
          childCount: (podcasts!.length / 2).ceil(),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: kPagePadding),
            padding: const EdgeInsets.symmetric(horizontal: kPagePadding),
            child: Row(
              children: const [
                Expanded(child: PodcastsGridItemSkeleton()),
                SizedBox(width: 4.0),
                Expanded(child: PodcastsGridItemSkeleton()),
              ],
            ),
          );
        },
      ),
    );
  }
}
