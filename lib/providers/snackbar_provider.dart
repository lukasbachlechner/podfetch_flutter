import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SnackbarService {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  SnackbarService();

  GlobalKey<ScaffoldMessengerState> get key => _scaffoldMessengerKey;

  show(SnackBar snackBar) {
    _scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}
