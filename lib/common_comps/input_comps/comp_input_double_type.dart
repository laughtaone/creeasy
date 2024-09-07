import 'package:flutter/material.dart';
import 'package:creeasy/COMMON_COMPS/input_double_formatter.dart';
// 入力フィールド(直接/整数と小数形式)単体


class compInputDoubleType extends StatefulWidget {
  final String? prefixText;             // 入力フィールドの文字列の前に表示する文字(※任意)
  final String? suffixText;             // 入力フィールドの文字列の後に表示する文字(※任意)
  final double? resvNowInputingDouble;     // 入力フィールドの初期値(※任意)
  final Function(String) argCallback;   // コールバック関数

  compInputDoubleType(
      {
        this.prefixText,
        this.suffixText,
        this.resvNowInputingDouble,
        required this.argCallback
      });

  @override
  _compInputDoubleTypeState createState() => _compInputDoubleTypeState();
}

class _compInputDoubleTypeState extends State<compInputDoubleType> {
  // -------------------------------- 変数処理 --------------------------------
  late TextEditingController _doubleInputted; // 新しく選択した要素のインデックス番号

  @override
  void initState() {
    super.initState();
    _doubleInputted = TextEditingController(text: (widget.resvNowInputingDouble != null) ? (widget.resvNowInputingDouble).toString() : '');

    // 入力が変更されたときにコールバックを呼び出すリスナーを追加
    _doubleInputted.addListener(() {
      widget.argCallback(_doubleInputted.text); // 入力されたテキストをコールバックで通知
    });
  }
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
      height: 70,
      child: TextField(
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 22,
        ),
        controller: _doubleInputted,
        decoration: InputDecoration(
          labelText: '',
          contentPadding: EdgeInsets.all(30),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixText: widget.prefixText,
          suffixText: widget.suffixText,
          fillColor: Color(0xfffefefe),
          filled: true,
        ),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          DecimalTextInputFormatter(),
          ZeroLimitFormatterForDouble(),
        ],
      ),
    );
  }
}