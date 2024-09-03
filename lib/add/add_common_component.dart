import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter/services.dart';


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


// ②金額を入力の入力フィールドで0を連続して入力できないようにするクラス
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

TextStyle selectFieldUpTextStyle(double doubleFontSize, Color receivedColor) {
  if (doubleFontSize == 0) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: receivedColor,
    );
  } else {
    return TextStyle(
      fontSize: doubleFontSize,
      fontWeight: FontWeight.bold,
      color: receivedColor,
    );
  }
}

SizedBox betweenAddPaymentSection() {
  return SizedBox(height: 20);
}
