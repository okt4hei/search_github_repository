import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_github_repository/ui/atoms/search_box.dart';
import 'package:search_github_repository/ui/atoms/search_button.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class Search extends StatelessWidget {
  const Search({
    super.key,
    required this.onSubmitted,
    required this.isMain,
    required this.controller,
  });

  final void Function(String) onSubmitted;

  /// メイン画面用の検索バーかどうか
  final bool isMain;

  final TextEditingController controller;

  onSubmit(String query) {
    if (query.isEmpty) return;
    onSubmitted(query);
  }

  @override
  Widget build(BuildContext context) {
    return isMain
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SearchBox(
                onSubmitted: onSubmit,
                controller: controller,
              ),
              SizedBox(height: 30.r),
              SearchButton(
                onPressed: () => onSubmit(controller.text),
                label: '検索',
              ),
            ],
          )
        : Row(
            children: [
              Expanded(
                child: SearchBox(
                  onSubmitted: onSubmit,
                  controller: controller,
                ),
              ),
              SizedBox(width: 20.r),
              SearchButton(
                onPressed: () => onSubmit(controller.text),
                label: '検索',
              ),
            ],
          );
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: Search,
  path: 'molecules',
)
Widget search(BuildContext context) {
  return Container(
    color: Theme.of(context).colorScheme.surface,
    child: Center(
      child: Search(
        onSubmitted: (query) => debugPrint('query: $query'),
        isMain: context.knobs.boolean(label: 'is main page'),
        controller: TextEditingController(),
      ),
    ),
  );
}
