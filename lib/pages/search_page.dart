import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:podfetch_api/providers/api_provider.dart';
import 'package:podfetch_api/responses/search_response.dart';
import 'package:podfetch_flutter/service_locator.dart';
import 'package:podfetch_flutter/theme.dart';
import 'package:podfetch_flutter/widgets/categories/categories_grid.dart';
import 'package:podfetch_flutter/widgets/forms/text_field.dart';
import 'package:podfetch_flutter/widgets/page/page_header.dart';
import '../widgets/base/page_wrap.dart';

class SearchPage extends HookWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textEditingController = useTextEditingController();
    final _focusNode = useFocusNode();

    final isSearchFocused = useState<bool>(false);
    final searchResults = useState<SearchResponse?>(null);

    _focusNode.addListener(() {
      isSearchFocused.value = _focusNode.hasFocus;
    });

    _textEditingController.addListener(() async {
      if (_textEditingController.text.isNotEmpty) {
        var response = await getIt<PodfetchApiProvider>()
            .search(_textEditingController.text);
        searchResults.value = response;
      }
    });

    return PageWrap(
      child: Column(
        children: [
          PfPageHeader(
              // title: 'Search',
              ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: kPagePadding, vertical: 16.0),
            child: TextField(
              controller: _textEditingController,
              focusNode: _focusNode,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: isSearchFocused.value
                  ? Text('show search results')
                  : const CategoriesGrid(
                      columnCount: 3,
                      aspectRatio: 1,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
