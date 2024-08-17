import 'dart:math';

import 'package:flutter/material.dart';
import 'package:search_github_repository/ui/custom_size_extension.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class Select extends StatefulWidget {
  const Select({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  final List<String> options;
  final int selected;
  final ValueChanged<int> onChanged;

  @override
  State<Select> createState() => SelectState();
}

class SelectState extends State<Select> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.r),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          width: 0.5.r,
        ),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: DropdownButton(
        underline: const SizedBox.shrink(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 16.sp,
        ),
        iconSize: 24.r,
        itemHeight: max(kMinInteractiveDimension, 48.r), // 最低でも48ピクセル以上なければならない
        items: widget.options
            .asMap()
            .entries
            .map((option) => DropdownMenuItem(
                  value: option.key,
                  child: Text(option.value),
                ))
            .toList(),
        onChanged: (value) => widget.onChanged(value!),
        value: widget.selected,
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: Select,
  path: 'atoms',
)
Widget select(BuildContext context) {
  ValueNotifier<int> notifier = ValueNotifier(0);

  return Container(
    color: Theme.of(context).colorScheme.surface,
    child: Center(
      child: ValueListenableBuilder(
        valueListenable: notifier,
        builder: (context, selected, _) {
          return Select(
            options: const ['選択肢1', '選択肢2', '選択肢3'],
            onChanged: (index) => notifier.value = index,
            selected: selected,
          );
        },
      ),
    ),
  );
}
