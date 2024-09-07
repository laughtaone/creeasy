import 'package:flutter/material.dart';
// 入力フィールド(直接/文字列)単体


class compInputStringType extends StatefulWidget {
  final TextEditingController stringInputted;

  compInputStringType({required this.stringInputted});

  @override
  _compInputStringTypeState createState() => _compInputStringTypeState();
}

class _compInputStringTypeState extends State<compInputStringType> {
  // -------------------------------- 変数処理 --------------------------------
  late TextEditingController _stringInputted; // 新しく選択した要素のインデックス番号

  @override
  void initState() {
    super.initState();
    _stringInputted = widget.stringInputted; // 初期化処理
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