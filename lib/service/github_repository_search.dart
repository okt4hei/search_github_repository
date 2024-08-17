import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:search_github_repository/constants/sort_options.dart';
import 'package:search_github_repository/model/repository.dart';

class GithubRepositorySearch {
  static Future<GithubRepositorySearchResponse> _search(
      String query, int perPage, int page,
      [String? orderBy, bool? ascending]) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.github.com/search/repositories?q=$query${orderBy != null ? '&sort=$orderBy' : ''}${ascending != null ? '&order=${ascending ? 'asc' : 'desc'}' : ''}&per_page=$perPage&page=${page + 1}'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final totalCount = data['total_count'] as int;
        final items = data['items'] as List;
        final repositories = items.map((e) => Repository.fromJson(e)).toList();
        return GithubRepositorySearchResponse(
          repositories: repositories,
          totalCount: totalCount,
        );
      } else {
        throw Exception('検索に失敗しました');
      }
    } on Exception {
      rethrow;
    }
  }

  static Future<GithubRepositorySearchResponse> search(String query,
      SortOptions orderBy, bool ascending, int perPage, int page) {
    if (orderBy == SortOptions.bestMatch) {
      return _search(
          query, perPage, page); // Best matchはorderByとascendingを指定しない
    }
    return _search(query, perPage, page, orderBy.queryName, ascending);
  }
}

class GithubRepositorySearchResponse {
  final List<Repository> repositories;
  final int totalCount;

  GithubRepositorySearchResponse({
    required this.repositories,
    required this.totalCount,
  });
}
