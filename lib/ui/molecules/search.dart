import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_github_repository/ui/atoms/search_box.dart';
import 'package:search_github_repository/ui/atoms/search_button.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class Search extends StatefulWidget {
  const Search({
    super.key,
    required this.onSubmitted,
    required this.isMain,
    this.initiaiValue = '',
  });

  final void Function(String) onSubmitted;

  /// メイン画面用の検索バーかどうか
  final bool isMain;

  final String initiaiValue;

  @override
  State<Search> createState() => SearchState();
}

class SearchState extends State<Search> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.initiaiValue;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isMain
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SearchBox(
                onSubmitted: widget.onSubmitted,
                controller: controller,
              ),
              SizedBox(height: 30.r),
              SearchButton(
                onPressed: () => widget.onSubmitted(controller.text),
                label: '検索',
              ),
            ],
          )
        : Row(
            children: [
              Expanded(
                child: SearchBox(
                  onSubmitted: widget.onSubmitted,
                  controller: controller,
                ),
              ),
              SizedBox(width: 20.r),
              SearchButton(
                onPressed: () => widget.onSubmitted(controller.text),
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
      ),
    ),
  );
}
