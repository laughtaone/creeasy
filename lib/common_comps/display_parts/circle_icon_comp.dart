import 'package:flutter/material.dart';

// このコンポーエント使用時のimport文
// import 'package:creeasy/COMMON_COMPS/display_parts/circle_icon_comp.dart';

Container circleIconComp({
  double customCircleSize = 24,                           // 縦横サイズ
  double? customIconSize,                                 // アイコンサイズ
  IconData argIcon = Icons.emoji_emotions_outlined,       // アイコン
  Color customBackColor = Colors.white,                 // 丸内の背景色
}) {
  return Container(
    width: customCircleSize,
    height: customCircleSize,
    decoration: BoxDecoration(shape: BoxShape.circle, color: customBackColor),
    child: Icon(argIcon, size: (customIconSize==null) ?customCircleSize*0.55 :customIconSize)
  );
}

// Invalid constant value