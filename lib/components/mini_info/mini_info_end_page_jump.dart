import 'package:flutter/material.dart';
// 末尾の「こちら」で画面遷移できるminiInfoEndPageJump


class miniInfoEndPageJump extends StatefulWidget {
  final String passText; // 表示するテキスト
  final IconData customIcon; // カスタムアイコン(カスタムしない場合はデフォ値のiマーク)
  final bool needsIcon; // アイコンが必要かどうか
  final Color doukaColor; // アイコンが不要な時に背景色と同じにして同化できる色
  final bool needsTBPadding; // topとbottomに余白が必要か
  final double customTextSize; // テキストサイズ(デフォは13)
  final Color customColor;
  final Widget jumpPage; // 遷移したいページ

  const miniInfoEndPageJump(
      {super.key, required this.passText,
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