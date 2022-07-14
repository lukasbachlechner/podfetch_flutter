import 'package:flutter/material.dart';

import '../../theme.dart';

class ModalWrapper extends StatelessWidget {
  const ModalWrapper({Key? key, this.title, required this.children})
      : super(key: key);
  final String? title;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: DraggableScrollableSheet(
        maxChildSize: 0.95,
        initialChildSize: 0.8,
        minChildSize: 0.8,
        snap: true,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) =>
            Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(8.0)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: kPagePadding),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            controller: scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      height: 4.0,
                      width: 48.0,
                    ),
                  ),
                ),
                if (title != null)
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                const SizedBox(
                  height: 32.0,
                ),
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
