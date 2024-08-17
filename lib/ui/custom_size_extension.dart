import 'package:flutter_screenutil/flutter_screenutil.dart';

bool get isPortrait => ScreenUtil().screenWidth < ScreenUtil().screenHeight;

/// 画面の向きに対応したサイズ設定
extension CustomSizeExtension on num {
  /// custom r
  double get r => SizeExtension(this).r * (isPortrait ? 1 : 2.5);

  /// custom sp
  double get sp => SizeExtension(this).sp * (isPortrait ? 1 : 0.4);
}
