import 'package:flutter/material.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.red,
    );
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: TestWidget,
)
Widget testWidget(BuildContext context) {
  return const Center(
    child: TestWidget(),
  );
}
