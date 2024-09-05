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

// 「②金額を入力」の入力フィールドで0を連続して入力できないようにするクラス
// 整数だけを受け付ける入力フィールドで、最初に0を1つしか最初に入力できないようにするもの
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

// ------------------------------- card_manage/add_card/add_card_direct-input-card.dartで使用 -------------------------------
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

// 前述したページの「還元率を入力」の入力フィールドで0を連続して入力できないようにするクラス
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

// 各選択フィールドの上の小さい注意書きの文字スタイルを一括指定
TextStyle miniInfoTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 13,
);
// ↓ 下のこれで利用
// 各選択フィールドの上の小さい注意書きの文字スタイルを一括指定
// 「\i/　ああああ」のように一行だけなら isSingleLine=true(デフォルト値でtrueと設定済)
// 複数行あるならmain→sub→last
// ||top|bottom
// |---|---|---|---|---|---|---|
// |main|2|0|
// |sub|0|0|
// |last|0|2|
Container miniInfo({String isSingleLine = 'true', String passText=''}) {
  return Container(
    padding: EdgeInsets.only(
      top: (isSingleLine== 'main') ? 2 : 0,
      bottom: (isSingleLine== 'last') ? 2 : 0,
      left: 4,
      right: 7
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.info_outline,
          size: 15,
          color: (isSingleLine=='true' || isSingleLine=='main') ? Colors.black : Color(0xffededed),
        ),
        SizedBox(width: 4),
        Flexible(child: Text(passText, style: miniInfoTextStyle)),
      ],
    ),
  );
}

// --------------------------------------------------------------------------------------------------------------------------


