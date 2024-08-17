import 'package:flutter/material.dart';
import 'package:search_github_repository/model/repository.dart';
import 'package:search_github_repository/model/search_result.dart';
import 'package:search_github_repository/ui/organisms/detail_modal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class SearchResultList extends StatelessWidget {
  const SearchResultList({
    super.key,
    required this.searchResultNotifier,
  });

  /// 直前の検索結果
  final ValueNotifier<SearchResult> searchResultNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: searchResultNotifier,
        builder: (context, searchResult, _) {
          return FutureBuilder(
            future: searchResult.repositories,
            builder: (context, snapshot) {
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
  Repository repository = Repository(
    name: 'リポジトリ名',
    ownerName: 'okt4hei',
    ownerIconUrl: 'https://avatars.githubusercontent.com/u/142867353?s=60&v=4',
    language: 'Assembly',
    stars: 10,
    forks: 15,
    watchers: 1,
    issues: 5,
  );
  List<Repository> repositories = List.generate(10, (_) => repository);
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
