import 'package:flutter/material.dart';
import 'package:search_github_repository/ui/custom_size_extension.dart';
import 'package:search_github_repository/model/repository.dart';
import 'package:search_github_repository/ui/atoms/github_account_icon.dart';
import 'package:search_github_repository/ui/atoms/github_info_icon.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// リポジトリの詳細情報
class RepositoryDetail extends StatelessWidget {
  const RepositoryDetail({
    super.key,
    required this.repository,
  });

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GithubAccountIcon(size: 180.r, url: repository.ownerIconUrl),
          SizedBox(height: 8.r),
          Text(
            repository.ownerName,
            style: TextStyle(fontSize: 24.sp),
          ),
          SizedBox(height: 12.r),
          Text(
            repository.name,
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.r),
          Text(
            'Langage: ${repository.language}',
            style: TextStyle(fontSize: 20.sp),
          ),
          SizedBox(height: 8.r),
          Wrap(
            spacing: 10.r,
            runSpacing: 8.r,
            children: [
              IntrinsicWidth(
                child: GithubInfoIcon(
                  icon: Icons.remove_red_eye_outlined,
                  label: 'watch',
                  number: repository.watchers,
                  isDetail: true,
                ),
              ),
              IntrinsicWidth(
                child: GithubInfoIcon(
                  icon: Icons.fork_left_outlined,
                  label: 'fork',
                  number: repository.forks,
                  isDetail: true,
                ),
              ),
              IntrinsicWidth(
                child: GithubInfoIcon(
                  icon: Icons.star_outline,
                  label: 'star',
                  number: repository.stars,
                  isDetail: true,
                ),
              ),
              IntrinsicWidth(
                child: GithubInfoIcon(
                  icon: Icons.adjust_outlined,
                  label: 'issue',
                  number: repository.issues,
                  isDetail: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: RepositoryDetail,
  path: 'molecules',
)
Widget repositoryDetail(BuildContext context) {
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
  return Container(
    color: Theme.of(context).colorScheme.surface,
    child: Center(
      child: RepositoryDetail(
        repository: repository,
      ),
    ),
  );
}
