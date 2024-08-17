import 'package:flutter/material.dart';
import 'package:search_github_repository/ui/custom_size_extension.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class AppBarButton extends StatelessWidget {
  const AppBarButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(8.r),
      onPressed: onPressed,
      icon: Icon(icon, size: 40.r),
    );
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: AppBarButton,
  path: 'atoms',
)
Widget githubAccountIcon(BuildContext context) {
  return Container(
    color: Theme.of(context).colorScheme.surface,
    child: Center(
      child: AppBarButton(
        onPressed: () {},
        icon: context.knobs.list(
          label: 'icon',
          options: [Icons.close, Icons.arrow_back, Icons.arrow_forward],
        ),
      ),
    ),
  );
}
