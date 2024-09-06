import 'package:flutter/material.dart';
import 'package:creeasy/card_manage/add_card/add_card_preset-card.dart';
import 'package:creeasy/card_manage/add_card/add_card_direct-input-card.dart';
import 'package:creeasy/add/common_component.dart';
import 'package:creeasy/card_manage/add_bank/select_bank-type_component.dart';

class AddBankPage extends StatefulWidget {
  @override
  _AddBankPageState createState() => _AddBankPageState();
}

class _AddBankPageState extends State<AddBankPage> {
  // ドロップダウンメニューで選択するアイテムのリスト
  final List<String> _bankList = [
    'みんなの銀行',
    '三菱UFJ銀行',
    '三井住友銀行',
  ];

  final List<String> _bankTypeList = [
    '通常口座',
    '口座内のボックス',
  ];

  // ================================ 変数処理 ================================
  final TextEditingController _bankName =
      TextEditingController(); // ①で入力された銀行名を保持する変数
  int? selectedItemIndexNum;

  void _onItemSelected(int? index) {
    setState(() {
      selectedItemIndexNum = index;
    });
    print("Selected index: $selectedItemIndexNum");
  }

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
              Icon(Icons.account_balance_outlined, color: Colors.black),
              SizedBox(width: 5),
              Text(
                '銀行を追加',
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
                  // =============================================== ①銀行名 ==============================================
                  betweenSelectField(),
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
                        addButtonPageTitleText(resvIcon: Icons.account_balance_outlined, resvText:'銀行名を入力'),
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 70,
                          child: TextField(
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                            ),
                            controller: _bankName,
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

                  SizedBox(height: 20),

                  // =============================================== ②銀行タイプ ==============================================
                  betweenSelectField(),
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
                        addButtonPageTitleText(resvIcon: Icons.local_offer_outlined, resvText:'銀行のタイプを選択'),
                        SizedBox(height: 3),
                        miniInfo(passText: '通常口座は、一般的なただの銀行の口座を指します'),
                        miniInfo(needsIcon: false, passText: '（例：三井住友銀行 普通口座 ??支店 XXXXXXX）'),
                        SizedBox(height: 5),
                        miniInfo(passText: '口座内のボックスは、口座内でさらに分けて管理\nできる貯蓄ボックスを指します'),
                        miniInfo(needsIcon: false, passText: '（例：みんなの銀行 貯蓄預金「ボックス」）'),
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 70,
                          child: Container(
                            // decoration: BoxDecoration(
                            //   border: Border.all(color: Colors.blue),
                            //   borderRadius: BorderRadius.circular(10), //追加
                            // ),
                            child: OptionTextButton(
                              textList: _bankTypeList,
                              onItemSelected: _onItemSelected,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // =======================================================================================================

                  SizedBox(height: 20),

                  // =============================================== 「次へ」ボタン ==============================================
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    height: 57,
                    child: OutlinedButton(
                        onPressed: () {
                          //   Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => AddBankPagePresetCard(),
                          //   ),
                          // );
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
            )));
  }
}
