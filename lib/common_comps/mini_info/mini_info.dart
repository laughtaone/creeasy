import 'package:flutter/material.dart';
// 各選択フィールドの上の小さい注意書き

Container miniInfo(
    {String passText = '', // 表示するテキスト
    IconData customIcon = Icons.info_outline, // カスタムアイコン(カスタムしない場合はデフォ値のiマーク)
    bool needsIcon = true, // アイコンが必要かどうか
    Color doukaColor = const Color(0xffededed), // アイコンが不要な時に背景色と同じにして同化できる色
    bool needsTBPadding = true, // topとbottomに余白が必要か
    double customTextSize = 13, // テキストサイズ(デフォは13)
    Color customColor = Colors.black,
    bool placementCenter = false  // 中央寄せかどうか(デフォではfalse、すなわち中央寄せではない)
  }) {
  return Container(
    padding: EdgeInsets.only(
      left: 4,
      top: (needsTBPadding) ? 2 : 0,
      right: 7,
      bottom: (needsTBPadding) ? 2 : 0,
    ),
    child: Row(
      mainAxisAlignment: (!placementCenter) ? MainAxisAlignment.start : MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(2),
          child: Icon(
            customIcon,
            size: (customTextSize == 13) ? 15 : customTextSize * 1.1538,
            color: (needsIcon) ? customColor : doukaColor,
          ),
        ),
        SizedBox(width: 4),
        Flexible(
            child: Text(passText,
                style: TextStyle(
                  color: customColor,
                  fontSize: customTextSize,
                ))),
      ],
    ),
  );
}
