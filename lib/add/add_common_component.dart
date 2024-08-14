import 'package:flutter/material.dart';


// 追加の各ページのサブタイトル
Text addButtonPageTitleText(String originalText) {
  // 元のテキストの内容を取得
  String textContent = originalText;

  // 新しいTextウィジェットを生成
  return Text(
    textContent,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18
    )
  );
}
