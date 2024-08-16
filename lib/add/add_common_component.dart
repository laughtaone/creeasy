import 'package:flutter/material.dart';

// 追加の各ページのサブタイトル
Row addButtonPageTitleText(IconData receivedIcon, String originalText) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(width: 2),
      Icon(
        receivedIcon,
        size: 23,
      ),
      SizedBox(width: 5),
      Text(
        originalText,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    ],
  );
}
