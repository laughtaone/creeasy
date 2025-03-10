import 'package:flutter/material.dart';
import 'package:creeasy/5tabs/card_manage/add_bank/add_bank_main.dart';
import 'package:creeasy/components/display_parts/title_text_comp.dart';
import 'package:creeasy/components/display_parts/select_tile_comps/select_tile_comp.dart';
import 'package:creeasy/components/mini_info/mini_info_end_page_jump.dart';
import 'package:creeasy/components/input_comps/comp_input_dialog_select_type.dart';
// 引き落とし口座の選択(資金ボックスで管理するかどうかは聞かない)
// import文：import 'package:creeasy/card_manage/card_manage_COMPS/pay_bank_comp.dart';



class PayBankComp extends StatefulWidget {
  final List<String> bankList;
  final int? resvNowSelectingBankIndex;
  final Function(int?) argCallback;

  const PayBankComp(
      {super.key, required this.bankList, // 登録されている銀行のリスト
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
        titleComp: titleTextComp(resvIcon: Icons.account_balance_outlined, resvText: '引き落とし口座を選択'),
        guides: const Column(
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
            resvNowSelectingIndex: widget.resvNowSelectingBankIndex,
            dialogText: '引き落とし銀行を選択：',
            argCallback: widget.argCallback,
          ),
        ));
  }
}
// ==========================================================================================================================================================
