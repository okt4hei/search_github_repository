import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.r,
      height: 100.r,
      child: Card(
        child: Center(
          child: Text(
            'Hello, World!',
            style: TextStyle(fontSize: 4.sp),
          ),
        ),
      ),
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
