import 'package:hooks_riverpod/hooks_riverpod.dart';

class PageTitleNotifier extends StateNotifier<String> {
  PageTitleNotifier() : super('');

  void set(String title) {
    state = title;
  }

  void reset() {
    state = '';
  }
}
