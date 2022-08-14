import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:podfetch_flutter/widgets/categories/categories_grid.dart';
import 'package:podfetch_flutter/widgets/flows/flow_page_wrapper.dart';

import '../../../widgets/buttons/button.dart';

class ChooseCategoriesPage extends HookWidget {
  const ChooseCategoriesPage({Key? key, required this.onNext})
      : super(key: key);

  final Function(List<String?> categoryIds) onNext;
  @override
  Widget build(BuildContext context) {
    final chosenCategories = useState<List<String?>>([]);
    final buttonDisabled = chosenCategories.value.length < 5;

    return FlowPageWrapper(
      title: 'Personalize',
      bottomSheet: PfButton(
        onPressed: () {
          onNext(chosenCategories.value);
        },
        buttonType: ButtonType.accent,
        buttonWidth: ButtonWidth.full,
        disabled: buttonDisabled,
        child: buttonDisabled
            ? Text('Select ${5 - chosenCategories.value.length} more...')
            : const Text('Submit'),
      ),
      children: [
        const SizedBox(height: 24.0),
        const Text(
            "Please select 5 or more categories that match your interest best. We'll generate personalized recommendations based on your choices."),
        const SizedBox(height: 24.0),
        CategoriesGrid(
          inPageContainer: false,
          selectable: true,
          onSelectedCategoriesChange: (categories) {
            chosenCategories.value =
                categories.map((category) => category.id.toString()).toList();
          },
        ),
      ],
    );
  }
}
