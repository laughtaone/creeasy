import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:creeasy/main.dart';
import 'package:creeasy/add/add_common_component.dart';

class AddPaymentPage extends StatefulWidget {
  @override
  _AddPaymentPageState createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
  // ドロップダウンメニューで選択するアイテムのリスト
  final List<String> _items = ['三井住友カード', 'メルカード', 'ビューカード', 'PayPayカード'];
  // 選択されたアイテムを保持する変数
  String? _selectedItem;

  final TextEditingController _controller = TextEditingController();

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
            // TextField(
            //   controller: _controller,
            //   decoration: InputDecoration(
            //     labelText: 'カードでの支払い金額をそのまま入力',
            //     border: OutlineInputBorder(),
            //   ),
            //   keyboardType: TextInputType.number,
            //   inputFormatters: [
            //     FilteringTextInputFormatter.digitsOnly,
            //     SingleZeroInputFormatter(),
            //   ],
            // )
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
    TextEditingValue oldValue,      // 以前のテキストフィールドの値
    TextEditingValue newValue,      // ユーザーが入力した新しい値
  ) {

    // ユーザーが入力した新しい値が0 and 文字数が1　の場合
    if (newValue.text == '0' && newValue.text.length == 1) {
      return newValue;
    }
    // ユーザーが入力した新しい値が0 and 文字数が2以上　の場合
    if (newValue.text.contains('0') && newValue.text.length > 1) {
      return oldValue;
    }
    // それ以外の場合
    return newValue;
  }
}