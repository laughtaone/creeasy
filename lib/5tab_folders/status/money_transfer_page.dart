import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:creeasy/5tab_folders/card_manage/card_manage_COMPS/pay_bank_and_saving_box_comp.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/title_text_comp.dart';
import 'package:creeasy/COMMON_COMPS/buttons/topright_close_button.dart';
import 'package:creeasy/COMMON_COMPS/between/between_icon.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/caution_comp.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info.dart';
import 'package:creeasy/COMMON_COMPS/between/between_select_field.dart';
import 'package:creeasy/COMMON_COMPS/buttons/jump_screen_button_comp/save_button_comp.dart';
import 'package:creeasy/5tab_folders/card_manage/card_manage_COMPS/pay_bank_comp.dart';
import 'package:creeasy/5tab_folders/card_manage/card_manage_COMPS/selected_card_intro_comp.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_comp.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_dialog_select_type.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_int_type.dart';


class MoneyTransferPage extends StatefulWidget {
  final String? selectedBoxName;
  final int fundboxBalance;
  const MoneyTransferPage({super.key,
    required this.selectedBoxName,
    required this.fundboxBalance,
  });

  @override
  _MoneyTransferPageState createState() => _MoneyTransferPageState();
}

class _MoneyTransferPageState extends State<MoneyTransferPage> {
  final List<String> _bankList = ['三菱UFJ銀行', 'みんなの銀行', '三井住友銀行'];

  // ================================ 変数処理 ================================
  int? _selectedBank; // 選択された銀行を保持する変数
  String? _inputSendPrice = ''; // 入力された金額を保持する変数
  // =========================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.credit_score_outlined, color: Colors.black),
              SizedBox(width: 5),
              Text('資金移動を記録'),
            ],
          ),
          backgroundColor:Theme.of(context).appBarTheme.backgroundColor, // Themeから色を取得
          actions: const [ToprightCloseButton()],
        ),
        body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => primaryFocus?.unfocus(),
            child: Padding(
              padding: const EdgeInsets.only(left: 17, right: 17, top: 10),
              child: ListView(
                children: [
                  // ========================================================== ⓪ 選択されたカード名 ==========================================================
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: selectTileComp(
                      titleComp: titleTextComp(resvIcon: Icons.savings_outlined, resvText: '選択された資金ボックス名'),
                      fieldInput: Column(
                        children: [
                          Text(
                            widget.selectedBoxName ?? '未選択',
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '（想定残高：${formatYen(widget.fundboxBalance)}円）',
                            style: const TextStyle(fontSize: 14),
                          )
                          // Align(
                          //   alignment: Alignment.center,
                          //   child: titleTextComp(resvIcon: Icons.savings_outlined, resvText: '選択された資金ボックス名', placementCenter: true)
                          // ),
                        ],
                      )
                    ),
                  ),
                  // =======================================================================================================================================

                  betweenIcon(recvIcon: Icons.arrow_downward_outlined),

                  // ============================================================= ⓪ 注意書き =============================================================
                  cautionComp(Column(children: [
                    miniInfo(
                      customIcon: Icons.error_outline_outlined,
                      passText: '資金ボックスから通常口座への移動を記録するものです。',
                      customTextSize: 14
                    ),
                    miniInfo(passText: '移動の記録後に、キャンセルすることはできません。ゆえに、逆方向の資金ボックスから通常口座への移動は記録できません。', customTextSize: 14),
                  ],)),
                  // =======================================================================================================================================

                  betweenSelectField(customHeight: 15),

                  // --------------------------------------- ① 資金移動先の口座を選択 ---------------------------------------
                  betweenSelectField(),
                  // PayBankComp(
                  //   bankList: _bankList,
                  //   resvNowSelectingBankIndex: _selectedBank,
                  //   argCallback: (int? resvIndex) {
                  //     _selectedBank = resvIndex;
                  //     setState(() {
                  //       _selectedBank = resvIndex;
                  //     });
                  //   },
                  // ),
                  selectTileComp(
                    titleComp: titleTextComp(resvIcon: Icons.account_balance_outlined, resvText: '資金移動先の口座を選択'),
                    fieldInput: compInputDialogSelectType(
                      elementsList: _bankList,
                      resvNowSelectingIndex: _selectedBank,
                      dialogText: '資金移動先の口座を選択：',
                      argCallback: (int? resvIndex) {
                        _selectedBank = resvIndex;
                        setState(() {
                          _selectedBank = resvIndex;
                        });
                      },
                    ),
                  ),
                  // ----------------------------------------------------------------------------------------------------

                  // -------------------------------------------- ② 移動金額 ---------------------------------------------
                  betweenSelectField(),
                  selectTileComp(
                    titleComp: titleTextComp(resvIcon: Icons.currency_yen_outlined, resvText: '金額を入力'),
                    guides: Column(
                      children: [
                        miniInfo(
                          passText: '1円〜${formatYen(widget.fundboxBalance)}円(資金ボックスの想定残高) の金額が入力可能です'
                        )
                      ],
                    ),
                    fieldInput: compInputIntType(
                      prefixText: '¥　',
                      argCallback: (value) {
                        _inputSendPrice = value;
                        // コールバックを渡す
                        setState(() {
                          _inputSendPrice = value;
                        });
                      },
                    ),
                  ),
                  // ----------------------------------------------------------------------------------------------------

                  // =======================================================================================================================================




                  // =============================================== 保存ボタン ==============================================
                  SaveButtonComp(
                    argCallback: () {
                      print('保存されました');
                    },
                    isCanOnpress: true,
                  ),
                  // =======================================================================================================
                ],
              ),
            )));
  }
}






// intを受け取り,をつけて返す
String formatYen(int amount) {
  final formatter = NumberFormat('#,###', 'ja_JP');
  return formatter.format(amount);
}