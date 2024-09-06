import 'package:flutter/material.dart';
import 'package:creeasy/common_comp.dart';
import 'package:creeasy/card_manage/add_bank/add_bank_main.dart';

// ================================================================= 選択されたカード名 ========================================================================
Container selectedCardIntro(String? cardName) {
  return Container(
    padding: EdgeInsets.only(left: 9, right: 9, top: 15, bottom: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color(0xfff8f8f8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleTextComp(
            resvIcon: Icons.credit_card_outlined, resvText: '選択されたカード名'),
        Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          height: 30,
          child: Text(
            cardName ?? '未選択',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    ),
  );
}

// ==========================================================================================================================================================

// ================================================================= 引き落とし口座の選択 =======================================================================
class PayBankComp extends StatefulWidget {
  final List<String> bankList;
  final int? resvNowSelectingBankIndex;

  PayBankComp(
      {required this.bankList, // 登録されている銀行のリスト
      required this.resvNowSelectingBankIndex // 現在選択中の銀行のインデックス番号(カード情報変更時に使用・カード新規追加時には不使用)
      });

  @override
  _PayBankCompState createState() => _PayBankCompState();
}

class _PayBankCompState extends State<PayBankComp> {
  // -------------------------------- 変数処理 --------------------------------
  int? _newSelectedBankIndex; // 新しく選択した銀行のインデックス番号

  @override
  void initState() {
    super.initState();
    _newSelectedBankIndex = widget.resvNowSelectingBankIndex; // 初期化処理
  }
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 9, right: 9, top: 15, bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffededed),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleTextComp(
              resvIcon: Icons.account_balance_outlined, resvText: '引き落とし口座を選択'),
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
                    style: TextStyle(color: Colors.black, fontSize: 13)),
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
          // -------------------------------------------------------------------------------
          // --------------------------- 引き落とし口座選択フィールド ---------------------------
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
                    (_newSelectedBankIndex != null)
                        ? widget.bankList[_newSelectedBankIndex ?? 0]
                        : '未選択',
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
                              itemCount: widget.bankList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(
                                      top: 5, bottom: 5, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Color(0xffeeeeee),
                                  ),
                                  child: ListTile(
                                    title: Text(widget.bankList[index],
                                        style: TextStyle(fontSize: 18)),
                                    onTap: () {
                                      setState(() {
                                        _newSelectedBankIndex = index;
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
    );
  }
}
// ==========================================================================================================================================================