import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

// =============================================================== サブタイトルのコンポーネント ===============================================================
Row titleTextComp({
  IconData? resvIcon,
  String resvText = '',
  double resvTextSize = 18,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(width: 2),
      (resvIcon != null)
          ? Icon(
              resvIcon,
              size: 23,
            )
          : SizedBox.shrink(),
      SizedBox(width: 5),
      Text(
        resvText,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: resvTextSize,
        ),
      ),
    ],
  );
}
// ======================================================================================================================================================

// ================================= 整数だけを受け付ける入力フィールド(例：「金額を入力」)で最初に0を1つしか入力できないようにするクラス =================================
class ZeroLimitFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 新しい値が空の場合、そのまま新しい値を返す
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // 数値が '0' ならそのまま許可（最初の入力として）
    if (newValue.text == '0') {
      return newValue;
    }

    // '0' で始まるが、'0'単独ではない場合は前の値に戻す
    if (newValue.text.startsWith('0') && newValue.text.length > 1) {
      return oldValue;
    }

    // 整数に変換して0以上の値のみ許可
    final int? value = int.tryParse(newValue.text);
    if (value == null || value < 0) {
      return oldValue;
    }

    return newValue;
  }
}
// ======================================================================================================================================================

// ================================================================== 選択フィールド間の余白 ==================================================================
SizedBox betweenSelectField({double customHeight = 20}) {
  return SizedBox(height: customHeight);
}
// =======================================================================================================================================================

// ==================================== 整数と小数だけを受け付ける入力フィールド(例：「還元率を入力」)で正常に入力できるようにするクラス ====================================
// 整数と小数を受け取るフォーマッター
class DecimalTextInputFormatter extends TextInputFormatter {
  final RegExp _regExp = RegExp(r'^\d*\.?\d*');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (_regExp.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}

// 整数と小数だけを受け付ける入力フィールドで、最初に0を1つしか最初に入力できないようにするもの
class ZeroLimitFormatterForDouble extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 新しい値が空の場合、そのまま新しい値を返す
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // '0' のみは許可
    if (newValue.text == '0') {
      return newValue;
    }

    // '0.' で始まる場合も許可
    if (newValue.text == '0.') {
      return newValue;
    }

    // '0' で始まるが、その後に数字が続く場合は最初の '0' を削除
    if (newValue.text.startsWith('0') && !newValue.text.startsWith('0.')) {
      return oldValue;
    }

    // 小数点を含む数値を許可
    final double? value = double.tryParse(newValue.text);
    if (value == null || value < 0) {
      return oldValue;
    }

    return newValue;
  }
}
// =======================================================================================================================================================

// ============================================================ 各選択フィールドの上の小さい注意書き ============================================================
Container miniInfo(
    {String passText = '', // 表示するテキスト
    IconData customIcon = Icons.info_outline, // カスタムアイコン(カスタムしない場合はデフォ値のiマーク)
    bool needsIcon = true, // アイコンが必要かどうか
    Color doukaColor = const Color(0xffededed), // アイコンが不要な時に背景色と同じにして同化できる色
    bool needsTBPadding = true, // topとbottomに余白が必要か
    double customTextSize = 13, // テキストサイズ(デフォは13)
    Color customColor = Colors.black}) {
  return Container(
    padding: EdgeInsets.only(
      left: 4,
      top: (needsTBPadding) ? 2 : 0,
      right: 7,
      bottom: (needsTBPadding) ? 2 : 0,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(2),
          child: Icon(
            customIcon,
            size: (customTextSize == 13) ? 15 : customTextSize * 1.1538,
            color: (needsIcon) ? customColor : doukaColor,
          ),
        ),
        SizedBox(width: 4),
        Flexible(
            child: Text(passText,
                style: TextStyle(
                  color: customColor,
                  fontSize: customTextSize,
                ))),
      ],
    ),
  );
}
// =======================================================================================================================================================

// =========================================================== 縦に並んだ選択肢から選ばせるコンポーネント ===========================================================
class OptionTextButtonOneLine extends StatefulWidget {
  final List textList;
  final Function(int?) onItemSelected;
  final double textFontSize;

  OptionTextButtonOneLine({
    required this.textList,
    required this.onItemSelected,
    this.textFontSize = 15, // textFonSizeだけデフォ値を設定
  });

  @override
  _OptionTextButtonOneLineState createState() =>
      _OptionTextButtonOneLineState();
}

