import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class GithubAccountIcon extends StatelessWidget {
  const GithubAccountIcon({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    final double width = 70.r;
    final double height = 70.r;

    return ClipOval(
      child: Image.network(
        url,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return Container(
            width: width,
            height: height,
            color: Theme.of(context).colorScheme.outlineVariant,
          );
        },
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: GithubAccountIcon,
  path: 'atoms',
)
Widget githubAccountIcon(BuildContext context) {
  return Container(
    color: Theme.of(context).colorScheme.surface,
    child: Center(
      child: GithubAccountIcon(
        url: context.knobs.boolean(label: 'not found', initialValue: false)
            ? ''
            : 'https://avatars.githubusercontent.com/u/142867353?s=60&v=4',
      ),
    ),
  );
}
