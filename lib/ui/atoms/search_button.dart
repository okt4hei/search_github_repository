import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  final void Function()? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.r,
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: SearchButton,
  path: 'atoms',
)
Widget searchButton(BuildContext context) {
  return Container(
    color: Theme.of(context).colorScheme.surface,
    child: Center(
      child: SearchButton(
        onPressed: () {},
        label: context.knobs.string(label: 'label', initialValue: '検索'),
      ),
    ),
  );
}