class _OptionTextButtonOneLineState extends State<OptionTextButtonOneLine> {
  int? selectedIndex; // 選択中の要素のインデックス

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.textList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(
                top: (index == 0) ? 0 : 7, bottom: 7, right: 10, left: 10),
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size(130, 58),
                backgroundColor: (selectedIndex == index)
                    ? Color(0xffdedede)
                    : Color(0xfffefefe),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ).copyWith(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onItemSelected(index);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    color:
                        (selectedIndex == index) ? Colors.black : Colors.white,
                  ),
                  SizedBox(width: 6),
                  Text(
                    widget.textList[index],
                    style: TextStyle(
                      fontSize: widget.textFontSize,
                      color: Color(0xff444444),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
// =======================================================================================================================================================

// ===================================================== URLを受け取り画面遷移(直後項のminiInfoEndUrlJumpで使用) ====================================================
Future viewWebsite(String recvUrl) async {
  final url = Uri.parse(recvUrl);
  launchUrl(url);
}
// ==========================================================================================================================================================

// =========================================================== 末尾の「こちら」で画面遷移できるminiInfoEndUrlJump ===================================================
Container miniInfoEndUrlJump({
  String passText = '', // 表示するテキスト
  IconData customIcon = Icons.info_outline, // カスタムアイコン(カスタムしない場合はデフォ値のiマーク)
  bool needsIcon = true, // アイコンが必要かどうか
  Color doukaColor = const Color(0xffededed), // アイコンが不要な時に背景色と同じにして同化できる色
  bool needsTBPadding = true, // topとbottomに余白が必要か
  double customTextSize = 13, // テキストサイズ(デフォは13)
  Color customColor = Colors.black,
  String passUrl = '', // 遷移したいURL
}) {
  return Container(
    padding: EdgeInsets.only(
      left: 4,
      top: (needsTBPadding) ? 2 : 0,
      right: 7,
      bottom: (needsTBPadding) ? 2 : 0,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(2),
          child: Icon(
            customIcon,
            size: (customTextSize == 13) ? 15 : customTextSize * 1.1538,
            color: (needsIcon) ? customColor : doukaColor,
          ),
        ),
        SizedBox(width: 4),
        Flexible(
            child: Text(passText,
                style: TextStyle(
                  color: customColor,
                  fontSize: customTextSize,
                ))),
        SizedBox(width: 2),
        RichText(
            text: TextSpan(children: [
          WidgetSpan(
            child: GestureDetector(
              onTap: () {
                // VPAPの公式サイトへ遷移
                viewWebsite(passUrl);
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
  );
}
// ==========================================================================================================================================================

// ==================================================== ページを受け取り画面遷移(直後項のminiInfoEndPageJumpで使用) ===============================================
Future jumpFromPageToPage(String recvUrl) async {
  final url = Uri.parse(recvUrl);
  launchUrl(url);
}
// ==========================================================================================================================================================

// ======================================================== 末尾の「こちら」で画面遷移できるminiInfoEndPageJump ===================================================
class miniInfoEndPageJump extends StatefulWidget {
  final String passText; // 表示するテキスト
  final IconData customIcon; // カスタムアイコン(カスタムしない場合はデフォ値のiマーク)
  final bool needsIcon; // アイコンが必要かどうか
  final Color doukaColor; // アイコンが不要な時に背景色と同じにして同化できる色
  final bool needsTBPadding; // topとbottomに余白が必要か
  final double customTextSize; // テキストサイズ(デフォは13)
  final Color customColor;
  final Widget jumpPage; // 遷移したいページ

  miniInfoEndPageJump(
      {required this.passText,
      this.customIcon = Icons.info_outline,
      this.needsIcon = true,
      this.doukaColor = const Color(0xffededed),
      this.needsTBPadding = true,
      this.customTextSize = 13,
      this.customColor = Colors.black,
      required this.jumpPage});

  @override
  _miniInfoEndPageJumpState createState() => _miniInfoEndPageJumpState();
}

class _miniInfoEndPageJumpState extends State<miniInfoEndPageJump> {
  // -------------------------------- 変数処理 --------------------------------
  // int? _newSelectedBankIndex; // 新しく選択した銀行のインデックス番号

  // @override
  // void initState() {
  //   super.initState();
  //   _newSelectedBankIndex = widget.resvNowSelectingBankIndex; // 初期化処理
  // }
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 4,
        top: (widget.needsTBPadding) ? 2 : 0,
        right: 7,
        bottom: (widget.needsTBPadding) ? 2 : 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(2),
            child: Icon(
              widget.customIcon,
              size: (widget.customTextSize == 13)
                  ? 15
                  : widget.customTextSize * 1.1538,
              color:
                  (widget.needsIcon) ? widget.customColor : widget.doukaColor,
            ),
          ),
          const SizedBox(width: 4),
          Flexible(
              child: Text(widget.passText,
                  style: TextStyle(
                    color: widget.customColor,
                    fontSize: widget.customTextSize,
                  ))),
          const SizedBox(width: 2),
          RichText(
              text: TextSpan(children: [
            WidgetSpan(
              child: GestureDetector(
                onTap: () {
                  // 指定されたページへ遷移
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => widget.jumpPage,
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
    );
  }
}
// ==========================================================================================================================================================

// ======================================================================= 保存ボタン =======================================================================
class SaveButtonComp extends StatefulWidget {
  final Function onSave;
  final bool isCanOnpress;

  SaveButtonComp(
      {required this.onSave,
      this.isCanOnpress = false // 押せるかどうかの真偽値(デフォでfalse=押せない)
      });

  @override
  _SaveButtonCompState createState() => _SaveButtonCompState();
}

class _SaveButtonCompState extends State<SaveButtonComp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, bottom: 30),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            height: 57,
            width: double.infinity,
            child: OutlinedButton(
                // --------------------------------------- ダイアログ表示 ---------------------------------------
                onPressed: (widget.isCanOnpress)
                    ? () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  '本当に保存しますか？',
                                  style: TextStyle(fontSize: 20),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => {Navigator.pop(context)},
                                    child: Text('キャンセル',
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      widget.onSave();
                                      Navigator.pop(context);
                                    },
                                    child: Text('保存'),
                                  ),
                                ],
                              );
                            });
                      }
                    : null,
                // ----------------------------------------------------------------------------------------------
                style: OutlinedButton.styleFrom(
                    backgroundColor: (widget.isCanOnpress)
                        ? Color(0xfffff0f0)
                        : Color(0xfff0f0f0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: BorderSide(
                      color: (widget.isCanOnpress)
                          ? Color(0xffff6666)
                          : Color(0xff959595),
                      width: 1.7,
                    )),
                child: Text(
                  '保存して閉じる',
                  style: TextStyle(
                      color: (widget.isCanOnpress)
                          ? Color(0xffff5555)
                          : Color(0xff909090),
                      fontSize: 16),
                )),
          ),
          SizedBox(height: 12),
          Text(
            '保存せずに閉じるには\n右上の×ボタン or 左上の<ボタン を押してください',
            style: TextStyle(
              fontSize: 11.5,
              color: Colors.black38,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
// ==========================================================================================================================================================

// ======================================================================= 右上の×ボタン ======================================================================
class ToprightCloseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.only(right: 20),
      icon: const Icon(Icons.close, size: 27),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
// ==========================================================================================================================================================

// ========================================================================= 注意書き =========================================================================
Container cautionComp(Column details) {
  return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xfff0f0a0), width: 3),
        color: Color(0xffffffe7),
      ),
      child: Column(
        children: [
          titleTextComp(
              resvText: '注意', resvIcon: Icons.report_problem_outlined),
          details
        ],
      ));
}

// ==========================================================================================================================================================

// ================================================================== 何かと何かの間のアイコン ==================================================================
Padding betweenIcon(IconData recvIcon) {
  return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Icon(recvIcon, size: 27));
}
// ==========================================================================================================================================================

// ======================================================================== 選択タイル ========================================================================
class selectTileComp extends StatefulWidget {
  final Widget titleComp;
  final Column? guides;
  final Container fieldInput;
  final Color customBackColor;

  selectTileComp(
      {required this.titleComp, // コンポーネントtitleTextCompを指定（必須・引数  IconData? resvIcon, String resvText(デフォは''), double resvTextSize(デフォは18)）
      this.guides, // ColumnのchildrenでminiInfoを並べる（任意）
      required this.fieldInput, // ユーザーからの入力フィールドを指定（必須・入力フィールドのコンポーネントの指定を推奨）
      this.customBackColor = const Color(0xffededed)        // カスタム背景色（任意・デフォで色を設定済み）
      });

  @override
  _selectTileCompState createState() => _selectTileCompState();
}

class _selectTileCompState extends State<selectTileComp> {
  int? selectedIndex; // 選択中の要素のインデックス

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 9, right: 9, top: 15, bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.customBackColor,
      ),
      child: Column(
        children: [
          widget.titleComp,
          widget.guides ?? const SizedBox(height: 5),
          widget.fieldInput
        ],
      ),
    );
  }
}
// ==========================================================================================================================================================

