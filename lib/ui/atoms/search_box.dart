import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.onSubmitted,
    required this.onChanged,
  });

  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80.r,
      child: TextField(
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        style: const TextStyle(fontSize: 24),
        decoration: InputDecoration(
          hintText: 'Search...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            borderSide: BorderSide(width: 1.5.r),
          ),
        ),
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: SearchBox,
  path: 'atoms',
)
Widget searchBox(BuildContext context) {
  return Container(
    color: Theme.of(context).colorScheme.surface,
    child: const Center(
      child: SearchBox(
        onChanged: null,
        onSubmitted: null,
      ),
    ),
  );
}
