import 'package:flutter/material.dart';
// サブタイトルのコンポーネント

Row titleTextComp({
  IconData? resvIcon,
  String resvText = '',
  double? resvTextSize,
  int? hTextType,         // 1:h1(20px), 2:h2(18px), 3:h3(16px), null:h2(18px) / ※resvTextSize が指定されている場合はそっちが優先される
}) {
  late double _finalTextSize;
  if (resvTextSize!=null) {
    _finalTextSize = resvTextSize;
  } else{
    switch (hTextType) {
      case 1:
        _finalTextSize = 20;
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


  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(width: 2),
      (resvIcon != null)
        ? Icon(
            resvIcon,
            size: 23,
          )
        : const SizedBox.shrink(),
      const SizedBox(width: 5),
      Text(
        resvText,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: _finalTextSize,
        ),
      ),
    ],
  );
}