import 'package:flutter/material.dart';
import 'package:creeasy/add/add_common_component.dart';
import 'package:creeasy/card_manage/add_bank/add_bank_main.dart';
import 'package:creeasy/card_manage/add_bank/select_bank-type_component.dart';

class AddCardPagePresetCard extends StatefulWidget {
  final String? selectedCardName;

  const AddCardPagePresetCard({Key? key, required this.selectedCardName})
      : super(key: key);

  @override
  _AddCardPagePresetCardState createState() => _AddCardPagePresetCardState();
}

class _AddCardPagePresetCardState extends State<AddCardPagePresetCard> {
  final List<String> _smcnlPayRule = ['15日締め / 翌月10日払い', '月末締め / 翌月26日払い'];
  final List<String> _bankList = ['三菱UFJ銀行', 'みんなの銀行', '三井住友銀行'];

  // ================================ 変数処理 ================================
  int? _selectedSmcnlPayRuleIndex; // ①で選択されたポイントアップの有無を保持する変数
  String? _selectedBank; // ②で選択された銀行を保持する変数
  final TextEditingController _inputVpupReturnRate = TextEditingController(); // ③で入力された還元率[%]を保持する変数
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
              child: ListView(children: [
                // =============================================== ⓪ 選択されたカード名 ==============================================
                SizedBox(height: 5),
                Container(
                  padding:
                      EdgeInsets.only(left: 9, right: 9, top: 15, bottom: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xfff8f8f8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addButtonPageTitleText(
                          resvIcon: Icons.credit_card_outlined,
                          resvText: '選択されたカード名'),
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        height: 30,
                        child: Text(
                          widget.selectedCardName ?? '未選択',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                // =======================================================================================================

                // 「＋」のテキスト
                Padding(
                    padding: EdgeInsets.only(top: 7, bottom: 10),
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 27),
                      textAlign: TextAlign.center,
                    )),

                addButtonPageTitleText(resvText: 'カード情報を微調整', resvTextSize: 20),

                // =============================================== ① 締日/引き落とし日の選択 ==============================================
                betweenAddPaymentSection(customHeight: 13),
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
                          resvIcon: Icons.event_outlined,
                          resvText: '締日/引き落とし日を選択'),
                      SizedBox(height: 3),
                      miniInfo(passText: '公式サイトの情報を基に作成しています'),
                      miniInfo(
                          passText:
                              '設定できるはずの日付が用意されていない場合は、お手数ですが開発者までご連絡ください'),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 140,
                        child: Container(
                          child: OptionTextButtonOneLine(
                              textList: _smcnlPayRule,
                              onItemSelected: _onSelectSmcnlPayRuleIndex,
                              textFontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
                // =======================================================================================================

                // ========================================== ②引き落とし口座 ==========================================
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
                          resvIcon: Icons.account_balance_outlined,
                          resvText: '引き落とし口座を選択'),
                      // --------------------------- 「銀行を追加する場合はこちら」 -----------------------------------
                      Container(
                        padding: EdgeInsets.only(top: 2, bottom: 5, left: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 15,
                            ),
                            SizedBox(width: 4),
                            Text('銀行を新規追加する場合は ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13)),
                            RichText(
                                text: TextSpan(children: [
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () {
                                    // 銀行新規追加画面へ遷移
                                    // Navigator.pushAndRemoveUntil(
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddBankPage(),
                                        fullscreenDialog: true,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'こちら',
                                    style: TextStyle(
                                        color: Colors.indigo[500],
                                        // decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ])),
                          ],
                        ),
                      ),
                      // ---------------------------------------------------------------------------------
                      // --------------------------- 引き落とし口座選択フィールド -----------------------------------
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
                            title: Text('${_selectedBank ?? '未選択'}',
                                style: TextStyle(fontSize: 20)),
                            trailing: Icon(Icons.edit),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('引き落とし銀行を選択：'),
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
                                          itemCount: _bankList.length,
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
                                                title: Text(_bankList[index],
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                                onTap: () {
                                                  setState(() {
                                                    _selectedBank =
                                                        _bankList[index];
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

                // =============================================== ②ポイントアップの選択 ==============================================
                betweenAddPaymentSection(),
                Container(
                  padding: EdgeInsets.only(left: 9, right: 9, top: 15, bottom: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffededed),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addButtonPageTitleText(
                        resvIcon: Icons.local_offer_outlined,
                        resvText: 'Vポイントアッププログラムの還元率',
                        resvTextSize: 16
                      ),
                      SizedBox(height: 3),
                      // --------------------------- VPUP還元率に設定できる値の注意書き -----------------------------------
                      miniInfoEndJump(
                        passText: 'Vポイントアッププログラムの詳細は',
                        passUrl: 'https://www.smbc-card.com/mem/wp/vpoint_up_program/index.jsp'
                      ),
                      miniInfo(passText: 'Vpassアプリに表示されているVポイントアッププログラムの還元率をそのまま入力'),
                      miniInfo(
                        passText: '（表示されている還元率は基本還元率0.5%を含みますが、無視してそのまま入力してください）',
                        customTextSize: 10,
                        needsIcon: false,
                        needsTBPadding: false
                      ),
                      miniInfo(passText: '0-20[%] の 整数または小数 が設定可能'),
                      // ----------------------------------------------------------------------------------------------
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                        height: 70,
                        child: TextField(
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                          ),
                          controller: _inputVpupReturnRate,
                          decoration: InputDecoration(
                            labelText: '',
                            contentPadding: EdgeInsets.all(30),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixText: '%',
                            fillColor: Color(0xfffefefe),
                            filled: true,
                          ),
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            DecimalTextInputFormatter(),
                            ZeroLimitFormatterForDouble(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // =======================================================================================================

              ]))),
    );
  }
}
