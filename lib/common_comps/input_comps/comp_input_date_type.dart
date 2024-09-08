import 'package:flutter/material.dart';
// 入力フィールド(日付/ダイアログ形式)単体


class compInputDateType extends StatefulWidget {
  final DateTime? resvNowInputingDate;     // 入力フィールドの初期値(※任意)
  final String? dialogText;
  final Function(DateTime) argCallback; // コールバック関数

  compInputDateType(
      {
        this.resvNowInputingDate,
        this.dialogText,              // 例えば「◯◯の選択：」のようにダイアログ表示時のテキスト
        required this.argCallback
      });

  @override
  _compInputDateTypeState createState() => _compInputDateTypeState();
}

class _compInputDateTypeState extends State<compInputDateType> {
  // -------------------------------- 変数処理 --------------------------------
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.resvNowInputingDate;

  //   // 入力が変更されたときにコールバックを呼び出すリスナーを追加
  //   _selectedDate.addListener(() {
  //     widget.argCallback(_selectedDate); // 入力されたテキストをコールバックで通知
  //   });
  }
  // -------------------------------------------------------------------------




  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          fixedSize: Size(double.infinity, 70),
          backgroundColor: Color(0xfffefefe),
        ),
        child: ListTile(
          title: Text(
            _selectedDate == null
                ? '未選択'
                : '${_selectedDate?.year}年${_selectedDate?.month}月${_selectedDate?.day}日',
            style: TextStyle(fontSize: 20),
          ),
          trailing: Icon(Icons.edit),
        ),
        onPressed: () async {
          DateTime? date = await showDatePicker(
            context: context,
            locale: const Locale("ja"),
            initialDate: _selectedDate ?? DateTime.now(),
            firstDate: DateTime(2023, 1, 1),
            lastDate: DateTime.now(),
          );
          if (date != null) {
            setState(() {
              _selectedDate = date;
            });
            widget.argCallback(date); // コールバックで選択された日付を渡す
          }
        },
      ),
    );
  }
}
