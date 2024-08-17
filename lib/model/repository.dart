/// Githubのリポジトリ情報を保持するクラス
class Repository {
  final String name;
  final String ownerName;
  final String ownerIconUrl;
  final String language;
  final int stars;
  final int watchers;
  final int forks;
  final int issues;

  Repository({
    required this.name,
    required this.ownerName,
    required this.ownerIconUrl,
    required this.language,
    required this.stars,
    required this.watchers,
    required this.forks,
    required this.issues,
  });

  static Repository template = Repository(
    name: 'リポジトリ名',
    ownerName: 'okt4hei',
    ownerIconUrl: 'https://avatars.githubusercontent.com/u/142867353?s=60&v=4',
    language: 'Assembly',
    stars: 10,
    forks: 15,
    watchers: 1,
    issues: 5,
  );

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'],
      ownerName: json['owner']?['login'] ?? '',
      ownerIconUrl: json['owner']?['avatar_url'] ?? '',
      language: json['language'] ?? '',
      stars: json['stargazers_count'],
      watchers: json['watchers_count'],
      forks: json['forks_count'],
      issues: json['open_issues_count'],
    );
  }
}
