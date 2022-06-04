import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PlayButton extends HookWidget {
  const PlayButton(
      {Key? key, required this.onPressed, this.background = Colors.white12})
      : super(key: key);
  final void Function() onPressed;
  final Color background;

  @override
  Widget build(BuildContext context) {
    final isPlaying = useState(false);
    return GestureDetector(
      onTap: () {
        isPlaying.value = !isPlaying.value;
      },
      child: Container(
        width: 36.0,
        height: 36.0,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: isPlaying.value == true
              ? const Icon(BootstrapIcons.pause)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 2.0,
                    ),
                    Icon(
                      BootstrapIcons.play_fill,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
