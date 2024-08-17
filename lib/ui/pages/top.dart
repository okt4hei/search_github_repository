import 'package:flutter/material.dart';
import 'package:search_github_repository/ui/custom_size_extension.dart';
import 'package:search_github_repository/model/query_options.dart';
import 'package:search_github_repository/ui/molecules/search.dart';
import 'package:search_github_repository/ui/pages/result.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class Top extends StatefulWidget {
  const Top({
    super.key,
    this.isWidgetbook = false,
  });

  /// このウィジェットがWidgetbook上で表示されているかどうか
  final bool isWidgetbook;

  @override
  State<Top> createState() => TopState();
}

class TopState extends State<Top> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  onSubmitted(String query, BuildContext context) {
    if (widget.isWidgetbook) return;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Result(
            initialQueryOptions: QueryOptions(
                query: query, sort: 'Best Match', ascending: false, page: 0))));
  }

  String get githubImagePath {
    if (Theme.of(context).brightness == Brightness.dark) {
      return 'assets/github-mark-white.png';
    } else {
      return 'assets/github-mark.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 32.r),
            child: Column(
              children: [
                Image.asset(githubImagePath, width: 200.r),
                SizedBox(height: 24.r),
                Text(
                  'リポジトリを検索',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.r),
                Search(
                  onSubmitted: (query) => onSubmitted(query, context),
                  isMain: true,
                  controller: controller,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: Top,
  path: 'pages',
)
Widget top(BuildContext context) {
  return const Top(isWidgetbook: true);
}
