import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_github_repository/constants/sort_options.dart';
import 'package:search_github_repository/ui/atoms/pagination.dart';
import 'package:search_github_repository/ui/molecules/search.dart';
import 'package:search_github_repository/ui/molecules/sort.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class SearchOptions extends StatelessWidget {
  const SearchOptions({
    super.key,
    required this.onChanged,
    required this.query,
    required this.selected,
    required this.ascending,
    required this.pageLength,
    required this.currentPage,
  });

  /// 検索条件が変更されたときに呼ばれるコールバック
  /// onChanged(String query, String sort, bool ascending, int page)
  final void Function(String, String, bool, int) onChanged;

  /// 検索クエリ
  final String query;

  /// ソートオプション
  final String selected;

  /// 昇順かどうか
  final bool ascending;

  /// ページ数
  final int pageLength;

  /// 現在のページ
  final int currentPage;

  onQuerySubmitted(String query) {
    if (query == this.query) return;
    onChanged(query, selected, ascending, currentPage);
  }

  onSortOptionChanged(String selected, bool ascending) {
    if (selected == SortOptions.bestMatch.name) {
      ascending = false; // Best matchは必ず降順
    }
    onChanged(query, selected, ascending, currentPage);
  }

  onPageChanged(int page) {
    onChanged(query, selected, ascending, page);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> sortOptions = SortOptions.values
        .map((option) => option.name)
        .toList(); // Best Match, Star, Fork
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Search(
          onSubmitted: onQuerySubmitted,
          isMain: false,
          initiaiValue: query,
        ),
        SizedBox(height: 10.r),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            IntrinsicWidth(
              child: Sort(
                options: sortOptions,
                onChanged: onSortOptionChanged,
                selected: sortOptions.indexOf(selected),
                ascending: ascending,
                showOrderChoice: selected !=
                    SortOptions.bestMatch.name, // Best matchはソート順を選択できない
              ),
            ),
            Pagination(
              length: pageLength,
              currentPage: currentPage,
              onPageChanged: onPageChanged,
            ),
          ],
        ),
      ],
    );
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: SearchOptions,
  path: 'organisms',
)
Widget searchOptions(BuildContext context) {
  ValueNotifier<List<String>> notifier = ValueNotifier([
    '',
    SortOptions.bestMatch.name,
    'false',
    '0',
  ]);

  onChanged(String query, String sort, bool ascending, int page) {
    debugPrint(
        'query: $query, sort: $sort, ascending: $ascending, page: $page');
    notifier.value = [query, sort, ascending.toString(), page.toString()];
  }

  return Container(
    color: Theme.of(context).colorScheme.surface,
    child: Center(
      child: Column(
        children: [
          const Spacer(),
          ValueListenableBuilder<List<String>>(
            valueListenable: notifier,
            builder: (context, value, _) {
              return SearchOptions(
                onChanged: onChanged,
                query: value[0],
                selected: value[1],
                ascending: value[2] == 'true',
                currentPage: int.parse(value[3]),
                pageLength: 10,
              );
            },
          ),
          const Spacer(),
        ],
      ),
    ),
  );
}
