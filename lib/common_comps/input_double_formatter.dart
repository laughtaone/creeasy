import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// 整数と小数だけを受け付ける入力フィールド(例：「還元率を入力」)で正常に入力できるようにするクラス

// 整数と小数を受け取るフォーマッター
class DecimalTextInputFormatter extends TextInputFormatter {
  final RegExp _regExp = RegExp(r'^\d*\.?\d*');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (_regExp.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}

// 整数と小数だけを受け付ける入力フィールドで、最初に0を1つしか最初に入力できないようにするもの
class ZeroLimitFormatterForDouble extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 新しい値が空の場合、そのまま新しい値を返す
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // '0' のみは許可
    if (newValue.text == '0') {
      return newValue;
    }

    // '0.' で始まる場合も許可
    if (newValue.text == '0.') {
      return newValue;
    }

    // '0' で始まるが、その後に数字が続く場合は最初の '0' を削除
    if (newValue.text.startsWith('0') && !newValue.text.startsWith('0.')) {
      return oldValue;
    }

    // 小数点を含む数値を許可
    final double? value = double.tryParse(newValue.text);
    if (value == null || value < 0) {
      return oldValue;
    }

    return newValue;
  }
}