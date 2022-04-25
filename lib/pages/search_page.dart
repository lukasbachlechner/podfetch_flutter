import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:podfetch_flutter/pages/to_implement.dart';

import '../routes/router.gr.dart';
import '../widgets/base/page_wrap.dart';

class SearchPage extends HookWidget {
  const SearchPage({Key? key}) : super(key: key);

  List<Widget> _buildCards(count) {
    return Iterable.generate(count, (index) {
      return Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120.0,
                height: 120.0,
                color: Colors.teal,
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('Hi Mom!'),
            ],
          ),
          if (index + 1 < count) SizedBox(width: 12.0),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final _textController = useTextEditingController();
    final _isTextEmpty = useState<bool>(true);

    useEffect(() {
      _textController.addListener(() {
        _isTextEmpty.value = _textController.text.toString().isEmpty;
      });
    }, [_textController]);

    return PageWrap(
      fixed: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _textController,
          autocorrect: false,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            labelText: 'Search...',
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: const EdgeInsets.all(12.0),
            suffixIcon: !_isTextEmpty.value
                ? GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _textController.clear();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 20.0,
                    ),
                  )
                : const SizedBox(),
            prefixIcon: const Icon(
              BootstrapIcons.search,
              size: 16.0,
            ),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [..._buildCards(10)],
              ),
            ),
          ),
          const SizedBox(
            height: 32.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.red,
                    child: const Text('asdf'),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.red,
                    child: Text('asdf'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
