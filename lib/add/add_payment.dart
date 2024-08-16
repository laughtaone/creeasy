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
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: ListView(
            children: [
              // ========================================== ①支払いカード選択 ==========================================
              SizedBox(height: 5),
              addButtonPageTitleText('① 支払いカードを選択'),
              Container(
                margin: EdgeInsets.all(10),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fixedSize: Size(double.infinity, 70)),
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
                                        borderRadius: BorderRadius.circular(7),
                                        color: Color(0xffeeeeee),
                                      ),
                                      child: ListTile(
                                        title: Text(_items[index],
                                            style: TextStyle(fontSize: 18)),
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
              // ====================================================================================================

              // =============================================== ②金額 ==============================================
              SizedBox(height: 10),
              addButtonPageTitleText('② 金額を入力'),
              Container(
                margin: EdgeInsets.all(10),
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
                      prefixText: '¥　'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    ZeroLimitFormatter(),
                  ],
                ),
              ),
              // ====================================================================================================

              // =============================================== ③日付 ==============================================
              SizedBox(height: 10),
              addButtonPageTitleText('③ 使用日を入力'),
              Container(
                margin: EdgeInsets.all(10),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fixedSize: Size(double.infinity, 70)),
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
              // ====================================================================================================

              // =============================================== ④使用場所 ==============================================
              SizedBox(height: 10),
              addButtonPageTitleText('④ 使用場所を入力'),
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
                  ),
                  keyboardType: TextInputType.text,
                  // inputFormatters: [
                  //   FilteringTextInputFormatter.digitsOnly,
                  // ],
                ),
              ),
              // =======================================================================================================

              // =============================================== ⑤オプション ==============================================
              SizedBox(height: 10),
              addButtonPageTitleText('⑤ オプション'),
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    // ========================= 「還元率?%」の長方形  =========================
                    Container(
                      height: 60,
                      // width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffeeeeee),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('現在の還元率：',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17)),
                          Text('1%',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22))
                        ],
                      ),
                    ),
                    // ====================================================================

                    SizedBox(height: 10),

                    // =========================== 選択フィールド  ===========================
                    TextButton(
                      style: TextButton.styleFrom(
                          fixedSize: Size(120, 120),
                          backgroundColor: Color(0xffdfdfdf),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Column(
                          children: [
                            // ===================== 上部分 =====================
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('ポイント',
                                      style: selectFieldUpTextStyle(17,Color(0xff444444))),
                                  Text('進呈', style: selectFieldUpTextStyle(17,Color(0xff444444)))
                                ],
                              ),
                            ),
                            // =================================================

                            // ===================== 下部分 =====================
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          '対象',
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30)
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'タップで変更',
                                          style: TextStyle(fontSize: 9, color: Color(0xff999999), fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // =================================================
                          ],
                        ),
                      ),
                      onPressed: null,
                    ),
                    // =====================================================================
                  ],
                ),
                // child: Row(
                //   children: [
                //     // ========================= 「還元率?%」の正方形  =========================
                //     Expanded(
                //       flex: 1,
                //       child: Container(
                //         height: 80,
                //         width: 80,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(12),
                //           color: Color(0xffdddddd),
                //         ),
                //         child: Center(
                //           child: Column(
                //             mainAxisSize: MainAxisSize.min,
                //             children: [
                //               Text('還元率', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                //               Text('1%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17))
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //     // =========================================================================

                //     // ============================ チェックマーク部分  ============================
                //     SizedBox(width: 7),
                //     Expanded(
                //       flex: 3,
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: [
                //           Container(
                //             child: CheckboxListTile(
                //               // activeColor: Colors.blue,
                //               // title: Text('ポイント進呈対象外'),
                //               title: Transform.translate(
                //                 offset: Offset(-12, 0), // ここで間隔を調整
                //                 child: Text('ポイント進呈対象外'),
                //               ),
                //               // contentPadding: EdgeInsets.symmetric(horizontal: 0),
                //               subtitle: Text('チェックで対象外、未チェックで対象', style: TextStyle(fontSize: 9),),
                //               controlAffinity: ListTileControlAffinity.leading,
                //               value: _isExcluded,
                //               onChanged: (newValue) {
                //                 setState(() {
                //                   _isExcluded = newValue!;
                //                 });
                //               },
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     // =========================================================================
                //   ],
                // ),
              ),

              // =======================================================================================================
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
