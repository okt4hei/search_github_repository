import 'package:flutter/material.dart';
import 'package:search_github_repository/ui/custom_size_extension.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class GithubAccountIcon extends StatelessWidget {
  const GithubAccountIcon({super.key, required this.size, required this.url});

  final String url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return Container(
            width: size,
            height: size,
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
        size: 70.r,
      ),
    ),
  );
}
