import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:podfetch_api/models/episode.dart';
import '../buttons/icon_button.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({
    Key? key,
    required this.episode,
    this.size = 24.0,
  }) : super(key: key);

  final Episode episode;
  final double size;

  @override
  Widget build(BuildContext context) {
    return PfIconButton(
      onPressed: () {},
      icon: Icon(
        BootstrapIcons.download,
        size: size,
      ),
    );
  }
}
