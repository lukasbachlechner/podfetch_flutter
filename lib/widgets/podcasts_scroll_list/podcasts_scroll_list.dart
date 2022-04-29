import 'package:flutter/material.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_flutter/theme.dart';
import 'package:podfetch_flutter/widgets/podcasts_scroll_list/podcasts_scroll_list_item.dart';

class PodcastScrollList extends StatelessWidget {
  const PodcastScrollList({Key? key, required this.request}) : super(key: key);

  final Future<List<Podcast>> request;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: request,
      builder: (context, AsyncSnapshot<List<Podcast>> snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: kPagePadding,
                ),
                ...snapshot.data!
                    .map((podcast) => PodcastsScrollListItem(podcast: podcast))
                    .toList(),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
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
      },
    );
  }
}
