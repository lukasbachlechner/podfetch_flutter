import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/models/episode.dart';
import 'package:podfetch_flutter/widgets/single_episode/episode_progress_indicator.dart';
import '../../providers/player_provider.dart';
import '../../routes/router.gr.dart';
import '../buttons/icon_button.dart';
import '../media/image.dart';
import '../player/like_button.dart';
import '../player/play_button.dart';
import '../skeleton/skeleton_box.dart';

class EpisodeListItem extends ConsumerWidget {
  const EpisodeListItem({
    Key? key,
    required this.episode,
    this.dense = false,
    this.showPodcastTitle = false,
  }) : super(key: key);

  final Episode episode;
  final bool dense;
  final bool showPodcastTitle;

  Widget _buildHeader() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(2.0),
          child: PfImage(
            imageUrl: episode.image,
            height: 36.0,
            width: 36.0,
            errorWidget: (context, url, error) => PfImage(
              imageUrl: episode.podcastImage ?? '',
            ),
          ),
        ),
        const SizedBox(
          width: 12.0,
        ),
        Expanded(
          child: showPodcastTitle
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      episode.title,
                      maxLines: 1,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      episode.podcastTitle ?? '',
                      maxLines: 1,
                      style: const TextStyle(fontSize: 12.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              : Text(
                  episode.title,
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
        ),
        const SizedBox(
          width: 12.0,
        ),
        LikeButton(
          episode: episode,
          size: 16,
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Text(
      episode.excerpt,
      style: Theme.of(context).textTheme.bodySmall,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildFooter(BuildContext context, WidgetRef ref, Episode episode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.up,
          children: [
            Text(
              episode.datePublishedFormatted,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              ' \u00B7 ',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            episode.playbackTime != null
                ? EpisodeProgressIndicator(episode: episode)
                : Text(
                    episode.audioDurationFormatted,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
          ],
        ),
        /*  RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              TextSpan(
                text: episode.datePublishedFormatted,
              ),
              const TextSpan(text: ' \u00B7 '),
              episode.playbackTime != null
                  ? WidgetSpan(
                      baseline: TextBaseline.ideographic,
                      style: Theme.of(context).textTheme.bodyMedium,
                      child: Container(
                        color: Colors.red,
                        width: 50,
                        child: Center(
                          child: LinearProgressIndicator(
                            value: 0.5,
                          ),
                        ),
                      ))
                  : TextSpan(text: episode.audioDurationFormatted),
            ],
          ),
        ), */
        Row(
          children: [
            PlayButton(
              episode: episode,
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        context.navigateTo(
          SingleEpisodeRoute(episodeId: episode.id, episode: episode),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(
              height: 16.0,
            ),
            if (!dense) ...[
              _buildBody(context),
              const SizedBox(
                height: 16.0,
              ),
            ],
            _buildFooter(context, ref, episode),
          ],
        ),
      ),
    );
  }
}

class EpisodesListItemSkeleton extends StatelessWidget {
  const EpisodesListItemSkeleton({Key? key}) : super(key: key);

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        SkeletonBox(
          height: 36.0,
          width: 36.0,
          borderRadius: 2.0,
        ),
        SizedBox(
          width: 12.0,
        ),
        Expanded(
          child: SkeletonBox(
            maxLines: 2,
            text:
                'Lorem ipsum dolor sit amet, \n consectetur adipiscing elit. Curabitur mattis elit eu luctus mattis.',
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return const SkeletonBox(
      maxLines: 3,
      text:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur mattis elit eu luctus mattis. Praesent rhoncus urna in fermentum gravida. Donec laoreet enim a est pellentesque, nec tincidunt dui porttitor. Quisque nec ex vehicula, laoreet odio in, venenatis eros. Cras sed justo magna. Phasellus id libero lorem. Suspendisse quis risus id justo gravida placerat ut sit amet arcu. Phasellus mattis quam non quam consectetur, eget tempor nisi pellentesque. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed vel rutrum ligula. Cras a ante mauris. Ut enim magna, blandit a rhoncus quis, feugiat non eros. Vivamus facilisis.',
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SkeletonBox(
              textStyle: Theme.of(context).textTheme.bodyMedium,
              text: 'Jan 01',
            ),
            Text(
              ' \u00B7 ',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SkeletonBox(
              textStyle: Theme.of(context).textTheme.bodyMedium,
              text: '30 min',
            ),
          ],
        ),
        const SkeletonBox(
          width: 36,
          height: 36,
          shape: BoxShape.circle,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(
            height: 16.0,
          ),
          _buildBody(context),
          const SizedBox(
            height: 16.0,
          ),
          _buildFooter(context),
        ],
      ),
    );
  }
}
