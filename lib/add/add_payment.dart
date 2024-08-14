import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:creeasy/main.dart';
import 'package:creeasy/add/add_common_component.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class AddPaymentPage extends StatefulWidget {
  @override
  _AddPaymentPageState createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
  // ドロップダウンメニューで選択するアイテムのリスト
  final List<String> _items = ['三井住友カード', 'メルカード', 'ビューカード', 'PayPayカード'];

  // ================================ 変数処理 ================================
  String? _selectedItem; // ①で選択されたカードを保持する変数
  final TextEditingController _controller =
      TextEditingController(); // ②で入力された金額を保持する変数
  DateTime? _selectedDate; // ③で入力された日付を保持する変数
  // =========================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.credit_score_outlined, color: Colors.black),
            SizedBox(width: 5),
            Text(
              '利用履歴を追加',
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ))
        ],
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor, // Themeから色を取得
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: ListView(
          children: [
            // ========================================== ①支払いカード選択 ==========================================
            SizedBox(height: 5),
            addButtonPageTitleText('① 支払いカードを選択'),
            DropdownButton<String>(
              value: _selectedItem,
              hint: Text('Select an item'),
              items: _items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedItem = newValue;
                });
              },
            ),
            // ====================================================================================================

            // =============================================== ②金額 ==============================================
            SizedBox(height: 10),
            addButtonPageTitleText('② 金額を入力'),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'カードでの支払い金額をそのまま入力',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                ZeroLimitFormatter(),
              ],
            ),
            // ====================================================================================================

            // =============================================== ③日付 ==============================================
            SizedBox(height: 10),
            addButtonPageTitleText('③ 使用日を入力'),
            if (_selectedDate != null)
              Text(
                '選択された日付: ${_selectedDate!.toLocal().toString().split(' ')[0]}', // 日付のフォーマットを変更
              ),
            TextButton(
              onPressed: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2023, 1, 1),
                    maxTime: DateTime.now(), // 今日
                    onChanged: (date) {
                  print(date);
                }, onConfirm: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                }, currentTime: DateTime.now(), locale: LocaleType.jp);
              },
              child: const Text(
                '日付を選択',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            // ====================================================================================================
          ],
        ),
      ),
    );
  }
}

// ②金額を入力の入力フィールドで0を連続して入力できないようにするクラス
class ZeroLimitFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // 以前のテキストフィールドの値
    TextEditingValue newValue, // ユーザーが入力した新しい値
  ) {
    print('oldValueは　$oldValue');
    print('newValueは　$newValue');
    // print(newValue.text.runtimeType);

    if (oldValue.text.length == 1 && oldValue.text[0] == '0') {
      // 「0」が入力されていて
      if (newValue.text == '') {
        // 「0」が入力されていて、その0を消そうとした時
        print('条件分岐1');
        print('');
        return newValue;
      } else if (newValue.text != '' && newValue.text != '0') {
        return newValue;
      } else {
        // 「0」が入力されていて、その0の後ろに数字を追加しようとした時
        print('条件分岐2');
        print('');
        return oldValue;
      }
    } else if (oldValue.text == '') {
      // 何も入力されていなくて、何か数字を入れようとした時
      print('条件分岐3');
      print('');
      return newValue;
    } else if (oldValue.text.isNotEmpty &&
        oldValue.text[0] != 0 &&
        newValue.text[0] == '0') {
      // 「0」以外の数字が入力されていて
      if (newValue.text.length == 1) {
        // 「0」以外の数字が入力されていて、oldTextを全選択して0にしようとした時
        return newValue;
      } else {
        // 「0」以外の数字が入力されていて、先頭に0を入れようとした時
        return oldValue;
      }
      // 先頭に0を入れようとした時
      print('条件分岐4');
      print('');
      return oldValue;
    } else {
      print('条件分岐5');
      print('');
      return newValue;
    }

    // // ユーザーが入力した新しい値が0 and 文字数が1　の場合
    // if (newValue.text == '0' && newValue.text.length == 1) {
    //   print('条件分岐1');
    //   print('');
    //   return newValue;
    // }
    // // ユーザーが入力した新しい値が0 and 文字数が2以上　の場合
    // if (newValue.text.contains('0') && newValue.text.length > 1) {
    //   print('条件分岐2');
    //   print('');
    //   return oldValue;
    // }
    // // それ以外の場合
    // print('条件分岐3');
    // print('');
    // return newValue;
  }
}
