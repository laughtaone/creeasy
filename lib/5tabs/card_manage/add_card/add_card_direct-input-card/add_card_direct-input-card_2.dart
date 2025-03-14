import 'package:flutter/material.dart';
import 'package:creeasy/components/buttons/jump_screen_button_comp/save_button_comp.dart';
import 'package:creeasy/components/display_parts/select_tile_comps/select_tile_button_toggle_comp.dart';
import 'package:creeasy/components/mini_info/mini_info_end_page_jump.dart';
import 'package:creeasy/components/mini_info/mini_info_end_url_jump.dart';
import 'package:creeasy/5tabs/card_manage/card_manage_COMPS/pay_bank_and_saving_box_comp.dart';
import 'package:creeasy/components/input_comps/comp_input_dialog_select_type.dart';
import 'package:creeasy/components/input_comps/comp_input_double_type.dart';
import 'package:creeasy/components/input_comps/comp_input_string_type.dart';
import 'package:creeasy/components/display_parts/title_text_comp.dart';
import 'package:creeasy/components/between/between_select_field.dart';
import 'package:creeasy/components/mini_info/mini_info.dart';
import 'package:creeasy/components/display_parts/select_tile_comps/select_tile_comp.dart';
import 'package:creeasy/components/between/between_icon.dart';
import 'package:creeasy/components/input_comps/comp_input_row_direct_select_type.dart';
import 'package:creeasy/components/buttons/jump_screen_button_comp/made_comp/next_button_comp.dart';
import 'package:creeasy/5tabs/card_manage/add_card/add_card_direct-input-card/add_card_direct-input-card_3.dart';
import 'package:creeasy/components/display_parts/progress_bar_comp.dart';
import 'package:creeasy/components/function/judge_all_notnull.dart';






class AddCardPageDirectInputCard2 extends StatefulWidget {
  const AddCardPageDirectInputCard2({super.key});

  @override
  _AddCardPageDirectInputCard2State createState() =>
      _AddCardPageDirectInputCard2State();
}

class _AddCardPageDirectInputCard2State extends State<AddCardPageDirectInputCard2> {
  // ================================ 変数処理 ================================
  int? _isSpecialPayment;
  int? _isCanUsePoint;
  // =========================================================================


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Row(
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
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ))
          ],
        ),
        body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => primaryFocus?.unfocus(),
            child: Padding(
                padding: const EdgeInsets.only(left: 17, right: 17, top: 10),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    progressBarComp(ratioProg: 2, ratioNotprog: 1),
                    // ================================================ 2.支払い額について =================================================
                    titleTextComp(resvText: 'Step2：支払い額について', hTextType: 1, customBottomMargin: 15),
                    // --------------------------- ①臨時支払いの有無 ----------------------------
                    selectTileComp(
                      titleComp: titleTextComp(resvIcon: Icons.published_with_changes_outlined, resvText: '繰り上げ返済の有無'),
                      guides: Column(children: [miniInfoEndUrlJump(
                        passText: '「繰り上げ返済」とは、利用額を引き落とし日よりも前に支払うことです。詳しくは',
                        passUrl: 'https://www.jcb.co.jp/ordercard/special/prepayment.html',
                        endText: '（JCBの解説サイト）'
                      )]),
                      fieldInput: CompInputRowDirectSelectType(
                        elementsList: const ['ない', 'ある'],
                        resvNowSelectingIndex: _isSpecialPayment,
                        argCallback: (int resvIndex) {
                          _isSpecialPayment = resvIndex;
                          setState(() {
                            _isSpecialPayment = resvIndex;
                          });
                        },
                      ),
                    ),
                    // ------------------------------------------------------------------------
                    // --------------------------- ②ポイント割当の有無 ----------------------------
                    betweenSelectField(),
                    selectTileComp(
                      titleComp: titleTextComp(resvIcon: Icons.offline_bolt_outlined, resvText: 'ポイント割当の有無'),
                      guides: Column(children: [miniInfoEndUrlJump(
                        passText: '「ポイント割当」とは、その名の通りポイントを支払い金額に割り当てることです。これにより引き落とし額を安くすることができます。詳しくは',
                        passUrl: 'https://www.smbc-card.com/mem/addcard/cashback.jsp',
                        endText: '(←例として三井住友カードの場合)'
                      )],),
                      fieldInput: CompInputRowDirectSelectType(
                        elementsList: const ['ない', 'ある'],
                        resvNowSelectingIndex: _isCanUsePoint,
                        argCallback: (int resvIndex) {
                          _isCanUsePoint = resvIndex;
                          setState(() {
                            _isCanUsePoint = resvIndex;
                          });
                        },
                      ),
                    ),
                    // ------------------------------------------------------------------------
                    // ==================================================================================================================


                    // =============================================== 「次へ」ボタン ==============================================
                    betweenSelectField(customHeight: 20),

                    NextButtonComp(
                      isCanPressNextButton: (judgeAllNotnull(rectList: [_isSpecialPayment, _isCanUsePoint])) ?true :false,

                      argOnpressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddCardPageDirectInputCard3(),
                          ),
                        );
                      },
                    ),
                    // ===========================================================================================================

                  ],
                ))));
  }
}
