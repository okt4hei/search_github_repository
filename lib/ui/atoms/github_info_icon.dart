import 'package:flutter/material.dart';
import 'package:search_github_repository/ui/custom_size_extension.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Githubリポジトリの情報(watch, fork, star)を表示するウィジェット
class GithubInfoIcon extends StatelessWidget {
  const GithubInfoIcon({
    super.key,
    required this.icon,
    required this.label,
    required this.number,
    required this.isDetail,
  });

  final IconData icon;
  final String label;
  final int number;

  /// 詳細モーダル用の表示かどうか
  /// 大きめのiconとlabelを表示する
  final bool isDetail;

  Widget get title {
    // isDetailがtrueの場合はlabelを表示
    if (isDetail) {
      return Row(
        children: [
          Icon(icon, size: 30.r),
          SizedBox(width: 10.r),
          Text(
            label,
            style: TextStyle(fontSize: 24.sp),
          ),
        ],
      );
    }
    return Icon(icon, size: 20.r);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.r),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 1.r,
        ),
        borderRadius: BorderRadius.circular(60.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: (isDetail ? 8 : 4).r,
          vertical: 4.r,
        ),
        child: Row(
          children: [
            title,
            SizedBox(width: (isDetail ? 20 : 4).r),
            Text(
              number.toString(),
              style: TextStyle(fontSize: (isDetail ? 24 : 16).sp),
            ),
          ],
        ),
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: GithubInfoIcon,
  path: 'atoms',
)
Widget githubInfoIcon(BuildContext context) {
  List<IconData> icons = [
    Icons.remove_red_eye_outlined,
    Icons.fork_left_outlined,
    Icons.star_outline
  ];
  List<String> labels = ['watch', 'fork', 'star'];
  String label = context.knobs.list(label: 'label', options: labels);
  int index = labels.indexWhere((element) => element == label);
  return Container(
    color: Theme.of(context).colorScheme.surface,
    child: Center(
      child: IntrinsicWidth(
        child: GithubInfoIcon(
          icon: icons[index],
          label: label,
          number: 20,
          isDetail: context.knobs.boolean(label: 'is detail'),
        ),
      ),
    ),
  );
}
