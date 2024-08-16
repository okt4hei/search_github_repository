import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_github_repository/model/repository.dart';
import 'package:search_github_repository/ui/atoms/search_button.dart';
import 'package:search_github_repository/ui/molecules/repository_card.dart';
import 'package:search_github_repository/ui/molecules/repository_detail.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class DetailModal extends StatelessWidget {
  const DetailModal({
    super.key,
    required this.repository,
  });

  final Repository repository;

  Widget dialog(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 16.r),
            child: Column(children: [
              RepositoryDetail(repository: repository),
              SizedBox(height: 16.r),
              SearchButton(
                  label: '閉じる', onPressed: () => Navigator.pop(context)),
            ]),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryCard(
      repository: repository,
      onTap: () => showDialog(
        context: context,
        builder: dialog,
        useRootNavigator: false, // widgetbookの場合はfalseにする
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: DetailModal,
  path: 'organisms',
)
Widget detailModal(BuildContext context) {
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
      child: Column(
        children: [
          const Spacer(),
          DetailModal(
            repository: repository,
          ),
          const Spacer(),
        ],
      ),
    ),
  );
}
