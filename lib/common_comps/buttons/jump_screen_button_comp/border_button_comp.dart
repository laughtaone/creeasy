import 'package:flutter/material.dart';
// 単色・枠線ありのボタン
// デフォルトでは、背景色が薄い灰・文字色が濃い灰色・枠線が濃い灰色


class BorderButtonComp extends StatefulWidget {
  final String buttonText;
  final VoidCallback? argOnpressed;
  final Color customBackColor;
  final Color customBorderColor;
  final Color customTextColor;
  final double customFontsize;
  final BorderRadiusGeometry customBorderRadius;

  BorderButtonComp({
    required this.buttonText,
    required this.argOnpressed,
    this.customBackColor = const Color(0xffeeeeee),
    this.customBorderColor = const Color(0xff888888),
    this.customTextColor = const Color(0xff888888),
    this.customFontsize = 20.0,
    this.customBorderRadius = const BorderRadius.all(Radius.circular(15)),
  });

  @override
  _NoBorderButtonCompState createState() => _NoBorderButtonCompState();
}

class _NoBorderButtonCompState extends State<BorderButtonComp> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      height: 57,
      child: OutlinedButton(
        onPressed: widget.argOnpressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: widget.customBackColor,
          shape: RoundedRectangleBorder(
            borderRadius: widget.customBorderRadius,
          ),
          side: BorderSide(
            color: widget.customBorderColor,
            width: 1.3,
          ),
        ),
        child: Text(
          widget.buttonText,
          style: TextStyle(
            color: widget.customTextColor,
            fontSize: widget.customFontsize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

