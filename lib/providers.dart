import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/providers/api_provider.dart';
import 'package:podfetch_api/providers/podfetch_legacy_provider.dart';
import 'package:podfetch_api/repositories/categories_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:we_slide/we_slide.dart';

import 'config.dart';
import 'providers/api_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/language_provider.dart';
import 'providers/page_title_provider.dart';
import 'providers/player_provider.dart';
import 'providers/snackbar_provider.dart';
import 'providers/websockets_provider.dart';
import 'services/language_service.dart';

final apiProvider = Provider<PodfetchApiProvider>((ref) {
  final dio = getDio(ref: ref);
  return PodfetchLegacyProvider(dio, baseUrl: '$apiUrl/v1/');
});

final categoriesProvider = Provider<PodfetchStaticCategoriesRepository>((ref) {
  return PodfetchStaticCategoriesRepository();
});

final websocketsProvider = AutoDisposeProvider<WebsocketService>((ref) {
  final auth = ref.watch(authProvider);
  return WebsocketService(
    baseUrl: apiUrl,
    auth: auth,
  );
});

final authProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final podfetchApiProvider = ref.read(apiProvider);
  return AuthStateNotifier(
      AuthState(null, null, initialized: false), podfetchApiProvider);
});

final languageProvider =
    StateNotifierProvider<LanguageNotifier, Language>((ref) {
  return LanguageNotifier();
});

/* final pageTitleProvider =
    StateNotifierProvider<PageTitleNotifier, String>((ref) {
  return PageTitleNotifier();
}); */

final audioPlayerProvider = ChangeNotifierProvider.autoDispose(
  (ref) => AudioPlayerModel(
    apiProvider: ref.read(apiProvider),
    snackbarService: ref.read(snackbarProvider),
    websocketsProvider: ref.read(websocketsProvider),
  ),
);

final weSlideControllerProvider =
    Provider<WeSlideController>((ref) => WeSlideController());

final snackbarProvider = Provider<SnackbarService>((ref) => SnackbarService());

final likedEpisodesProvider =
    StateNotifierProvider<LikedEpisodesNotifier, LikedEpisodesState>(
  (ref) {
    final podfetchApiProvider = ref.read(apiProvider);
    final authUser = ref.watch(authProvider).user;
    return LikedEpisodesNotifier(
      LikedEpisodesState(authUser?.likedEpisodes ?? []),
      podfetchApiProvider,
    );
  },
);
