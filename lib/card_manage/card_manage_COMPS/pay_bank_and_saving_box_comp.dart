import 'package:flutter/material.dart';
import 'package:creeasy/card_manage/add_bank/add_bank_main.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/title_text_comp.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_comp.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info_end_page_jump.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_dialog_select_type.dart';
// 引き落とし口座の選択(資金ボックスで管理するかどうか聞く)
// import文：import 'package:creeasy/card_manage/card_manage_COMPS/pay_bank_and_saving_box_comp.dart';




class PayBankAndSavingBoxComp extends StatefulWidget {
  final List<String> bankList;
  final int? resvNowSelectingBankIndex;
  final Function(int?) argCallback;

  const PayBankAndSavingBoxComp({super.key,
    required this.bankList,                         // 登録されている銀行のリスト
    required this.resvNowSelectingBankIndex,        // 現在選択中の銀行のインデックス番号(カード情報変更時に使用・カード新規追加時には不使用)
    required this.argCallback
  });

  @override
  _PayBankAndSavingBoxCompState createState() => _PayBankAndSavingBoxCompState();
}

class _PayBankAndSavingBoxCompState extends State<PayBankAndSavingBoxComp> {
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
          resvNowSelectingIndex: _newSelectedBankIndex,
          dialogText: '引き落とし銀行を選択：',
          argCallback: widget.argCallback,
        ),
      )
    );
  }
}
// ==========================================================================================================================================================