import 'package:flutter/material.dart';
import 'package:creeasy/card_manage/add_card/add_card_preset-card.dart';
import 'package:creeasy/card_manage/add_card/add_card_direct-input-card.dart';

class AddCardPage extends StatefulWidget {
  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  // ドロップダウンメニューで選択するアイテムのリスト
  final List<String> _items = [
    '三井住友カード',
    'メルカード',
    'ビューカード',
    'PayPayカード',
    'LINEクレカ(P+)',
    'エポスカード',
    'auPAYカード',
    'dカード'
  ];

  // ================================ 変数処理 ================================
  String? _selectedItem; // ①で選択されたカードを保持する変数
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
            Icon(Icons.add_card_outlined, color: Colors.black),
            SizedBox(width: 5),
            Text(
              'カードを追加',
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
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.only(left: 17, right: 17, top: 10),
          child: ListView(
            children: [
              // ========================================== ①支払いカード選択 ==========================================
              SizedBox(height: 10),
              Text(r'\\まずはプリセットに用意されているかチェック//',
                  style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center),
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
                    titleText(Icons.credit_card_outlined, '追加するカードを選択'),
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
                                title: Text(
                                  'プリセットされたカード一覧：',
                                  style: TextStyle(fontSize: 18),
                                ),
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
                                                top: 5,
                                                bottom: 5,
                                                right: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              color: Color(0xffeeeeee),
                                            ),
                                            child: ListTile(
                                              title: Text(_items[index],
                                                  style: TextStyle(
                                                      fontSize: 18)),
                                              onTap: () {
                                                setState(() {
                                                  _selectedItem =
                                                      _items[index];
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

              SizedBox(height: 20),

              // =============================================== 「次へ」ボタン ==============================================
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                height: 57,
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddCardPagePresetCard(selectedCardName: _selectedItem),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Color(0xff333333),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // side: BorderSide(
                      //   color: Color(0xffff7777),
                      //   width: 1.7,
                      // )
                    ),
                    child: Text(
                      '次へ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    )),
              ),
              // =======================================================================================================

              SizedBox(height: 16),

              // =============================================== 「直接入力」ボタン ==============================================
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                height: 57,
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddCardPageDirectInputCard(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xffeeeeee),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        side: BorderSide(
                          color: Color(0xff888888),
                          width: 1.3,
                        )),
                    child: Text(
                      'プリセットされていないため直接入力',
                      style: TextStyle(
                          color: Color(0xff888888),
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    )),
              ),
              // =======================================================================================================

              SizedBox(height: 10),

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
        )
      )
    );
  }
}

// タイトルコンポーネント(このページ内のみで使用)
Row titleText(IconData receivedIcon, String originalText) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(width: 2),
      Icon(
        receivedIcon,
        size: 23,
      ),
      SizedBox(width: 5),
      Text(
        originalText,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    ],
  );
}
