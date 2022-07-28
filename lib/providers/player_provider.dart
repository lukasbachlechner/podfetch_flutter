import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:podfetch_api/models/episode.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_api/providers/api_provider.dart';
import 'package:podfetch_flutter/providers/api_provider.dart';
import 'package:we_slide/we_slide.dart';

class AudioPlayerModel extends ChangeNotifier {
  final PodfetchApiProvider apiProvider;

  Episode? currentEpisode;
  Podcast? currentPodcast;
  Duration? totalDuration;
  Duration? progress;
  Duration? buffered;
  PlayerState? playerState;

  AudioPlayer player = AudioPlayer();

  AudioPlayerModel({
    required this.apiProvider,
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

  bool get isLoading {
    final processingState = playerState?.processingState;
    return processingState == ProcessingState.buffering ||
        processingState == ProcessingState.loading;
  }

  void initAudio() {
    player.playerStateStream.listen((currentPlayerState) {
      playerState = currentPlayerState;
      notifyListeners();
    });

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

  void playEpisode(
    Episode episodeToPlay,
  ) async {
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
      playAudio();
    }
  }

  void playAudio() async {
    if (currentEpisode?.audioUrl != null) {
      if (completion == 1.0) {
        seek(Duration.zero);
      }

      await player.play();
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
  }

  void setSpeed(double speed) {
    player.setSpeed(speed);
    notifyListeners();
  }
}

final audioPlayerProvider = ChangeNotifierProvider(
  (ref) => AudioPlayerModel(
    apiProvider: ref.read(apiProvider),
  ),
);

final weSlideControllerProvider =
    Provider<WeSlideController>((ref) => WeSlideController());
