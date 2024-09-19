import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:creeasy/COMMON_COMPS/formatter/zero_limit_formatter.dart';
// 入力フィールド(直接/整数形式)単体
// import文：import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_int_type.dart';


class compInputIntType extends StatefulWidget {
  final String? prefixText; // 入力フィールドの文字列の前に表示する文字(※任意)
  final String? suffixText; // 入力フィールドの文字列の後に表示する文字(※任意)
  final int? resvNowInputingInt;     // 入力フィールドの初期値(※任意)
  final Function(String) argCallback; // コールバック関数

  const compInputIntType(
      {super.key, 
        this.prefixText,
        this.suffixText,
        this.resvNowInputingInt,
        required this.argCallback
      });

  @override
  _compInputIntTypeState createState() => _compInputIntTypeState();
}


class _compInputIntTypeState extends State<compInputIntType> {
  // -------------------------------- 変数処理 --------------------------------
  late TextEditingController _intInputted; // 新しく選択した要素のインデックス番号

  @override
  void initState() {
    super.initState();
    _intInputted = TextEditingController(text: (widget.resvNowInputingInt != null) ? (widget.resvNowInputingInt).toString() : '');

    // 入力が変更されたときにコールバックを呼び出すリスナーを追加
    _intInputted.addListener(() {
      widget.argCallback(_intInputted.text); // 入力されたテキストをコールバックで通知
    });
  }
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: 70,
      child: TextField(
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 22,
        ),
        controller: _intInputted,
        decoration: InputDecoration(
          hintText: '未入力',
          hintStyle: const TextStyle(fontSize: 20),
          contentPadding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixText: widget.prefixText,
          suffixText: widget.suffixText,
          fillColor: const Color(0xfffefefe),
          filled: true,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          ZeroLimitFormatter(),
        ],
      ),
    );
  }
}