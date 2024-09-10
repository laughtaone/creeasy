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
    String? customPlacement,  // 中央寄せかどうか(デフォではfalse、すなわち中央寄せではない)
    double customTopPadding = 2,
    double customBottomPadding = 2,
    bool needsLRPadding = true,
    double customIconTextPadding = 4
  }) {
  return Container(
    constraints: const BoxConstraints(
      minWidth: 0,
      minHeight: 0,
    ),
    padding: EdgeInsets.only(
      left: (needsLRPadding) ?4 :0,
      top: (needsTBPadding) ? customTopPadding : 0,
      right: (needsLRPadding) ?4 :7,
      bottom: (needsTBPadding) ? customBottomPadding : 0,
    ),
    child: Row(
      mainAxisAlignment:
        (customPlacement==null)
          ? MainAxisAlignment.start
          : ((customPlacement=='center')
            ? MainAxisAlignment.center
            : ((customPlacement=='end')
              ? MainAxisAlignment.end
              : MainAxisAlignment.start)),
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
        SizedBox(width: customIconTextPadding),
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
