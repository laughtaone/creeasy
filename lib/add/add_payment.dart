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