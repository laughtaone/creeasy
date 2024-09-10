import 'package:flutter/material.dart';
// サブタイトルのコンポーネント

Row titleTextComp({
  IconData? resvIcon,
  String resvText = '',
  double resvTextSize = 18,
}) {
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
          fontSize: resvTextSize,
        ),
      ),
    ],
  );
}