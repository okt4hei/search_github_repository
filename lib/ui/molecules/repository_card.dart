import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_github_repository/model/repository.dart';
import 'package:search_github_repository/ui/atoms/github_account_icon.dart';
import 'package:search_github_repository/ui/atoms/github_info_icon.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class RepositoryCard extends StatelessWidget {
  const RepositoryCard({
    super.key,
    required this.repository,
  });

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
        child: Row(
          children: [
            GithubAccountIcon(size: 70.r, url: repository.ownerIconUrl),
            SizedBox(width: 10.r),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    repository.name,
                    style:
                        TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.r),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          repository.ownerName,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        SizedBox(width: 6.r),
                        GithubInfoIcon(
                          icon: Icons.remove_red_eye_outlined,
                          label: 'watch',
                          number: repository.wathers,
                          isDetail: false,
                        ),
                        SizedBox(width: 6.r),
                        GithubInfoIcon(
                          icon: Icons.fork_left_outlined,
                          label: 'fork',
                          number: repository.forks,
                          isDetail: false,
                        ),
                        SizedBox(width: 6.r),
                        GithubInfoIcon(
                          icon: Icons.star_outline,
                          label: 'star',
                          number: repository.stars,
                          isDetail: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: RepositoryCard,
  path: 'molecules',
)
Widget repositoryCard(BuildContext context) {
  Repository repository = Repository(
    name: 'リポジトリ名',
    ownerName: 'okt4hei',
    ownerIconUrl: 'https://avatars.githubusercontent.com/u/142867353?s=60&v=4',
    language: 'Assembly',
    stars: 10,
    forks: 15,
    wathers: 1,
    issues: 5,
  );
  return Container(
    color: Theme.of(context).colorScheme.surface,
    child: Center(
      child: Column(
        children: [
          const Spacer(),
          RepositoryCard(repository: repository),
          const Spacer(),
        ],
      ),
    ),
  );
}
