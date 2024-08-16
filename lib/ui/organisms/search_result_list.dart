import 'package:flutter/material.dart';
import 'package:search_github_repository/model/repository.dart';
import 'package:search_github_repository/ui/organisms/detail_modal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class SearchResultList extends StatelessWidget {
  const SearchResultList({
    super.key,
    required this.repositories,
  });

  final List<Repository> repositories;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: repositories
          .map(
            (repository) => DetailModal(
              repository: repository,
            ),
          )
          .toList(),
    );
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
  return Container(
    color: Theme.of(context).colorScheme.surface,
    child: Center(
      child: SearchResultList(
        repositories: repositories,
      ),
    ),
  );
}
