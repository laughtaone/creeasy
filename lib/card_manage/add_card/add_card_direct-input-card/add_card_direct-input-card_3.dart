import 'package:flutter/material.dart';
import 'package:creeasy/COMMON_COMPS/buttons/jump_screen_button_comp/save_button_comp.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_button_toggle_comp.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info_end_page_jump.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info_end_url_jump.dart';
import 'package:creeasy/card_manage/card_manage_COMPS/pay_bank_and_saving_box_comp.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_dialog_select_type.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_double_type.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_string_type.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/title_text_comp.dart';
import 'package:creeasy/COMMON_COMPS/between/between_select_field.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_comp.dart';
import 'package:creeasy/COMMON_COMPS/between/between_icon.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_row_direct_select_type.dart';
import 'package:creeasy/COMMON_COMPS/buttons/jump_screen_button_comp/made_comp/next_button_comp.dart';
import 'package:creeasy/card_manage/card_manage_COMPS/selected_card_intro_comp.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_twolayers_button_toggle_comp.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/progress_bar_comp.dart';
import 'package:creeasy/COMMON_COMPS/function/judge_all_notnull.dart';
import 'package:creeasy/COMMON_COMPS/function/is_input_toggle_all_field.dart';







class AddCardPageDirectInputCard3 extends StatefulWidget {
  const AddCardPageDirectInputCard3({super.key});

  @override
  _AddCardPageDirectInputCard3State createState() =>
      _AddCardPageDirectInputCard3State();
}

