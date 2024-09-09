import 'package:flutter/material.dart';
// 入力フィールド(直接/文字列形式)単体



class compInputStringType extends StatefulWidget {
  final String? resvNowInputingString;     // 入力フィールドの初期値(※任意)
  final Function(String) argCallback; // コールバック関数

  compInputStringType(
      {
        this.resvNowInputingString,
        required this.argCallback
      });

  @override
  _compInputStringTypeState createState() => _compInputStringTypeState();
}

class _compInputStringTypeState extends State<compInputStringType> {
  // -------------------------------- 変数処理 --------------------------------
  late TextEditingController _stringInputted; // 新しく選択した要素のインデックス番号

  @override
  void initState() {
    super.initState();
    _stringInputted = TextEditingController(text: (widget.resvNowInputingString != null) ? (widget.resvNowInputingString).toString() : '');

    // 入力が変更されたときにコールバックを呼び出すリスナーを追加
    _stringInputted.addListener(() {
      widget.argCallback(_stringInputted.text); // 入力されたテキストをコールバックで通知
    });
  }
  // -------------------------------------------------------------------------


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 70,
      child: TextField(
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 22,
        ),
        controller: _stringInputted,
        decoration: InputDecoration(
          labelText: '',
          contentPadding: EdgeInsets.all(30),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: Color(0xfffefefe),
          filled: true,
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
