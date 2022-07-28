import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/providers/auth_provider.dart';
import 'package:podfetch_flutter/providers/page_title_provider.dart';
import 'package:podfetch_flutter/providers/player_provider.dart';
import 'package:podfetch_flutter/theme.dart';
import 'package:podfetch_flutter/widgets/base/app_bar.dart';
import 'package:podfetch_flutter/widgets/base/bottom_navigation_bar.dart';
import 'package:podfetch_flutter/widgets/buttons/icon_button.dart';
import 'package:podfetch_flutter/widgets/notifications/notification_bar.dart';
import 'package:podfetch_flutter/widgets/player/play_button.dart';
import 'package:we_slide/we_slide.dart';

import 'routes/router.gr.dart';

class PageTitleObserver extends AutoRouterObserver {
  // final StateController<String> pageTitleProviderState;
  final WidgetRef ref;
  PageTitleObserver(this.ref) : super();

  @override
  void didPop(route, previousRoute) {
    ref.read(pageTitleProvider.notifier).reset();
  }

  @override
  void didPush(route, previousRoute) {
    print(route);
  }
}

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.isLoggedIn == false) {
        print('is not logged in anymore');
      }
    });

    // final pageTitleProviderState = ref.read(pageTitleProvider.notifier);

    final hasTitle = ref.watch(pageTitleProvider).isNotEmpty;

    return WillPopScope(
      onWillPop: () async {
        if (context.router.canPopSelfOrChildren) {
          return context.router.pop(true);
        }
        return false;
      },
      child: AutoTabsScaffold(
        resizeToAvoidBottomInset: false,
        navigatorObservers: () => [HeroController(), AutoRouteObserver()],
        routes: const [
          DiscoverRouter(),
          SearchRouter(),
          ListsRouter(),
          SettingsRouter(),
        ],
        // appBarBuilder: (_, tabsRouter) => PfAppBar(tabsRouter: tabsRouter),
        builder: (context, child, _) {
          final tabsRouter = context.tabsRouter;
          final theme = Theme.of(context);

          final showPlayer =
              ref.watch(audioPlayerProvider).currentEpisode != null;

          final double appBarHeight =
              kToolbarHeight + MediaQuery.of(context).padding.top;
          final showAppBar = hasTitle || context.router.canPopSelfOrChildren;

          const double footerHeight = 120.0;
          const double panelHeaderSize = 80.0;

          double panelMinSize = footerHeight + panelHeaderSize;
          double panelMaxSize = MediaQuery.of(context).size.height;

          final controller = ref.watch(weSlideControllerProvider);

          if (!showPlayer) {
            panelMinSize = 0;
          }

          return WeSlide(
            parallax: true,
            hideAppBar: true,
            hideFooter: true,
            panelMinSize: panelMinSize,
            panelMaxSize: panelMaxSize,
            panelBorderRadiusBegin: 0.0,
            panelBorderRadiusEnd: 0.0,
            overlay: true,
            parallaxOffset: 0.1,
            appBarHeight: showAppBar ? appBarHeight : 0,
            appBar: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: showAppBar ? 1 : 0,
              child: PfAppBar(
                tabsRouter: tabsRouter,
              ),
            ),
            footerHeight: footerHeight,
            backgroundColor: Theme.of(context).backgroundColor,
            controller: controller,
            body: SafeArea(
              top: !showAppBar,
              bottom: false,
              child: child,
            ),
            panel: const PodcastFullPlayer(),
            panelHeader: GestureDetector(
              onTap: () {
                // controller.show();
              },
              child: const PodcastMiniPlayer(height: panelHeaderSize),
            ),
            footer: PfBottomNavigationBar(
              tabsRouter: tabsRouter,
            ),
          );
        },
      ),
    );
  }
}

class PodcastFullPlayer extends ConsumerWidget {
  const PodcastFullPlayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audioPlayerProvider);
    final theme = Theme.of(context);
    final episode = player.currentEpisode;
    final podcast = player.currentPodcast;
    final controller = ref.watch(weSlideControllerProvider);

    if (episode == null) {
      return const SizedBox.shrink();
    }

    return Container(
      color: theme.primaryColorLight,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PfIconButton(
                    onPressed: () => controller.hide(),
                    icon: const Icon(BootstrapIcons.chevron_down),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Now Playing',
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                  PfIconButton(
                    onPressed: () {},
                    icon: const Icon(BootstrapIcons.three_dots),
                  )
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: episode?.image ?? podcast?.safeImage ?? '',
                ),
              ),
              const SizedBox(height: 48.0),
              Text(
                episode?.title ?? '',
                style: theme.textTheme.displaySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4.0),
              Text(
                podcast?.title ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16.0),
              if (player.progress != null &&
                  player.totalDuration != null &&
                  player.buffered != null)
                ProgressBar(
                  baseBarColor: theme.highlightColor,
                  onSeek: (Duration newDuration) => player.seek(newDuration),
                  progressBarColor: theme.highlightColor,
                  thumbColor: theme.highlightColor,
                  progress: player.progress!,
                  total: player.totalDuration!,
                  buffered: player.buffered,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PfIconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog();
                        },
                      );
                    },
                    icon: Icon(BootstrapIcons.volume_up),
                  ),
                  PfIconButton(
                    onPressed: () => player.seekTo(-15),
                    icon: Stack(
                      children: [
                        Icon(
                          BootstrapIcons.arrow_counterclockwise,
                          size: 32,
                        ),
                        Positioned.fill(
                          child: Container(
                            color: Colors.red,
                            child: Text(
                              '15',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  PlayButton(
                    episode: episode,
                    size: 64,
                  ),
                  PfIconButton(
                    onPressed: () => player.seekTo(15),
                    icon: const Text('+15'),
                  ),
                  PfIconButton(
                    onPressed: () => player.seekTo(15),
                    icon: const Text('1x'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PodcastMiniPlayer extends ConsumerWidget {
  const PodcastMiniPlayer({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audioPlayerProvider);
    final theme = Theme.of(context);
    final episode = player.currentEpisode;

    if (episode == null) {
      return const SizedBox.shrink();
    }

    return Container(
      color: theme.primaryColorLight,
      child: Stack(
        children: [
          /*  LinearProgressIndicator(
            minHeight: height,
            color: theme.highlightColor,
            backgroundColor: Colors.transparent,
            value: player.completion,
          ), */
          FractionallySizedBox(
            widthFactor: player.completion,
            heightFactor: 1.0,
            child: Stack(
              children: [
                Container(color: theme.highlightColor.withOpacity(0.4)),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    color: theme.highlightColor.withOpacity(0.5),
                    width: 2.0,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPagePadding),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          width: 36.0,
                          height: 36.0,
                          imageUrl: episode.image,
                        ),
                        Visibility(
                          visible: player.isLoading,
                          child: Positioned.fill(
                            child: Container(
                              color: theme.backgroundColor.withOpacity(0.8),
                              child: const Center(
                                child: SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          episode.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          player.currentPodcast?.title ?? '',
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  PlayButton(episode: episode),
                ],
              ),
            ),
          ),

          // Text(player.progress?.inMilliseconds.toString() ?? ''),
        ],
      ),
    );
  }
}
