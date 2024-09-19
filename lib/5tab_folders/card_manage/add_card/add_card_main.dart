import 'package:creeasy/COMMON_COMPS/between/between_icon.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_comp.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/title_text_comp.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_dialog_select_type.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info.dart';
import 'package:flutter/material.dart';
import 'package:creeasy/5tab_folders/card_manage/add_card/add_card_preset-card/add_card_preset-card_1.dart';
import 'package:creeasy/5tab_folders/card_manage/add_card/add_card_direct-input-card/add_card_direct-input-card_1.dart';
import 'package:creeasy/COMMON_COMPS/buttons/jump_screen_button_comp/made_comp/next_button_comp.dart';
import 'package:creeasy/COMMON_COMPS/buttons/jump_screen_button_comp/made_comp/chokusetsunyuuryou_button_comp.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/no_save_close_comp.dart';
import 'package:auto_size_text/auto_size_text.dart';




class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  // ドロップダウンメニューで選択するアイテムのリスト
  final List<String> _presetCardBrandList = [
    '三井住友カード三井住友カード三井住友カード三井住友カード三井住友カード',
    'メルカリ',
    'ビューカード',
    'PayPay',
    'LINE',
    'エポス',
    'auPAY',
    'dカード',
  ];
  final List<List<String>> _presetCardList = [
    ['三井住友カード(NL)', '三井住友カード(CL)', '三井住友カード ゴールド(NL)'],
    ['メルカード'],
    ['JREカード', 'ビックSuicaカード'],
    ['PayPayカード', 'PayPayカード ゴールド'],
    ['LINEクレカ', 'LINEクレカ(P+)'],
    ['エポスカードVisa', 'エポスゴールドカード'],
    ['auPAYカード', 'auPAYゴールドカード'],
    ['dカード', 'dカードゴールド'],
  ];




  // ================================ 変数処理 ================================
  String? _selectedItem; // ①で選択されたカードを保持する変数
  int? _selectedCardBrandIndex;
  int? _selectedCardIndex;  // 選択されたカード
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
                Navigator.pop(context);
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
              // ========================================== ①支払いカード選択 ==========================================
              const SizedBox(height: 14),
              const AutoSizeText(
                r'\\まずはプリセットに用意されているかチェック//',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center
              ),
              const SizedBox(height: 10),
              selectTileComp(
                customBackColor: const Color(0xffe6e6e6),    // 大きい側の色
                titleComp: titleText(Icons.credit_card_outlined, '追加するカードを選択'),
                guides: Column(children: [
                  miniInfo(passText: 'プリセットされているカードは、管理できる項目がそのカードに特化しているため、非常に管理がしやすいメリットがあります')
                ]),
                fieldInput: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 3),
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffd1d1d1),
                      ),
                      child: Column(
                        children: [
                          titleTextComp(resvIcon: Icons.search, resvText: 'カードを探す', customFontWeight: FontWeight.w700),
                          // -------------------------------------- ブランド --------------------------------------
                          selectTileComp(
                            // customBackColor: const Color(0xffdcdcdc),
                            customBackColor: const Color(0xffd1d1d1),
                            customTBPadding: const [5, 5],
                            titleComp: titleTextComp(resvIcon: Icons.local_offer_outlined, resvText: 'ブランドを選択', customIconSize: 20, customBetweenIT: 3),
                            fieldInput: compInputDialogSelectType(
                              customTBPadding: 0,
                              customTBMargin: const [5, 3],
                              customMainTextSize: 17,
                              isRedTextUnselect: true,
                              elementsList: _presetCardBrandList,
                              resvNowSelectingIndex: _selectedCardBrandIndex,
                              dialogText: 'ブランド一覧：',
                              argCallback: (int? resvIndex) {
                                if (_selectedCardBrandIndex != resvIndex) {
                                  _selectedCardBrandIndex = resvIndex;
                                  _selectedCardIndex = null;
                                  setState(() {
                                    _selectedCardIndex = null;
                                    _selectedCardBrandIndex = resvIndex;
                                  });
                                }
                              },
                            ),
                          ),
                          // ------------------------------------------------------------------------------------

                          betweenIcon(recvIcon: Icons.arrow_downward, customTBPadding: [0, 0]),

                          // ---------------------------------- 追加するカードを表示 ----------------------------------
                          selectTileComp(
                            customBackColor: const Color(0xffd1d1d1),
                            customTBPadding: const [5, 5],
                            titleComp: titleTextComp(resvText: '追加するカード', resvIcon: Icons.verified_outlined),
                            fieldInput: compInputDialogSelectType(
                              customTBPadding: 0,
                              customTBMargin: const [5, 3],
                              customMainTextSize: 17,
                              isRedTextUnselect: true,
                              canTapField: (_selectedCardBrandIndex!=null),
                              // elementsList: (_selectedCardBrandIndex!=null) ?_presetCardList[_selectedCardBrandIndex!]: [''*_presetCardBrandList.length],
                              elementsList: (_selectedCardBrandIndex != null && _presetCardList.length > _selectedCardBrandIndex!)
                                ? _presetCardList[_selectedCardBrandIndex!]
                                : [],
                              resvNowSelectingIndex: _selectedCardIndex,
                              dialogText: 'ブランド一覧：',
                              argCallback: (int? resvIndex) {
                                setState(() {
                                  _selectedCardIndex = resvIndex;
                                });
                              },
                            ),
                          ),
                          // ------------------------------------------------------------------------------------
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    // ----------------------------------- 「次へ」ボタン -----------------------------------
                    SizedBox(
                      width: double.infinity,
                      child: NextButtonComp(
                        isCanPressNextButton: (_selectedCardIndex!=null) ?true :false,
                        argOnpressed: () {
                          (_selectedCardIndex!=null)
                          ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddCardPagePresetCard1(selectedCardName: _presetCardList[_selectedCardBrandIndex!][_selectedCardIndex!]),
                            ),
                          )
                          : null
                          ;
                        },
                      ),
                    ),
                    // ------------------------------------------------------------------------------------
                  ],
                ),
              ),
              // ====================================================================================================


              const SizedBox(height: 35),

              // =============================================== 「直接入力」ボタン ==============================================
              ChokusetsuNyuuryokuButtonComp(
                // _isCanPressNextButton
                argOnpressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddCardPageDirectInputCard1(),
                    ),
                  );
                },
              ),
              // =======================================================================================================

              noSaveCloseComp(messageType: 0),
            ],
          ),
        )
      )
    );
  }
}

// タイトルコンポーネント(このページ内のみで使用)
Row titleText(IconData receivedIcon, String originalText) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(width: 2),
      Icon(
        receivedIcon,
        size: 23,
      ),
      const SizedBox(width: 5),
      Text(
        originalText,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    ],
  );
}
