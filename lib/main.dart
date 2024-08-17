import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_github_repository/ui/pages/top.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 960), // Sony Xperia 1 II
      builder: (_, child) {
        return MaterialApp(
          title: 'Search Repository',
          theme: ThemeData(
            colorSchemeSeed: Colors.blueGrey,
            useMaterial3: true,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            colorSchemeSeed: Colors.blueGrey,
            useMaterial3: true,
            brightness: Brightness.dark,
          ),
          home: child,
        );
      },
      child: const Top(),
    );
  }
}
