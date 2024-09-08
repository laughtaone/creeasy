import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:creeasy/COMMON_COMPS/buttons/option_text_buttons/single_option_text_button.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/title_text_comp.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comp.dart';
import 'package:creeasy/COMMON_COMPS/between/between_select_field.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_dialog_select_type.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_int_type.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_string_type.dart';
import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_date_type.dart';
import 'package:creeasy/COMMON_COMPS/buttons/save_button_comp.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/now_return_rate.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info.dart';
import 'package:creeasy/COMMON_COMPS/buttons/option_text_buttons/single_option_text_button_new_format.dart';
import 'package:creeasy/COMMON_COMPS/buttons/option_text_buttons/single_option_text_button_new.dart';




class AddPaymentPage extends StatefulWidget {
  @override
  _AddPaymentPageState createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
  // ドロップダウンメニューで選択するアイテムのリスト
  final List<String> _items = [
    '三井住友カード',
    'メルカード',
    'ビューカード',
    'PayPayカード',
    'LINEクレカ(P+)',
    'エポスカード'
  ];
  List<SotbProperties> sampleSotbsList = [
    SotbProperties(
      upperText: 'ポイント\n進呈',
      trueLowerText: '対象',
      falseLowerText: '対象外',
      initialBoolLowerText: true,
      listIndexNum: 0,
    ),
    SotbProperties(
      upperText: 'ポイント\n進呈',
      trueLowerText: '対象',
      falseLowerText: '対象外',
      initialBoolLowerText: false,
      listIndexNum: 1,
    ),
    SotbProperties(
      upperText: 'LINE Pay\n経由',
      trueLowerText: '対象',
      falseLowerText: '対象外',
      initialBoolLowerText: false,
      listIndexNum: 2,
    ),
  ];

  // ================================ 変数処理 ================================
  int? selectedCardIndex;         // ①で選択されたカードのインデックス番号を保持する変数
  String? inputPayPrice = '';     // ②で入力された金額を保持する変数
  DateTime? _payDate;             // ③で入力された日付を保持する変数
  String? inputPlace = '';        // ④で入力された使用場所の文字列を保持する変数



  final _isPointTaisho = true; // ⑤でポイント進呈対象外かどうかの真偽値を保持する変数（true: 進呈対象・false: 進呈対象外）
  // =========================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.credit_score_outlined, color: Colors.black),
            SizedBox(width: 5),
            Text(
              '利用履歴を追加',
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ))
        ],
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor, // Themeから色を取得
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.only(left: 17, right: 17, top: 10),
          child: ListView(
            children: [
              // ========================================== ①支払いカード選択 ==========================================
              const SizedBox(height: 5),
              selectTileComp(
                titleComp: titleTextComp(
                    resvIcon: Icons.credit_card_outlined,
                    resvText: '支払いカードを選択'),
                fieldInput: Container(
                  child: compInputDialogSelectType(
                    elementsList: _items,
                    dialogText: '支払いカードを選択：',
                    returnSelectIndex: selectedCardIndex,
                  ),
                ),
              ),
              // ====================================================================================================

              // =============================================== ②金額 ==============================================
              betweenSelectField(),
              selectTileComp(
                titleComp: titleTextComp(
                    resvIcon: Icons.currency_yen_outlined, resvText: '金額を入力'),
                fieldInput: Container(
                    child: compInputIntType(
                  prefixText: '¥　',
                  argCallback: (value) {
                    // コールバックを渡す
                    setState(() {
                      inputPayPrice = value;
                    });
                  },
                )),
              ),
              // ====================================================================================================

              // =============================================== ③日付 ==============================================
              betweenSelectField(),
              selectTileComp(
                titleComp: titleTextComp(resvIcon: Icons.event_outlined, resvText: '使用日を入力'),
                fieldInput: Container(
                  child: compInputDateType(
                    dialogText: '日付を選択してね：',
                    resvNowInputingDate: _payDate,
                    argCallback: (date) {
                      setState(() {
                        _payDate = date;
                      });
                    },
                  ),
                )
              ),
              // ====================================================================================================

              // =============================================== ④使用場所 ==============================================
              betweenSelectField(),
              selectTileComp(
                titleComp: titleTextComp(resvIcon: Icons.location_on_outlined, resvText: '使用場所を入力'),
                fieldInput: Container(
                  child: compInputStringType(
                    argCallback: (value) { // コールバックを渡す
                      setState(() {
                        inputPlace = value; // コールバックで受け取った値を保持
                      });
                    },
                  )
                )
              ),
              // =======================================================================================================

              // =============================================== ⑤オプション ==============================================
              betweenSelectField(),
              Container(
                padding: EdgeInsets.only(left: 9, right: 9, top: 15, bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffededed),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleTextComp(
                        resvIcon: Icons.auto_fix_high_outlined,
                        resvText: 'オプション'),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          // ------------------ 「還元率?%」の長方形  ------------------
                          nowReturnRate(1.0),
                          // --------------------------------------------------------

                          SizedBox(height: 12),

                          miniInfo(passText: '支払いにより還元率が異なるため詳細を入力', placementCenter: true),

                          SizedBox(height: 12),

                          Container(
                              height: 200, // 適切な高さを設定
                              child: ListView.builder(
                                itemCount: sampleSotbsList.length,
                                itemBuilder: (context, index) {
                                  return Expanded(
                                    child: SingleOptionTextButtonNew(
                                      upperText: sampleSotbsList[index].upperText,
                                      trueLowerText: sampleSotbsList[index].trueLowerText,
                                      falseLowerText: sampleSotbsList[index].falseLowerText,
                                      initialBoolLowerText: sampleSotbsList[index].initialBoolLowerText,
                                      listIndexNum: sampleSotbsList[index].listIndexNum,
                                      argCallback: (int index) {
                                        final bool nowBool = sampleSotbsList[index].initialBoolLowerText;
                                        setState(() {
                                          sampleSotbsList[index] = sampleSotbsList[index].copyWith(
                                            initialBoolLowerText: !nowBool
                                          );
                                        });
                                      }
                                    ),
                                  );
                                }
                              )
                          ),

                          // =========================== 選択フィールド  ===========================
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: SingleOptionTextButton(
                          //         upperText: 'ポイント\n進呈',
                          //         trueLowerText: '対象',
                          //         falseLowerText: '対象外',
                          //         initialBoolLowerText: _isPointTaisho,
                          //       ),
                          //     ),
                          //     Expanded(
                          //       child: SingleOptionTextButton(
                          //         upperText: 'VPU\nプログラム',
                          //         trueLowerText: '対象',
                          //         falseLowerText: '対象外',
                          //         initialBoolLowerText: false,
                          //       ),
                          //     ),
                          //     Expanded(
                          //       child: SingleOptionTextButton(
                          //         upperText: 'LINE Pay\n経由',
                          //         trueLowerText: '対象',
                          //         falseLowerText: '対象外',
                          //         initialBoolLowerText: false,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // =======================================================================================================

              SizedBox(height: 70),

              // =============================================== 保存ボタン ==============================================
              SaveButtonComp(
                onSave: () {
                  print('保存されました');
                },
                isCanOnpress: true,
              ),
              // =======================================================================================================

            ],
          ),
        ),
      ),
    );
  }
}
