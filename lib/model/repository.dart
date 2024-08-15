class Repository {
  final String name;
  final String ownerName;
  final String ownerIconUrl;
  final String language;
  final int stars;
  final int wathers;
  final int forks;
  final int issues;

  Repository({
    required this.name,
    required this.ownerName,
    required this.ownerIconUrl,
    required this.language,
    required this.stars,
    required this.wathers,
    required this.forks,
    required this.issues,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'],
      ownerName: json['owner']['login'],
      ownerIconUrl: json['owner']['avatar_url'],
      language: json['language'],
      stars: json['stargazers_count'],
      wathers: json['watchers_count'],
      forks: json['forks_count'],
      issues: json['open_issues_count'],
    );
  }
}
