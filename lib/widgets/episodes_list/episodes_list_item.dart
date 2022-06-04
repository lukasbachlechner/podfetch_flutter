import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:podfetch_api/models/episode.dart';
import 'package:podfetch_flutter/routes/router.gr.dart';
import 'package:podfetch_flutter/widgets/buttons/icon_button.dart';
import 'package:podfetch_flutter/widgets/player/play_button.dart';

class EpisodeListItem extends StatelessWidget {
  const EpisodeListItem({Key? key, required this.episode}) : super(key: key);
  final Episode episode;

  Widget _buildHeader() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(2.0),
          child: CachedNetworkImage(
            imageUrl: episode.image,
            height: 36.0,
            width: 36.0,
          ),
        ),
        const SizedBox(
          width: 12.0,
        ),
        Expanded(
          child: AutoSizeText(
            episode.title,
            maxLines: 2,
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        PfIconButton(
          padding: EdgeInsets.zero,
          maxHeight: 24.0,
          maxWidth: 24.0,
          onPressed: () {},
          icon: const Icon(
            BootstrapIcons.three_dots,
            size: 16.0,
          ),
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

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              TextSpan(
                text: episode.datePublishedFormatted,
              ),
              const TextSpan(text: ' \u00B7 '),
              TextSpan(text: episode.audioDurationFormatted),
            ],
          ),
        ),
        Row(
          children: [
            PlayButton(onPressed: () {}),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        // color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: GestureDetector(
        onTap: () {
          context.navigateTo(
            SingleEpisodeRoute(episodeId: episode.id, episode: episode),
          );
        },
        child: Column(
          children: [
            _buildHeader(),
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
      ),
    );
  }
}

class EpisodesListItemSkeleton extends StatelessWidget {
  const EpisodesListItemSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
