import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:podfetch_api/models/episode.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_api/providers/api_provider.dart';
import 'api_provider.dart';
import 'auth_provider.dart';
import 'snackbar_provider.dart';
import 'websockets_provider.dart';
import '../services/snackbar_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:we_slide/we_slide.dart';

class AudioPlayerModel extends ChangeNotifier {
  final PodfetchApiProvider apiProvider;
  final WebsocketService websocketsProvider;
  // final AuthState authProvider;

  Episode? currentEpisode;
  Podcast? currentPodcast;
  Duration? totalDuration;
  Duration? progress;
  Duration? buffered;
  PlayerState? playerState;

  SnackbarService? snackbarService;

  AudioPlayer player = AudioPlayer();

  AudioPlayerModel({
    required this.apiProvider,
    required this.snackbarService,
    required this.websocketsProvider,
    // required this.authProvider,
  }) {
    initAudio();
  }

  double get completion {
    if (progress == null || totalDuration == null) {
      return 0;
    }

    return progress!.inMilliseconds / totalDuration!.inMilliseconds;
  }

  bool get isPlaying {
    return playerState?.playing ?? false;
  }

  double get speed {
    return player.speed;
  }

  double get volume {
    return player.volume;
  }

  bool get isLoading {
    final processingState = playerState?.processingState;
    return processingState == ProcessingState.buffering ||
        processingState == ProcessingState.loading;
  }

  void initAudio() async {
    /*  if (authProvider.isLoggedIn) {
     
    } */

    final lastPlayedEpisode = await apiProvider.getLastPlayedEpisode();
    if (lastPlayedEpisode.hasEpisode) {
      prepareEpisode(lastPlayedEpisode.episode!);
    }

    player.playerStateStream.listen((currentPlayerState) {
      playerState = currentPlayerState;
      notifyListeners();
    });

    /* player.positionStream
        .throttleTime(const Duration(seconds: 1))
        .listen((currentPosition) {
      if (currentEpisode != null) {
        websocketsProvider.setPlaybackTime(
          currentEpisode!,
          currentPosition,
        );
      }
    }); */

    player.positionStream.listen((currentPosition) {
      progress = currentPosition;
      if (progress == totalDuration) {
        player.stop();
      }
      notifyListeners();
    });

    player.bufferedPositionStream.listen((currentBufferedPosition) {
      buffered = currentBufferedPosition;
      notifyListeners();
    });
  }

  void prepareEpisode(Episode episodeToPlay) async {
    currentEpisode = episodeToPlay;
    currentPodcast =
        await apiProvider.getPodcastById(currentEpisode!.podcastId);
    if (currentEpisode?.audioUrl != null) {
      // totalDuration = await player.setUrl(currentEpisode!.audioUrl);
      totalDuration = await player.setAudioSource(
        AudioSource.uri(
          Uri.parse(currentEpisode!.audioUrl),
          tag: MediaItem(
            id: currentEpisode!.id.toString(),
            title: currentEpisode!.title,
            artist: currentPodcast?.title ?? '',
            artUri: Uri.parse(currentEpisode!.image),
          ),
        ),
      );

      if (currentEpisode?.playbackTime != null) {
        player.seek(
          Duration(seconds: currentEpisode?.playbackTime ?? 0),
        );
      }
    }
  }

  void playEpisode(
    Episode episodeToPlay,
  ) async {
    prepareEpisode(episodeToPlay);
    playAudio();
  }

  void playAudio() async {
    if (currentEpisode?.audioUrl != null) {
      if (completion == 1.0) {
        seek(Duration.zero);
      }

      try {
        // snackbarService?.show(SnackBar(content: Text('Yay!')));
        await player.play();
      } catch (e) {
        snackbarService?.show(SnackBar(content: Text('Oops :(')));
      }
    }
  }

  void pauseAudio() {
    player.pause();
  }

  void togglePlayback() {
    if (isPlaying) {
      pauseAudio();
    } else {
      playAudio();
    }
  }

  void seek(Duration duration) {
    player.seek(duration);
  }

  void seekTo(int delta) {
    if (progress != null) {
      final newDuration = Duration(seconds: progress!.inSeconds + delta);
      player.seek(newDuration);
    }
  }

  void setVolume(double volume) {
    player.setVolume(volume);
    notifyListeners();
  }

  void setSpeed(double speed) {
    player.setSpeed(speed);
    notifyListeners();
  }
}
