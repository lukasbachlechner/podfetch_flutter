import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_api/models/subscribed_podcast.dart';
import 'package:podfetch_api/models/user.dart';
import 'package:podfetch_api/podfetch_api.dart';
import 'package:podfetch_api/providers/api_provider.dart';
import 'package:podfetch_flutter/providers/api_provider.dart';

class AuthState {
  final String? token;
  final User? user;

  AuthState(this.token, this.user);

  bool get isLoggedIn {
    return token != null && user != null;
  }
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier(AuthState state, this.apiProvider) : super(state) {
    getUser();
  }
  final PodfetchApiProvider apiProvider;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  bool get isLoggedIn {
    return state.isLoggedIn;
  }

  String? get token {
    return state.token;
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await apiProvider.login({
        'email': email,
        'password': password,
      });
      state = AuthState(response.token, response.user);
      await storage.write(key: 'api-token', value: token);
      return true;
    } on DioError catch (e) {
      print(e.response?.data?.toString());
      return false;
    }
  }

  Future<void> getUser() async {
    final token = await storage.read(key: 'api-token');
    if (token == null) {
      return;
    }
    try {
      final user = await apiProvider.getUser(bearerToken: 'Bearer $token');
      state = AuthState(token, user);
    } on DioError catch (e) {
      print(e.response?.data?.toString());
    }
  }

  Future<void> logout() async {
    try {
      await apiProvider.logout(bearerToken: 'Bearer ${state.token}');
      await storage.delete(key: 'api-token');
      state = AuthState(null, null);
    } on DioError catch (e) {
      print(e.response?.data?.toString());
    }
  }

  Future<void> addSubscription(Podcast podcast) async {
    await apiProvider.subscribeToPodcast(
      podcastToSubscribe: SubscribedPodcast(null, podcast.id.toString()),
    );
    await getUser();
  }

  Future<void> removeSubscription(Podcast podcast) async {
    await apiProvider.unsubscribeFromPodcast(
      podcastToUnsubscribe: SubscribedPodcast(null, podcast.id.toString()),
    );
    await getUser();
  }
}

/* final authApiProvider = Provider<PodfetchApiProvider>((ref) {
  return PodfetchLegacyProvider(Dio(), baseUrl: 'http://localhost:3333/v1/');
}); */

final authProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final podfetchApiProvider = ref.read(apiProvider);
  return AuthStateNotifier(AuthState(null, null), podfetchApiProvider);
});
