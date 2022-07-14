import 'package:hooks_riverpod/hooks_riverpod.dart';

final pageTitleProvider =
    StateNotifierProvider<PageTitleNotifier, String>((ref) {
  return PageTitleNotifier();
});

class PageTitleNotifier extends StateNotifier<String> {
  PageTitleNotifier() : super('');

  void set(String title) {
    state = title;
  }

  void reset() {
    state = '';
  }
}
