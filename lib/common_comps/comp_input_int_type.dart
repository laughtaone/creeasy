import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:creeasy/common_comps/zero_limit_formatter.dart';

// 入力フィールド(直接/整数形式)単体


class compInputIntType extends StatefulWidget {
  final TextEditingController intInputted;
  final String? prefixText; // 入力フィールドの文字列の前に表示する文字(※任意)
  final String? suffixText; // 入力フィールドの文字列の後に表示する文字(※任意)

  compInputIntType(
      {required this.intInputted, this.prefixText, this.suffixText});

  @override
  _compInputIntTypeState createState() => _compInputIntTypeState();
}

class _compInputIntTypeState extends State<compInputIntType> {
  // -------------------------------- 変数処理 --------------------------------
  late TextEditingController _intInputted; // 新しく選択した要素のインデックス番号

  @override
  void initState() {
    super.initState();
    _intInputted = widget.intInputted; // 初期化処理
  }
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      height: 70,
      child: TextField(
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 22,
        ),
        controller: _intInputted,
        decoration: InputDecoration(
          labelText: '',
          contentPadding: EdgeInsets.all(30),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixText: widget.prefixText,
          suffixText: widget.suffixText,
          fillColor: Color.fromARGB(255, 25, 22, 22),
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