/// ソートのオプション
enum SortOptions {
  bestMatch,
  star,
  fork,
}

extension SortOptionsExtension on SortOptions {
  /// ソート順として表示する際のラベル
  String get name {
    switch (this) {
      case SortOptions.bestMatch:
        return 'Best Match';
      case SortOptions.star:
        return 'Star';
      case SortOptions.fork:
        return 'Fork';
    }
  }

  /// クエリパラメータとして使用する際の名前
  String get queryName {
    switch (this) {
      case SortOptions.bestMatch:
        return 'best match';
      case SortOptions.star:
        return 'stars';
      case SortOptions.fork:
        return 'forks';
    }
  }

  /// ソート順として表示する際のラベルからSortOptionsを取得
  /// 存在しない場合はerrorとなる
  static SortOptions fromName(String name) {
    return SortOptions.values.firstWhere(
      (e) => e.name == name,
    );
  }
}
