# search_github_repository

Githubのリポジトリを検索するAndroid用Flutterアプリ

See: https://github.com/yumemi-inc/flutter-engineer-codecheck?tab=readme-ov-file

## 動作
![demo](https://github.com/user-attachments/assets/96bf7bb1-8bc8-48bd-8708-5b3a7e45bc71)


## 実行方法

```
$ fvm use
$ fvm flutter run lib/main.dart
```

## widgetbookの確認方法

このプロジェクトでは[widgetbook](https://pub.dev/packages/widgetbook)を用いてUIの確認をすることができます。
```
$ fvm use
$ fvm flutter pub run build_runner build --delete-conflicting-outputs
$ fvm flutter run lib/widgetbook.dart -d chrome
```
