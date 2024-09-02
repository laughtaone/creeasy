import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:creeasy/main.dart';
import 'package:creeasy/add/add_common_component.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:creeasy/add/add_payment_option_button/add_payment_option_button.dart';

class AddPaymentPage extends StatefulWidget {
  @override
  _AddPaymentPageState createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
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

  final TextEditingController _storeName =
      TextEditingController(); // ④で入力された使用場所を保持する変数

  var _isExcluded = false; // ⑤でポイント進呈対象外かどうかの真偽値を保持する変数（true: 進呈対象外）
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
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.only(left: 17, right: 17, top: 10),
          child: ListView(
            children: [
              // ========================================== ①支払いカード選択 ==========================================
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
                        Icons.credit_card_outlined, '支払いカードを選択'),
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

              // =============================================== ②金額 ==============================================
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
                        Icons.currency_yen_outlined, '金額を入力'),
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

              // =============================================== ③日付 ==============================================
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
                    addButtonPageTitleText(Icons.event_outlined, '使用日を入力'),
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

              // =============================================== ④使用場所 ==============================================
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
                        Icons.location_on_outlined, '使用場所を入力'),
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 70,
                      child: TextField(
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                        ),
                        controller: _storeName,
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
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.digitsOnly,
                        // ],
                      ),
                    ),
                  ],
                ),
              ),
              // =======================================================================================================

              // =============================================== ⑤オプション ==============================================
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
                        Icons.auto_fix_high_outlined, 'オプション'),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          // ========================= 「還元率?%」の長方形  =========================
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Color(0xffdddddd),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('現在の還元率：',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17)),
                                Text('1%',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22))
                              ],
                            ),
                          ),
                          // ====================================================================

                          SizedBox(height: 12),

                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 18,
                              ),
                              SizedBox(width: 3),
                              Text(
                                '支払いにより還元率が異なるため詳細を入力',
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),


                          SizedBox(height: 12),

                          // =========================== 選択フィールド  ===========================
                          Row(
                            children: [
                              Expanded(
                                child: OptionTextButton(
                                  upperText: 'ポイント\n進呈',
                                  trueLowerText: '対象',
                                  falseLowerText: '対象外',
                                  initialBoolLowerText: true,
                                ),
                              ),
                              Expanded(
                                child: OptionTextButton(
                                  upperText: 'VPU\nプログラム',
                                  trueLowerText: '対象',
                                  falseLowerText: '対象外',
                                  initialBoolLowerText: false,
                                ),
                              ),
                              Expanded(
                                child: OptionTextButton(
                                  upperText: 'LINE Pay\n経由',
                                  trueLowerText: '対象',
                                  falseLowerText: '対象外',
                                  initialBoolLowerText: false,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // =======================================================================================================

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

TextStyle selectFieldUpTextStyle(double doubleFontSize, Color receivedColor) {
  if (doubleFontSize == 0) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: receivedColor,
    );
  } else {
    return TextStyle(
      fontSize: doubleFontSize,
      fontWeight: FontWeight.bold,
      color: receivedColor,
    );
  }
}

SizedBox betweenAddPaymentSection() {
  return SizedBox(height: 20);
}
