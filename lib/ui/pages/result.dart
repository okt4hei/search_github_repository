import 'package:flutter/material.dart';
import 'package:search_github_repository/ui/custom_size_extension.dart';
import 'package:search_github_repository/constants/sort_options.dart';
import 'package:search_github_repository/model/query_options.dart';
import 'package:search_github_repository/model/search_result.dart';
import 'package:search_github_repository/service/github_repository_search.dart';
import 'package:search_github_repository/ui/atoms/appbar_button.dart';
import 'package:search_github_repository/ui/organisms/search_options.dart';
import 'package:search_github_repository/ui/organisms/search_result_list.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// 検索結果画面
class Result extends StatefulWidget {
  const Result(
      {super.key, this.initialQueryOptions, this.isWidgetbook = false});

  final QueryOptions? initialQueryOptions;

  /// Widgetbookかどうか
  final bool isWidgetbook;

  @override
  State<Result> createState() => ResultState();
}

class ResultState extends State<Result> {
  /// 検索履歴
  final List<SearchResult> results = [];

  /// 1ページあたりの表示数
  final int perPage = 10;

  /// 現在の検索結果のインデックス
  final ValueNotifier<int> currentIndexNotifier = ValueNotifier(-1);

  int get currentIndex => currentIndexNotifier.value;
  set currentIndex(int value) => currentIndexNotifier.value = value;

  /// 現在の検索結果
  final ValueNotifier<SearchResult> searchResultNotifier =
      ValueNotifier(SearchResult.template);

  /// 次の検索結果へ
  AppBarButton get forwardButton {
    return AppBarButton(
      icon: Icons.arrow_forward,
      onPressed:
          currentIndex < results.length - 1 ? () => currentIndex++ : null,
    );
  }

  /// 前の検索結果へ
  AppBarButton get backButton {
    return AppBarButton(
      icon: Icons.arrow_back,
      onPressed: currentIndex > 0 ? () => currentIndex-- : null,
    );
  }

  /// 閉じるボタン
  AppBarButton get closeButton {
    return AppBarButton(
      icon: Icons.close,
      onPressed: widget.isWidgetbook
          ? () {
              // widgetbookの場合は画面を閉じずに履歴をリセット
              if (results.length > 1) {
                results.removeRange(1, results.length);
              }
              currentIndex = 0;
            }
          : () => Navigator.of(context).pop(),
    );
  }

  /// 検索結果の追加
  void addResult(SearchResult result) {
    if (currentIndex < results.length - 1) {
      results.removeRange(
          currentIndex + 1, results.length); // currentIndexNotifier以降を削除
    }
    results.add(result);
    currentIndex = results.length - 1;
  }

  /// 検索の実行
  void onQuerySubmitted(QueryOptions options) {
    try {
      final response = GithubRepositorySearch.search(
        options.query,
        SortOptionsExtension.fromName(options.sort),
        options.ascending,
        perPage,
        options.page,
      );
      final repositories = Future(() async => (await response).repositories);
      final pageLength =
          Future(() async => ((await response).totalCount / perPage).ceil());

      addResult(SearchResult(
        queryOptions: options,
        pageLength: pageLength,
        repositories: repositories,
      ));
    } on Exception {
      if (mounted) {
        showDialog(
          context: context,
          useRootNavigator: true,
          builder: (context) => const AlertDialog(title: Text('検索に失敗しました')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    currentIndexNotifier.addListener(() {
      debugPrint('currentIndex: $currentIndex');
      searchResultNotifier.value = results[currentIndex];
    });
    if (widget.initialQueryOptions != null) {
      onQuerySubmitted(widget.initialQueryOptions!);
    } else {
      addResult(SearchResult.template);
    }
  }

  @override
  void dispose() {
    currentIndexNotifier.dispose();
    searchResultNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '検索結果',
          style: TextStyle(fontSize: 30.sp),
        ),
        toolbarHeight: 80.r,
        centerTitle: true,
        leadingWidth: 120.r,
        leading: ValueListenableBuilder(
            valueListenable: currentIndexNotifier,
            builder: (_, __, ___) {
              return Row(
                children: [
                  backButton,
                  forwardButton,
                ],
              );
            }),
        actions: [
          closeButton,
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.r, horizontal: 10.r),
        child: Column(
          children: [
            SearchOptions(
              onChanged: onQuerySubmitted,
              searchResultNotifier: searchResultNotifier,
            ),
            Expanded(
              child: SearchResultList(
                searchResultNotifier: searchResultNotifier,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: Result,
  path: 'pages',
)
Widget result(BuildContext context) {
  return const Result(isWidgetbook: true);
}
