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
      child: FilledButton(
        style: FilledButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 16.r),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
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
