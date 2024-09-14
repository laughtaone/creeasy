import 'package:flutter/material.dart';
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
  final double customHeight;
  final double customMainTextSize;

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
    this.customHeight = 70,
    this.customMainTextSize = 20,
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
  // -------------------------------------------------------------------------


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
      padding: const EdgeInsets.fromLTRB(10, 8, 5, 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.0),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: ListTile(
        title: Text(
          (_newSelectIndex != null)
            ? (widget.mainPrefixText == null && widget.mainSuffixText==null)
              ? widget.elementsList[_newSelectIndex ?? 0]
              : (widget.mainPrefixText!=null && widget.mainSuffixText == null)
                ? '${widget.mainPrefixText} ${widget.elementsList[_newSelectIndex ?? 0]}'
                : (widget.mainPrefixText==null && widget.mainSuffixText != null)
                  ? (widget.indexListNotneedsMainSuffixText!=null)
                    ? (widget.indexListNotneedsMainSuffixText?.contains(_newSelectIndex)==false)
                      ? '${widget.elementsList[_newSelectIndex ?? 0]} ${widget.mainSuffixText}'
                      : widget.elementsList[_newSelectIndex ?? 0]
                    : '${widget.elementsList[_newSelectIndex ?? 0]} ${widget.mainSuffixText}'
                  : (widget.indexListNotneedsMainSuffixText!=null)
                    ? (widget.indexListNotneedsMainSuffixText?.contains(_newSelectIndex)==false)
                      ? '${widget.mainPrefixText} ${widget.elementsList[_newSelectIndex ?? 0]} ${widget.mainSuffixText}'
                      : '${widget.mainPrefixText} ${widget.elementsList[_newSelectIndex ?? 0]}'
                    : '${widget.mainPrefixText} ${widget.elementsList[_newSelectIndex ?? 0]} ${widget.mainSuffixText}'
            : '未選択',
          style: TextStyle(fontSize: widget.customMainTextSize),
          overflow: TextOverflow.ellipsis
        ),
        trailing: const Icon(Icons.edit),
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
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
                    padding: const EdgeInsets.all(8.0),
                    child: Scrollbar(
                      thumbVisibility: true,
                      thickness: 2,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.elementsList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(top: 5, bottom: 5, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: const Color(0xffeeeeee),
                            ),
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
                                style: const TextStyle(fontSize: 18),
                              ),
                              onTap: () {
                                setState(() {
                                  _newSelectIndex = index;
                                });
                                widget.argCallback(_newSelectIndex); // コールバックで選択された日付を渡す
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
        },
      ),
    );
  }
}

