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


// ↓ 下のこれで利用
// 各選択フィールドの上の小さい注意書きの文字スタイルを一括指定
Container miniInfo({
    String passText='',     // 表示するテキスト
    IconData customIcon = Icons.info_outline,  // カスタムアイコン(カスタムしない場合はデフォ値のiマーク)
    bool needsIcon = true,   // アイコンが必要かどうか
    bool needsTBPadding = true,   // topとbottomに余白が必要か
    double customTextSize = 13,    // テキストサイズ(デフォは13)
    Color customColor = Colors.black
  }) {
  return Container(
    padding: EdgeInsets.only(
      left: 4,
      top: (needsTBPadding) ? 2 : 0,
      right: 7,
      bottom: (needsTBPadding) ? 2 : 0,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(2),
          child: Icon(
            customIcon,
            size: (customTextSize==13) ? 15 : customTextSize*1.1538,
            color: (needsIcon) ? customColor : Color(0xffededed),
          ),
        ),
        SizedBox(width: 4),
        Flexible(child: Text(
          passText,
          style: TextStyle(
            color: customColor,
            fontSize: customTextSize,
          )
        )),
      ],
    ),
  );
}

// --------------------------------------------------------------------------------------------------------------------------


