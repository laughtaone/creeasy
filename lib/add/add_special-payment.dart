import 'package:flutter/material.dart';
import 'package:creeasy/main.dart';
import 'package:creeasy/add/add_common_component.dart';
import 'package:flutter/services.dart';



class AddSpecialPaymentPage extends StatefulWidget {
  @override
  _AddSpecialPaymentPageState createState() => _AddSpecialPaymentPageState();
}


class _AddSpecialPaymentPageState extends State<AddSpecialPaymentPage> {
  // ドロップダウンメニューで選択するアイテムのリスト
  final List<String> _items = [
    '三井住友カード',
    'メルカード',
    'ビューカード',
    'PayPayカード',
    'LINEクレカ(P+)',
    'エポスカード'
  ];

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
            Icon(
              Icons.account_balance,
              color: Colors.black
            ),
            SizedBox(width: 5),
            Text(
              '臨時支払いを追加',
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
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // Themeから色を取得
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.only(left: 17, right: 17, top: 10),
          child: ListView(
            children: [
              // ========================================== ①該当カード選択 ==========================================
              SizedBox(height: 5),
              Container(
                padding:
                    EdgeInsets.only(left: 9, right: 9, top: 15, bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffededed),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addButtonPageTitleText(
                      Icons.credit_card_outlined, '該当カードを選択'
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          fixedSize: Size(double.infinity, 70),
                          backgroundColor: Color(0xfffefefe),
                        ),
                        child: ListTile(
                          title: Text('${_selectedItem ?? '未選択'}',
                              style: TextStyle(fontSize: 20)),
                          trailing: Icon(Icons.edit),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('支払いカードを選択：'),
                                backgroundColor: Color(0xffffffff),
                                content: Container(
                                  width: double.maxFinite,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    // color: Color(0xffdddddd),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Scrollbar(
                                      thumbVisibility: true,
                                      thickness: 2,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: _items.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                top: 5, bottom: 5, right: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              color: Color(0xffeeeeee),
                                            ),
                                            child: ListTile(
                                              title: Text(_items[index],
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              onTap: () {
                                                setState(() {
                                                  _selectedItem = _items[index];
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      'キャンセル',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // ====================================================================================================

              // =============================================== ②臨時支払い金額 ==============================================
              betweenAddPaymentSection(),
              Container(
                padding:
                    EdgeInsets.only(left: 9, right: 9, top: 15, bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffededed),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addButtonPageTitleText(
                        Icons.currency_yen_outlined, '臨時支払い金額を入力'),
                    Container(
                      margin: EdgeInsets.all(5),
                      height: 70,
                      child: TextField(
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                        ),
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: '',
                          contentPadding: EdgeInsets.all(30),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixText: '¥　',
                          fillColor: Color(0xfffefefe),
                          filled: true,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          ZeroLimitFormatter(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // ====================================================================================================

              // =============================================== ③臨時支払い日 ==============================================
              betweenAddPaymentSection(),
              Container(
                padding:
                    EdgeInsets.only(left: 9, right: 9, top: 15, bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffededed),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addButtonPageTitleText(Icons.event_outlined, '臨時支払い日を入力'),
                    Container(
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
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // ====================================================================================================



              SizedBox(height: 80),

              // =============================================== 保存ボタン ==============================================
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                height: 57,
                child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              '本当に保存しますか？',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('キャンセル',
                                    style: TextStyle(color: Colors.red)),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('保存'),
                              ),
                            ],
                          );
                      });
                    },
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xfffff3f3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        side: BorderSide(
                          color: Color(0xffff7777),
                          width: 1.7,
                        )),
                    child: Text(
                      '保存して閉じる',
                      style: TextStyle(color: Color(0xffff7777), fontSize: 16),
                    )),
              ),
              // =======================================================================================================

              SizedBox(height: 12),
              Text(
                '保存せずに閉じるには右上の×ボタンを押してください',
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.black38,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),

            ],
          ),
        ),
      )
    );
  }
}




