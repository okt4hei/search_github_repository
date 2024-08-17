import 'dart:async';

import 'package:flutter/material.dart';
import 'package:search_github_repository/constants/sort_options.dart';
import 'package:search_github_repository/model/query_options.dart';
import 'package:search_github_repository/model/search_result.dart';
import 'package:search_github_repository/ui/atoms/pagination.dart';
import 'package:search_github_repository/ui/custom_size_extension.dart';
import 'package:search_github_repository/ui/molecules/search.dart';
import 'package:search_github_repository/ui/molecules/sort.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class SearchOptions extends StatefulWidget {
  const SearchOptions({
    super.key,
    required this.onChanged,
    required this.searchResultNotifier,
  });

  /// 検索条件が変更されたときに呼ばれるコールバック
  /// onChanged(String query, String sort, bool ascending, int page)
  final void Function(QueryOptions) onChanged;

  /// 直前の検索結果
  final ValueNotifier<SearchResult> searchResultNotifier;

  @override
  State<SearchOptions> createState() => SearchOptionsState();
}

class SearchOptionsState extends State<SearchOptions> {
  final TextEditingController controller = TextEditingController();
  QueryOptions get queryOptions =>
      widget.searchResultNotifier.value.queryOptions;
  Future<int> get pageLength => widget.searchResultNotifier.value.pageLength;

  final List<String> sortOptions = SortOptions.values
      .map((option) => option.name)
      .toList(); // Best Match, Star, Fork

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  onQuerySubmitted(String query) {
    if (query.isEmpty || queryOptions.query == query) return;
    widget.onChanged(QueryOptions(
      query: query,
      sort: queryOptions.sort,
      ascending: queryOptions.ascending,
      page: 0, // クエリが変わったらページをリセット
    ));
  }

  onSortOptionChanged(String sort, bool ascending) {
    if (sort == SortOptions.bestMatch.name) {
      ascending = false; // Best matchは必ず降順
    }
    widget.onChanged(QueryOptions(
      query: queryOptions.query,
      sort: sort,
      ascending: ascending,
      page: 0, // ソートが変わったらページをリセット
    ));
  }

  onPageChanged(int page) {
    widget.onChanged(QueryOptions(
      query: queryOptions.query,
      sort: queryOptions.sort,
      ascending: queryOptions.ascending,
      page: page,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.searchResultNotifier,
        builder: (_, __, ___) {
          controller.text = queryOptions.query;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Search(
                onSubmitted: onQuerySubmitted,
                isMain: false,
                controller: controller,
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
                      selected: sortOptions.indexOf(queryOptions.sort),
                      ascending: queryOptions.ascending,
                      showOrderChoice: queryOptions.sort !=
                          SortOptions.bestMatch.name, // Best matchはソート順を選択できない
                    ),
                  ),
                  FutureBuilder(
                    future: pageLength,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const SizedBox.shrink();
                      }
                      return Pagination(
                        length: snapshot.data!,
                        currentPage: queryOptions.page,
                        onPageChanged: onPageChanged,
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: SearchOptions,
  path: 'organisms',
)
Widget searchOptions(BuildContext context) {
  ValueNotifier<SearchResult> notifier = ValueNotifier(SearchResult.template);

  onChanged(QueryOptions query) {
    debugPrint('query: $query');
    notifier.value = SearchResult(
      queryOptions: query,
      pageLength: Future.value(10),
      repositories: Future.value([]),
    );
  }

  return Container(
    color: Theme.of(context).colorScheme.surface,
    child: Center(
      child: Column(
        children: [
          const Spacer(),
          SearchOptions(
            onChanged: onChanged,
            searchResultNotifier: notifier,
          ),
          const Spacer(),
        ],
      ),
    ),
  );
}
