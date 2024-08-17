import 'package:search_github_repository/model/query_options.dart';
import 'package:search_github_repository/model/repository.dart';

/// 検索結果
class SearchResult {
  /// 検索条件
  final QueryOptions queryOptions;

  /// ページ数
  final Future<int> pageLength;

  /// リポジトリ一覧
  final Future<List<Repository>> repositories;

  const SearchResult({
    required this.queryOptions,
    required this.pageLength,
    required this.repositories,
  });

  static SearchResult template = SearchResult(
    queryOptions: const QueryOptions(
      query: '',
      sort: 'Best Match',
      ascending: false,
      page: 0,
    ),
    pageLength: Future.value(1),
    repositories: Future.value([]),
  );
}
