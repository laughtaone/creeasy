import 'package:flutter/material.dart';
// サブタイトルのコンポーネント

Padding titleTextComp({
  IconData? resvIcon,
  String resvText = '',
  double? resvTextSize,
  int? hTextType,         // 1:h1(20px), 2:h2(18px), 3:h3(16px), null:h2(18px) / ※resvTextSize が指定されている場合はそっちが優先される
  double customIconSize = 23,
  double customTopMargin = 2,
  double customBottomMargin = 2,
  FontWeight customFontWeight = FontWeight.w500,
  double customBetweenIT = 5,
}) {
  late double _finalTextSize;
  if (resvTextSize!=null) {
    _finalTextSize = resvTextSize;
  } else{
    switch (hTextType) {
      case 1:
        _finalTextSize = 21;
        break;
      case null || 2:
        _finalTextSize = 18;
        break;
      case 3:
        _finalTextSize = 16;
        break;
      default:
        throw ArgumentError('【An error I created】Invalid hTextType value: $hTextType. Allowed values are null, 1, 2, or 3.');
    }
  }

  return Padding(
    padding: EdgeInsets.only(top: customTopMargin, bottom: customBottomMargin),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        (resvIcon != null)
          ? Icon(resvIcon, size: customIconSize)
          : const SizedBox.shrink(),
        SizedBox(width: customBetweenIT),
        Flexible(
          child: Text(
            resvText,
            style: TextStyle(
              fontWeight: customFontWeight,
              fontSize: _finalTextSize,
            ),
          ),
        ),
      ],
    ),
  );
}