class _AddCardPageDirectInputCard3State extends State<AddCardPageDirectInputCard3> {
  // ================================ 変数処理 ================================
  // ------------ 基本還元ポイント ------------
  int? _isExistBasicReturn;
  int? _isManageBasicReturn;
  double? _inputtedReturnRate;
  // ------------- ポイントアップ -------------
  int? _isExistPointup;
  int? _isManagePointup;
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
            Text('カードを追加'),
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
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.only(left: 17, right: 17, top: 10),
          child: ListView(
            children: [
              progressBarComp(ratioProg: 3, ratioNotprog: 0),
              // ================================================ 3.管理項目 =================================================
              // --------------------------- ⓪必須項目 ----------------------------
              titleTextComp(resvText: 'Step3：管理項目', hTextType: 1, customBottomMargin: 15),
              selectTileComp(
                customBackColor: const Color(0xfff2f2f2),
                titleComp: titleTextComp(resvText: '必須項目', resvTextSize: 20),
                fieldInput: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: Column(children: [
                    const Text('次の2つの項目はデフォルトで管理され、これらの管理をオフにすることはできません', style: TextStyle(fontSize: 15)),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        // color: const Color(0xffe8e8e8),
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Align(child: SizedBox(
                        width: 170,
                        height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            miniInfo(passText: '使用金額', customIcon: Icons.currency_yen_outlined, customTextSize: 17, isLimitOneline: true),
                            miniInfo(passText: '口座残高の確保', customIcon: Icons.account_balance_wallet_outlined, customTextSize: 17, isLimitOneline: true),
                          ],
                        ),
                      )),
                    ),
                  ]),
                )
              ),
              // ------------------------------------------------------------------------

              betweenIcon(Icons.add),

              // --------------------------- ①基本還元率 ----------------------------
              SelectTileTwolayersButtonToggleComp(
                mainTitleComp: titleTextComp(resvIcon: Icons.card_giftcard_outlined, resvText: '基本還元ポイントの管理'),
                mainGuides: Column(children: [
                  miniInfo(passText: '基本還元ポイントとは、利用金額に対して一定の割合で付与されるポイントです'),
                  miniInfo(passText: 'この時の割合が「基本還元率」です', needsIcon: false),
                  miniInfo(needsIcon: false, customTextSize: 15, customTopPadding: 10, passText: '基本還元分のポイントがありますか？'),
                ]),
                mainSelectList: const ['ない', 'ある'],
                nowMainSelectButtonIndex: _isExistBasicReturn,
                argMainCallback: (int? resvIndex) {
                  _isExistBasicReturn = resvIndex;
                  setState(() {_isExistBasicReturn = resvIndex;});
                },
                subTitleComp: titleTextComp(resvText: '基本還元分のポイントまで管理しますか？',),
                subGuides: Column(children: [miniInfo(passText: '細かく管理したい方におすすめ', customIcon: Icons.tips_and_updates_outlined)]),
                sub1SelectList: const ['しない', 'する'],
                nowSub1SelectButtonIndex: _isManageBasicReturn,
                argSub1Callback: (int? resvIndex) {
                  _isManageBasicReturn = resvIndex;
                  setState(() {_isManageBasicReturn = resvIndex;});
                },
                sub2FieldInput: selectTileComp(
                  customBackColor: const Color(0xffc0c0c0),
                  titleComp: titleTextComp(resvText: '基本還元率を入力', resvIcon: Icons.percent),
                  guides: Column(children: [miniInfo(passText: '0[%]より大きく20[%]以下の値が入力可能')],),
                  fieldInput: compInputDoubleType(
                    customBackColor: const Color(0xffeeeeee),
                    resvNowInputingDouble: _inputtedReturnRate,
                    suffixText: '%',
                    argCallback: (String? recvReturnRate) {
                      switch (recvReturnRate) {
                        case ''||null:
                          _inputtedReturnRate = null;
                          setState(() {
                            _inputtedReturnRate = null;
                          });
                          break;
                        default:
                          _inputtedReturnRate = double.parse(recvReturnRate);
                          setState(() {
                            _inputtedReturnRate = double.parse(recvReturnRate);
                          });
                          break;
                      }
                    },
                  ),
                )
              ),
              // ------------------------------------------------------------------------

              betweenIcon(Icons.add),

              // --------------------------- ②ボーナスポイント ----------------------------
              SelectTileTwolayersButtonToggleComp(
                mainTitleComp: titleTextComp(resvIcon: Icons.auto_awesome_outlined, resvText: 'ポイントアップ分の管理'),
                mainGuides: Column(children: [
                  miniInfo(passText: '「ポイントアップ」とは特定の店や日付での利用でポイントが上乗せされることを指します'),
                  miniInfo(
                    passText: '例：三井住友カードは「ポイントアッププログラム」があるので「あり」を選択 *1',
                    needsTBPadding: false,
                    customIcon: Icons.tips_and_updates_outlined
                  ),
                  miniInfo(
                    passText: '例：Paidyカードはポイントアップがないので「ない」を選択  *1',
                    needsTBPadding: false,
                    customIcon: Icons.tips_and_updates_outlined
                  ),
                  miniInfo(
                    passText: '*1 2024年9月5日調べ・各カードを批判/優遇/宣伝する意図は無くあくまで例として列挙',
                    customTextSize: 9,
                    needsIcon: false,
                    customColor: Colors.black54
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text('ポイントアップ分のポイントがありますか？', style: TextStyle(fontSize: 16)),
                  ),
                ]),
                mainSelectList: const ['ない', 'ある'],
                nowMainSelectButtonIndex: _isExistPointup,
                argMainCallback: (int? resvIndex) {
                  _isExistPointup = resvIndex;
                  setState(() {_isExistPointup = resvIndex;});
                },
                subTitleComp: titleTextComp(resvText: 'ポイントアップ分のポイントまで管理しますか？',),
                subGuides: Column(children: [
                  miniInfo(passText: 'ポイントアップ分まで、細かく管理したい方におすすめ', customIcon: Icons.tips_and_updates_outlined),
                  miniInfo(
                    passText: 'この機能は、がめつい開発者がポイントアップ分まで管理したいという目的で開発しました',
                    customIcon: Icons.tips_and_updates_outlined
                  ),
                  miniInfo(needsIcon: false, doukaColor: const Color(0xffdcdcdc),
                    passText: 'しかし管理が少し煩雑になるため、管理をシンプルにしたい方は「しない」を選択することを推奨します'
                  )
                ]),
                sub1SelectList: const ['しない', 'する'],
                nowSub1SelectButtonIndex: _isManagePointup,
                argSub1Callback: (int? resvIndex) {
                  _isManagePointup = resvIndex;
                  setState(() {_isManagePointup = resvIndex;});
                },
                sub2FieldInput: compInputDoubleType(
                  resvNowInputingDouble: _inputtedReturnRate,
                  suffixText: '%',
                  argCallback: (String? recvReturnRate) {
                    switch (recvReturnRate) {
                      case ''||null:
                        setState(() {
                          _inputtedReturnRate = null;
                        });
                        break;
                      default:
                        setState(() {
                          _inputtedReturnRate = double.parse(recvReturnRate);
                        });
                        break;
                    }
                  },
                ),
              ),
              // ===========================================================================================================

              // =============================================== 「次へ」ボタン ==============================================
              betweenSelectField(customHeight: 40),

              Text('_isExistBasicReturn：${_isExistBasicReturn.toString()}'),
              Text('_isManageBasicReturn：$_isManageBasicReturn'),
              Text('_isExistPointup：${_isExistPointup.toString()}'),
              Text('_isManagePointup：${_isManagePointup.toString()}'),

              NextButtonComp(
                isCanPressNextButton: (judgeAllNotnull(rectList: [
                  isInputToggleAllField(_isExistBasicReturn, isInputToggleAllField(_isManageBasicReturn, _inputtedReturnRate)),
                  isInputToggleAllField(_isExistPointup, isInputToggleAllField(_isManagePointup, _inputtedReturnRate)),
                ])) ?true :false,
                argOnpressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddCardPageDirectInputCard3(),
                    ),
                  );
                },
              ),
              betweenSelectField(customHeight: 40),
              // ===========================================================================================================
            ],
          )
        )
      ),
    );
  }
}
