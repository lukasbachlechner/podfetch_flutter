import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:podfetch_api/models/podcast.dart';
import '../../theme.dart';
import 'podcasts_scroll_list_item.dart';

class PodcastScrollList extends HookWidget {
  const PodcastScrollList({
    Key? key,
    this.isLoading = true,
    this.podcasts,
  }) : super(key: key);

  final bool isLoading;
  final List<Podcast?>? podcasts;

  @override
  Widget build(BuildContext context) {
    if (!isLoading && podcasts != null) {
      if (podcasts!.isEmpty) {
        return const SizedBox.shrink();
      }
      return SizedBox(
        height: 200,
        child: ListView.builder(
            padding: const EdgeInsets.only(left: kPagePadding),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final podcast = podcasts![index];
              return PodcastsScrollListItem(podcast: podcast!);
            },
            itemCount: podcasts!.length),
      );
      /*    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: kPagePadding,
            ),
            ...podcasts!
                .map((podcast) => PodcastsScrollListItem(podcast: podcast))
                .toList(),
          ],
        ),
      ); */
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: kPagePadding,
          ),
          ...List.filled(5, 0)
              .map((podcast) => const PodcastsScrollListItemSkeleton())
              .toList(),
        ],
      ),
    );
  }
}
