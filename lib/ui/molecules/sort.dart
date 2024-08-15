import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_github_repository/ui/atoms/select.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class Sort extends StatefulWidget {
  const Sort({
    super.key,
    required this.options,
    required this.onChanged,
    required this.showOrderChoice,
  });

  final List<String> options;
  final void Function(String, bool) onChanged;

  /// ソート順を選択するかどうか
  final bool showOrderChoice;

  @override
  State<Sort> createState() => SortState();
}

class SortState extends State<Sort> {
  int selected = 0;
  bool ascending = false;

  onOptionChanged(int value) {
    if (selected == value) return;
    setState(() {
      selected = value;
      widget.onChanged(widget.options[value], ascending);
    });
  }

  onOrderChanged(bool value) {
    if (ascending == value) return;
    setState(() {
      ascending = value;
      widget.onChanged(widget.options[selected], ascending);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Select(
          options: widget.options,
          selected: selected,
          onChanged: onOptionChanged,
        ),
        if (widget.showOrderChoice)
          Text(' が ', style: TextStyle(fontSize: 16.sp)),
        if (widget.showOrderChoice)
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
  bool showOrderChoice = context.knobs.boolean(
    label: 'show order choice',
    initialValue: true,
  );
  return Container(
    color: Theme.of(context).colorScheme.surface,
    child: Center(
      child: Sort(
        options: const ['watch', 'fork', 'star'],
        onChanged: (String option, bool ascending) {
          debugPrint(
              'Sort by $option ${showOrderChoice ? (ascending ? 'ascending' : 'descending') : ''}');
        },
        showOrderChoice: showOrderChoice,
      ),
    ),
  );
}
