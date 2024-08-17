/// クエリを保持するクラス
class QueryOptions {
  /// 検索クエリ
  final String query;

  /// ソート条件
  final String sort;

  /// 昇順かどうか
  final bool ascending;

  /// ページ番号
  final int page;

  const QueryOptions({
    required this.query,
    required this.sort,
    required this.ascending,
    required this.page,
  });

  @override
  String toString() {
    return 'QueryOptions(query: $query, sort: $sort, ascending: $ascending, page: $page)';
  }
}
