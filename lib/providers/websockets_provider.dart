import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/models/episode.dart';
import '../config.dart';
import 'auth_provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class WebsocketService {
  final String baseUrl;
  final AuthState auth;
  bool shouldEmit = false;

  Socket? socket;

  WebsocketService({
    required this.baseUrl,
    required this.auth,
  }) {
    final authToken = auth.token;
    socket = io(
      baseUrl,
      OptionBuilder()
          .setAuth({
            'token': authToken,
          })
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build(),
    );

    socket!.on('connect', (_) {
      debugPrint('WebSocket connected.');
    });
  }

  void setupConnections() {}

  void setPlaybackTime(Episode episode, Duration duration) {
    if (socket != null) {
      socket!.emit('set-playback-time', {
        'episodeId': episode.id.toString(),
        'playbackTime': duration.inSeconds,
      });
    }
  }
}
