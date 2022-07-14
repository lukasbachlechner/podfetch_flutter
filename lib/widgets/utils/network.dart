import 'package:flutter/material.dart';

extension CheckReady on AsyncSnapshot {
  bool get isReady {
    return hasData && connectionState == ConnectionState.done;
  }
}
