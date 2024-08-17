import 'package:flutter/material.dart';
import 'package:search_github_repository/ui/custom_size_extension.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.onSubmitted,
    required this.controller,
  });

  final void Function(String)? onSubmitted;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: controller,
        onSubmitted: onSubmitted,
        style: TextStyle(fontSize: 28.sp),
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.r, horizontal: 12.r),
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
    child: Center(
      child: SearchBox(
        onSubmitted: null,
        controller: TextEditingController(),
      ),
    ),
  );
}
