import 'package:flutter/material.dart';
import 'package:creeasy/add/add_common_component.dart';
import 'package:creeasy/card_manage/add_bank/add_bank_main.dart';
import 'package:creeasy/card_manage/add_bank/select_bank-type_component.dart';

class AddCardPagePresetCard extends StatefulWidget {
  final String? selectedCardName;

  const AddCardPagePresetCard({Key? key, required this.selectedCardName}) : super(key: key);

  @override
  _AddCardPagePresetCardState createState() => _AddCardPagePresetCardState();
}

class _AddCardPagePresetCardState extends State<AddCardPagePresetCard> {

  final List<String> _smcnlPayRule = ['15日締め / 翌月10日払い', '月末締め / 翌月26日払い'];

  // ================================ 変数処理 ================================
  int? _selectedSmcnlPayRuleIndex;   // ①で選択されたポイントアップの有無を保持する変数
  // =========================================================================

  void _onSelectSmcnlPayRuleIndex(int? index) {
    setState(() {
      _selectedSmcnlPayRuleIndex = index;
    });
    print("_selectedSmcnlPayRuleIndex: $_selectedSmcnlPayRuleIndex");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add_card_outlined,
              color: Colors.black
            ),
            SizedBox(width: 5),
            Text(
              'カードを追加',
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
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
              // =============================================== ⓪ 選択されたカード名 ==============================================
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.only(left: 9, right: 9, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xfff4f4f4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addButtonPageTitleText(resvIcon: Icons.credit_card_outlined, resvText:'選択されたカード名'),
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                            height: 30,
                            child: Text(
                                widget.selectedCardName ?? '未選択',
                                style: TextStyle(
                                  fontSize: 20
                                ),
                              ),
                          ),

                        ],
                      ),
                    ),
              // =======================================================================================================

              // 「＋」のテキスト
              Padding(padding: EdgeInsets.only(top: 7, bottom: 10), child: Text('+', style: TextStyle(fontSize: 27), textAlign: TextAlign.center,)),

              addButtonPageTitleText(resvText:'カード情報を微調整', resvTextSize: 20),


              // =============================================== ① 締日/引き落とし日の選択 ==============================================
              betweenAddPaymentSection(),
              Container(
                padding: EdgeInsets.only(
                    left: 9, right: 9, top: 15, bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffededed),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addButtonPageTitleText(resvIcon: Icons.event_outlined, resvText: '締日/引き落とし日の選択'),
                    SizedBox(height: 3),
                    miniInfo(passText: '公式サイトの情報を基に作成しています'),
                    miniInfo(passText: 'ご自身で設定している日付が用意されていない場合は、お手数ですが開発者までご連絡ください'),
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 130,
                      child: Container(
                        child: OptionTextButtonOneLine(
                          textList: _smcnlPayRule,
                          onItemSelected: _onSelectSmcnlPayRuleIndex,
                          textFontSize: 17
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // =======================================================================================================



            ]
          )
        )
      ),
    );
  }
}
