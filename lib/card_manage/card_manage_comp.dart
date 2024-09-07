import 'package:flutter/material.dart';
import 'package:creeasy/card_manage/add_bank/add_bank_main.dart';
import 'package:creeasy/common_comps/title_text_comp.dart';
import 'package:creeasy/common_comps/select_tile_comp.dart';
import 'package:creeasy/common_comps/mini_info_end_page_jump.dart';
import 'package:creeasy/common_comps/comp_input_dialog_select_type.dart';



// ================================================================= 選択されたカード名 ========================================================================
selectTileComp selectedCardIntro(String? cardName) {
  return selectTileComp(
      titleComp: titleTextComp(
          resvIcon: Icons.credit_card_outlined, resvText: '選択されたカード名'),
      fieldInput: Container(
        child: Text(
          cardName ?? '未選択',
          style: TextStyle(fontSize: 20),
        ),
      ));
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
      fieldInput: Container()
      // fieldInput: Container(
      //   child: compInputDialogSelectType(
      //       elementsList: widget.bankList,
      //       resvNowSelectingIndex: _newSelectedBankIndex,
      //       dialogText: '引き落とし銀行を選択：'),
      // )
    );
  }
}
// ==========================================================================================================================================================