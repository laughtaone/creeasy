import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';


// 追加の各ページのサブタイトル
Row addButtonPageTitleText({
    IconData? resvIcon,
    String resvText = '',
    double resvTextSize = 18,
  }) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(width: 2),
      (resvIcon != null)
      ? Icon(
        resvIcon,
        size: 23,
      )
      : SizedBox.shrink(),
      SizedBox(width: 5),
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

SizedBox betweenAddPaymentSection({double customHeight = 20}) {
  return SizedBox(height: customHeight);
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


// ---------------------------------------- 各選択フィールドの上の小さい注意書き ----------------------------------------
Container miniInfo({
    String passText='',     // 表示するテキスト
    IconData customIcon = Icons.info_outline,  // カスタムアイコン(カスタムしない場合はデフォ値のiマーク)
    bool needsIcon = true,   // アイコンが必要かどうか
    Color doukaColor = const Color(0xffededed),   // アイコンが不要な時に背景色と同じにして同化できる色
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
            color: (needsIcon) ? customColor : doukaColor,
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



// ------------------------------- card_manage/add_card/add_card_preset-card.dartで使用 -------------------------------
class OptionTextButtonOneLine extends StatefulWidget {
  final List textList;
  final Function(int?) onItemSelected;
  final double textFontSize;

  OptionTextButtonOneLine({
    required this.textList,
    required this.onItemSelected,
    this.textFontSize = 15,        // textFonSizeだけデフォ値を設定
  });

  @override
  _OptionTextButtonOneLineState createState() => _OptionTextButtonOneLineState();
}

class _OptionTextButtonOneLineState extends State<OptionTextButtonOneLine> {
  int? selectedIndex; // 選択中の要素のインデックス

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.textList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: (index==0) ? 0 : 7, bottom: 7, right: 10, left: 10),
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size(130, 58),
                backgroundColor: (selectedIndex == index)
                  ? Color(0xffdedede)
                  : Color(0xfffefefe),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ).copyWith(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onItemSelected(index);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    color: (selectedIndex == index) ? Colors.black : Colors.white,
                  ),
                  SizedBox(width: 6),
                  Text(
                    widget.textList[index],
                    style: TextStyle(
                      fontSize: widget.textFontSize,
                      color: Color(0xff444444),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
// --------------------------------------------------------------------------------------------------------------------------



// --------------------------------------------------- URLを受け取り画面遷移 ---------------------------------------------------
Future viewWebsite(String recvUrl) async {
  final url = Uri.parse(recvUrl);
  launchUrl(url);
}
// --------------------------------------------------------------------------------------------------------------------------



// ------------------------------------------- 末尾の「こちら」で画面遷移できるminiInfoEndJump -------------------------------------------
Container miniInfoEndJump({
    String passText='',     // 表示するテキスト
    IconData customIcon = Icons.info_outline,  // カスタムアイコン(カスタムしない場合はデフォ値のiマーク)
    bool needsIcon = true,   // アイコンが必要かどうか
    Color doukaColor = const Color(0xffededed),      // アイコンが不要な時に背景色と同じにして同化できる色
    bool needsTBPadding = true,   // topとbottomに余白が必要か
    double customTextSize = 13,    // テキストサイズ(デフォは13)
    Color customColor = Colors.black,
    String passUrl = '',     // 遷移したいURL
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
            color: (needsIcon) ? customColor : doukaColor,
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
        SizedBox(width: 2),
        RichText(
          text: TextSpan(children: [
            WidgetSpan(
              child: GestureDetector(
                onTap: () {
                  // VPAPの公式サイトへ遷移
                  viewWebsite(passUrl);
                },
                child: Text(
                  'こちら',
                  style: TextStyle(
                    color: Colors.indigo[500],
                    // decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
          ])
        ),
      ],
    ),
  );
}
// --------------------------------------------------------------------------------------------------------------------------


