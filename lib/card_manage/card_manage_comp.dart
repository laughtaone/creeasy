import 'package:flutter/material.dart';
import 'package:creeasy/card_manage/add_bank/add_bank_main.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/title_text_comp.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_comp.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info_end_page_jump.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_dialog_select_type.dart';

// ================================================================= 選択されたカード名 ========================================================================
Container selectedCardIntro(String? cardName) {
  return Container(
    margin: EdgeInsets.only(top: 5),
    child: selectTileComp(
      titleComp: titleTextComp(
          resvIcon: Icons.credit_card_outlined, resvText: '選択されたカード名'),
      fieldInput: Container(
        child: Text(
          cardName ?? '未選択',
          style: TextStyle(fontSize: 20),
        ),
      )
    ),
  );
}

// ==========================================================================================================================================================

// ================================================================= 引き落とし口座の選択 =======================================================================
class PayBankComp extends StatefulWidget {
  final List<String> bankList;
  final int? resvNowSelectingBankIndex;
  final Function(int?) argCallback;

  PayBankComp(
      {required this.bankList, // 登録されている銀行のリスト
      required this.resvNowSelectingBankIndex, // 現在選択中の銀行のインデックス番号(カード情報変更時に使用・カード新規追加時には不使用)
      required this.argCallback});

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
    return selectTileComp(
        titleComp: titleTextComp(
            resvIcon: Icons.account_balance_outlined, resvText: '引き落とし口座を選択'),
        guides: Column(
          children: [
            miniInfoEndPageJump(
              passText: '銀行を新規追加する場合は',
              jumpPage: AddBankPage(),
            )
          ],
        ),
        fieldInput: Container(
          child: compInputDialogSelectType(
            elementsList: widget.bankList,
            resvNowSelectingIndex: _newSelectedBankIndex,
            dialogText: '引き落とし銀行を選択：',
            argCallback: widget.argCallback,
          ),
        ));
  }
}
// ==========================================================================================================================================================