import 'package:flutter/material.dart';
import 'package:search_github_repository/model/repository.dart';
import 'package:search_github_repository/model/search_result.dart';
import 'package:search_github_repository/ui/organisms/detail_modal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// 検索結果のリスト
class SearchResultList extends StatelessWidget {
  const SearchResultList({
    super.key,
    required this.searchResultNotifier,
  });

  /// 検索結果
  final ValueNotifier<SearchResult> searchResultNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: searchResultNotifier,
        builder: (context, searchResult, _) {
          return FutureBuilder(
            future: searchResult.repositories,
            builder: (context, snapshot) {
              // データ取得中はローディングを表示
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView(
                children: snapshot.data!
                    .map(
                      (repository) => DetailModal(
                        repository: repository,
                      ),
                    )
                    .toList(),
              );
            },
          );
        });
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: SearchResultList,
  path: 'organisms',
)
Widget searchResultList(BuildContext context) {
  List<Repository> repositories = List.generate(10, (_) => Repository.template);
  ValueNotifier<SearchResult> searchResultNotifier = ValueNotifier(SearchResult(
      queryOptions: SearchResult.template.queryOptions,
      pageLength: Future.value(10),
      repositories: Future.value(repositories)));
  return Container(
    color: Theme.of(context).colorScheme.surface,
    child: Center(
      child: SearchResultList(
        searchResultNotifier: searchResultNotifier,
      ),
    ),
  );
}
