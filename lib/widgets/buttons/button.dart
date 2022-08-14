import 'package:flutter/material.dart';

enum ButtonType { accent, muted, ghost }

enum ButtonSize { small, large }

enum ButtonWidth { auto, full }

class ButtonTypeStyle {
  final Color color;

  const ButtonTypeStyle({required this.color});
}

class ButtonSizeStyle {
  final EdgeInsets padding;
  final TextStyle textStyle;
  final double height;

  const ButtonSizeStyle(
      {required this.padding, required this.textStyle, required this.height});
}

class PfButton extends StatelessWidget {
  const PfButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.disabled = false,
    this.isLoading = false,
    this.buttonType = ButtonType.muted,
    this.buttonSize = ButtonSize.large,
    this.buttonWidth = ButtonWidth.auto,
  }) : super(key: key);

  final void Function() onPressed;
  final Widget child;
  final bool isLoading;
  final bool disabled;
  final ButtonType buttonType;
  final ButtonSize buttonSize;
  final ButtonWidth buttonWidth;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: _resolveStyle(context),
      onPressed: (disabled || isLoading) ? null : onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Visibility(
            visible: isLoading,
            child: const SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            ),
          ),
          Opacity(
            opacity: !isLoading ? 1.0 : 0.0,
            child: child,
          ),
        ],
      ),
    );
  }

  Color _resolveDisabledColor(Set<MaterialState> states, Color color) {
    double opacity = 1.0;
    if (states.contains(MaterialState.disabled)) {
      opacity = 0.5;
    }
    return color.withOpacity(opacity * color.opacity);
  }

  ButtonStyle _resolveStyle(context) {
    final types = <ButtonType, ButtonTypeStyle>{
      ButtonType.muted: const ButtonTypeStyle(color: Colors.white24),
      ButtonType.accent:
          ButtonTypeStyle(color: Theme.of(context).highlightColor),
      ButtonType.ghost: const ButtonTypeStyle(color: Colors.transparent),
    };

    final sizes = <ButtonSize, ButtonSizeStyle>{
      ButtonSize.small: const ButtonSizeStyle(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        textStyle: TextStyle(fontSize: 12.0),
        height: 32.0,
      ),
      ButtonSize.large: const ButtonSizeStyle(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        textStyle: TextStyle(fontSize: 16.0),
        height: 48.0,
      ),
    };

    final widths = <ButtonWidth, double>{
      ButtonWidth.auto: 0.0,
      ButtonWidth.full: double.infinity
    };

    final type = types[buttonType]!;
    final size = sizes[buttonSize]!;
    final width = widths[buttonWidth]!;

    return ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) {
          return _resolveDisabledColor(states, type.color);
        },
      ),
      elevation: MaterialStateProperty.all(0.0),
      padding: MaterialStateProperty.all(size.padding),
      textStyle: MaterialStateProperty.all(
          size.textStyle.copyWith(fontFamily: 'Satoshi')),
      fixedSize: MaterialStateProperty.all(
        Size.fromHeight(size.height),
      ),
      minimumSize: MaterialStateProperty.all(Size(width, size.height)),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      enableFeedback: true,
    );
  }

  /* BoxDecoration _getStyle(context) {
    Color color = Colors.white24;
    if (buttonType == ButtonType.accent) {
      color = Theme.of(context).highlightColor;
    }

    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4.0),
    );
  } */
}