// ================================================================ 入力フィールド(選択形式)単体 ================================================================
class compInputSelectType extends StatefulWidget {
  final List<String> elementsList;
  final int? resvNowSelectingIndex;
  final String dialogText;

  compInputSelectType(
      {required this.elementsList, // 選択する要素を格納したリスト（※必須）
      required this.resvNowSelectingIndex, // 現在選択中の要素のインデックス番号
      required this.dialogText // 例えば「◯◯の選択：」のようにダイアログ表示時のテキスト
      });

  @override
  _compInputSelectType createState() => _compInputSelectType();
}

class _compInputSelectType extends State<compInputSelectType> {
  int? _newSelectIndex; // 選択中の要素のインデックス

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          fixedSize: Size(double.infinity, 70),
          backgroundColor: Color(0xfffefefe),
        ),
        child: ListTile(
          title: Text(
              (_newSelectIndex != null)
                  ? widget.elementsList[_newSelectIndex ?? 0]
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
                title: Text(widget.dialogText),
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
                        itemCount: widget.elementsList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(
                                top: 5, bottom: 5, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Color(0xffeeeeee),
                            ),
                            child: ListTile(
                              title: Text(widget.elementsList[index],
                                  style: TextStyle(fontSize: 18)),
                              onTap: () {
                                setState(() {
                                  _newSelectIndex = index;
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
    );
  }
}
// ==========================================================================================================================================================