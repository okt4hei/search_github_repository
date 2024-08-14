import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class Pagination extends StatelessWidget {
  const Pagination({
    super.key,
    required this.length,
    required this.currentPage,
    required this.onPageChanged,
  });

  /// 合計ページ数
  final int length;

  /// 現在のページ(0スタート)
  final int currentPage;

  /// ページ変更時のコールバック
  final void Function(int) onPageChanged;

  /// 現在のページの前後に表示するページ数
  final int around = 2;

  /// 表示するページ数
  final int showLength = 5;

  TextStyle get textStyle => TextStyle(fontSize: 20.sp);

  ButtonStyle get buttonStyle {
    return TextButton.styleFrom(padding: EdgeInsets.zero);
  }

  /// 表示するページのインデックス
  List<int> get showIndices {
    if (length <= showLength) {
      return List.generate(length, (index) => index);
    }
    int start = currentPage - around;
    if (start < 0) {
      return List.generate(showLength, (index) => index);
    }
    int end = start + showLength;
    if (end >= length) {
      return List.generate(showLength, (index) => length - showLength + index);
    }
    return List.generate(showLength, (index) => start + index);
  }

  /// 前のページに戻るボタン
  TextButton previous(BuildContext context) {
    if (currentPage == 0) {
      return TextButton(
        onPressed: null,
        style: buttonStyle,
        child: Text('<', style: textStyle),
      );
    }

    return TextButton(
      onPressed: () => onPageChanged(currentPage - 1),
      style: buttonStyle,
      child: Text(
        '<',
        style:
            textStyle.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }

  /// 次のページに進むボタン
  TextButton next(BuildContext context) {
    if (currentPage == length - 1) {
      return TextButton(
        onPressed: null,
        style: buttonStyle,
        child: Text('>', style: textStyle),
      );
    }

    return TextButton(
      onPressed: () => onPageChanged(currentPage + 1),
      style: buttonStyle,
      child: Text(
        '>',
        style:
            textStyle.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240.r,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(width: 20.r, child: previous(context)),
        ...List.generate(
          showIndices.length,
          (index) => SizedBox(
            width: (140 / showIndices.length).r,
            child: TextButton(
              onPressed: () => onPageChanged(showIndices[index]),
              style: buttonStyle,
              child: Text(
                (showIndices[index] + 1).toString(),
                style: textStyle.copyWith(
                  color: showIndices[index] == currentPage
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 20.r, child: next(context)),
      ]),
    );
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: Pagination,
  path: 'atoms',
)
Widget pagination(BuildContext context) {
  ValueNotifier<int> notifier = ValueNotifier(0);
  return Container(
    color: Theme.of(context).colorScheme.surface,
    child: Center(
      child: ValueListenableBuilder<int>(
          valueListenable: notifier,
          builder: (context, currentPage, _) {
            return Pagination(
              length: context.knobs.list(label: 'length', options: [3, 5, 10]),
              currentPage: currentPage,
              onPageChanged: (index) => notifier.value = index,
            );
          }),
    ),
  );
}
