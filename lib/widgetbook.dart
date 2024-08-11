import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:search_github_repository/widgetbook.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      appBuilder: (context, child) => MaterialApp(
        title: 'Search Repository Widgetbook',
        home: Scaffold(body: child),
      ),
      addons: <WidgetbookAddon>[
        MaterialThemeAddon(
          themes: <WidgetbookTheme<ThemeData>>[
            WidgetbookTheme<ThemeData>(
              name: 'Light',
              data: ThemeData(
                colorSchemeSeed: Colors.blueGrey,
                useMaterial3: true,
                brightness: Brightness.light,
              ),
            ),
            WidgetbookTheme<ThemeData>(
              name: 'Dark',
              data: ThemeData(
                colorSchemeSeed: Colors.blueGrey,
                useMaterial3: true,
                brightness: Brightness.dark,
              ),
            ),
          ],
        ),
        DeviceFrameAddon(
          devices: Devices.android.all,
          initialDevice: Devices.android.sonyXperia1II,
        ),
        TextScaleAddon(
          scales: <double>[1.0, 2.0],
        ),
        InspectorAddon(),
        BuilderAddon(
          name: 'ScreenUtil',
          builder: (context, child) {
            return ScreenUtilInit(
              designSize: const Size(411, 960), // Sony Xperia 1 II
              builder: (context, child) => child!,
              child: child,
            );
          },
        )
      ],
    );
  }
}
