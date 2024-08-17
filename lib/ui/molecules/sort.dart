import 'package:flutter/material.dart';
import 'package:search_github_repository/ui/custom_size_extension.dart';
import 'package:search_github_repository/ui/atoms/select.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class Sort extends StatelessWidget {
  const Sort({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
    required this.showOrderChoice,
    this.ascending = false,
  });

  final List<String> options;
  final int selected;

  /// ソート順が変更されたときに呼ばれるコールバック
  /// onChanged(String option, bool ascending)
  final void Function(String, bool) onChanged;

  /// ソート順を選択するかどうか
  final bool showOrderChoice;

  final bool ascending;

  onOptionChanged(int value) {
    if (selected == value) return;
    onChanged(options[value], ascending);
  }

  onOrderChanged(bool value) {
    if (ascending == value) return;
    onChanged(options[selected], value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Select(
          options: options,
          selected: selected,
          onChanged: onOptionChanged,
        ),
        if (showOrderChoice) Text(' が ', style: TextStyle(fontSize: 16.sp)),
        if (showOrderChoice)
          Select(
            options: const ['多い順', '少ない順'],
            selected: ascending ? 1 : 0,
            onChanged: (value) => onOrderChanged(value == 1),
          ),
      ],
    );
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: Sort,
  path: 'molecules',
)
Widget sort(BuildContext context) {
  ValueNotifier<int> notifier = ValueNotifier(0);
  const List<String> options = ['best match', 'fork', 'star'];
  return Container(
    color: Theme.of(context).colorScheme.surface,
    child: Center(
      child: ValueListenableBuilder<int>(
          valueListenable: notifier,
          builder: (context, value, _) {
            return Sort(
              options: options,
              onChanged: (String option, bool ascending) {
                debugPrint(
                    'Sort by $option ${value != 0 ? (ascending ? 'ascending' : 'descending') : ''}');
                notifier.value = options.indexOf(option) * (ascending ? 1 : -1);
              },
              selected: value.abs(),
              ascending: value > 0,
              showOrderChoice: value != 0,
            );
          }),
    ),
  );
}
