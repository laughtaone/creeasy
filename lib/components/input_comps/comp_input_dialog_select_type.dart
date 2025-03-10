import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// 入力フィールド(選択/ダイアログ形式)単体
// import文：import 'package:creeasy/COMMON_COMPS/input_comps/comp_input_dialog_select_type.dart';



class compInputDialogSelectType extends StatefulWidget {
  final List<String> elementsList;
  final int? resvNowSelectingIndex;
  final String dialogText;
  final Function(int?) argCallback; // コールバック関数
  final String? mainPrefixText;
  final String? mainSuffixText;
  final Color customBackColor;
  final String? dialogPrefixText;
  final String? dialogSuffixText;
  final List<int>? indexListNotneedsDialogSuffixText;
  final List<int>? indexListNotneedsMainSuffixText;
  final double customTBPadding;
  final List<double> customTBMargin;
  final double customMainTextSize;
  final bool canTapField;
  final String customCannotTapFieldDialog;
  final bool isRedTextUnselect;

  const compInputDialogSelectType({super.key,
    required this.elementsList,       // 選択する要素を格納したリスト（※必須）
    required this.resvNowSelectingIndex,        // 現在選択中の要素のインデックス番号
    required this.dialogText,          // 例えば「◯◯の選択：」のようにダイアログ表示時のテキスト
    required this.argCallback,         // コールバック関数
    this.mainPrefixText,
    this.mainSuffixText,                  // 表示するテキストの末尾につける単位
    this.customBackColor = Colors.white,
    this.dialogPrefixText,
    this.dialogSuffixText,
    this.indexListNotneedsDialogSuffixText,
    this.indexListNotneedsMainSuffixText,
    this.customTBPadding = 8,
    this.customTBMargin = const [10, 10],
    this.customMainTextSize = 20,
    this.canTapField = true,
    this.customCannotTapFieldDialog = '',
    this.isRedTextUnselect = false,
  });

  @override
  _compInputDialogSelectTypeState createState() =>
      _compInputDialogSelectTypeState();
}

class _compInputDialogSelectTypeState extends State<compInputDialogSelectType> {
  // -------------------------------- 変数処理 --------------------------------
  int? _newSelectIndex; // 選択中の要素のインデックス

  @override
  void initState() {
    super.initState();
    _newSelectIndex = widget.resvNowSelectingIndex;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, widget.customTBMargin[0], 10, widget.customTBMargin[1]),
      padding: EdgeInsets.fromLTRB(12, widget.customTBPadding, 12, widget.customTBPadding),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.0),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: ListTile(
        // title: Text(widget.resvNowSelectingIndex.toString()),
        title: Text(
          (widget.resvNowSelectingIndex != null)
            ? (widget.mainPrefixText == null && widget.mainSuffixText==null)
              ? widget.elementsList[widget.resvNowSelectingIndex ?? 0]
              : (widget.mainPrefixText!=null && widget.mainSuffixText == null)
                ? '${widget.mainPrefixText} ${widget.elementsList[widget.resvNowSelectingIndex ?? 0]}'
                : (widget.mainPrefixText==null && widget.mainSuffixText != null)
                  ? (widget.indexListNotneedsMainSuffixText!=null)
                    ? (widget.indexListNotneedsMainSuffixText?.contains(widget.resvNowSelectingIndex)==false)
                      ? '${widget.elementsList[widget.resvNowSelectingIndex ?? 0]} ${widget.mainSuffixText}'
                      : widget.elementsList[widget.resvNowSelectingIndex ?? 0]
                    : '${widget.elementsList[widget.resvNowSelectingIndex ?? 0]} ${widget.mainSuffixText}'
                  : (widget.indexListNotneedsMainSuffixText!=null)
                    ? (widget.indexListNotneedsMainSuffixText?.contains(widget.resvNowSelectingIndex)==false)
                      ? '${widget.mainPrefixText} ${widget.elementsList[widget.resvNowSelectingIndex ?? 0]} ${widget.mainSuffixText}'
                      : '${widget.mainPrefixText} ${widget.elementsList[widget.resvNowSelectingIndex ?? 0]}'
                    : '${widget.mainPrefixText} ${widget.elementsList[widget.resvNowSelectingIndex ?? 0]} ${widget.mainSuffixText}'
            : '未選択',
          style: TextStyle(
            fontSize: widget.customMainTextSize,
            color: (widget.resvNowSelectingIndex == null && widget.isRedTextUnselect==true) ? Colors.red :null
          ),
          overflow: TextOverflow.ellipsis
        ),
        trailing: const Icon(Icons.edit),
        onTap: (widget.canTapField)
        ? () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                insetPadding: const EdgeInsets.only(left: 35, right: 35),
                title: Text(widget.dialogText),
                backgroundColor: const Color(0xffffffff),
                content: Container(
                  width: double.maxFinite,
                  height: 300,
                  decoration: BoxDecoration(
                    // color: Color(0xffdddddd),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Scrollbar(
                      thumbVisibility: true,
                      thickness: 2,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.elementsList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 60,
                            margin: const EdgeInsets.only(top: 6, bottom: 6, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: const Color(0xffeeeeee),
                            ),
                            alignment: Alignment.center,
                            child: ListTile(
                              title: Text(
                                (widget.dialogPrefixText == null && widget.dialogSuffixText==null)
                                  ? widget.elementsList[index]
                                  : (widget.dialogPrefixText!=null && widget.dialogSuffixText == null)
                                    ? '${widget.dialogPrefixText} ${widget.elementsList[index]}'
                                    : (widget.dialogPrefixText==null && widget.dialogSuffixText != null)
                                      ? (widget.indexListNotneedsDialogSuffixText!=null)
                                        ? (widget.indexListNotneedsDialogSuffixText?.contains(index) == false)
                                          ? '${widget.elementsList[index]} ${widget.dialogSuffixText}'
                                          : widget.elementsList[index]
                                        : '${widget.elementsList[index]} ${widget.dialogSuffixText}'
                                      : '${widget.dialogPrefixText} ${widget.elementsList[index]} ${widget.dialogSuffixText}'
                                ,
                                style: TextStyle(fontSize: (widget.elementsList[index].length>=12) ?15 :19),
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {
                                _newSelectIndex = index;
                                setState(() {
                                  _newSelectIndex = index;
                                });
                                widget.argCallback(_newSelectIndex);
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
                    child: const Text(
                      'キャンセル',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              );
            },
          );
        }
        : () {
          showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text('エラー', style: TextStyle(fontSize: 22)),
                content: const Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  child: Text('ブランドが未選択です\nブランドを選択してから\n再度試行してください', style: TextStyle(fontSize: 17)),
                ),
                actions: [
                  CupertinoDialogAction(
                    child: Text('OK'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
            }
          );
        },
      ),
    );
  }
}

