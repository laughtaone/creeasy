import 'package:flutter/services.dart';

// 整数だけを受け付ける入力フィールド(例：「金額を入力」)で最初に0を1つしか入力できないようにするクラス
class ZeroLimitFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 新しい値が空の場合、そのまま新しい値を返す
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // 数値が '0' ならそのまま許可（最初の入力として）
    if (newValue.text == '0') {
      return newValue;
    }

    // '0' で始まるが、'0'単独ではない場合は前の値に戻す
    if (newValue.text.startsWith('0') && newValue.text.length > 1) {
      return oldValue;
    }

    // 整数に変換して0以上の値のみ許可
    final int? value = int.tryParse(newValue.text);
    if (value == null || value < 0) {
      return oldValue;
    }

    return newValue;
  }
}