import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';


class SingleOptionTextButton extends StatefulWidget {
  final String upperText;
  final String trueLowerText;
  final String falseLowerText;
  final bool initialBoolLowerText;


  const SingleOptionTextButton({super.key, 
    required this.upperText,
    required this.trueLowerText,
    required this.falseLowerText,
    required this.initialBoolLowerText,
  });

  @override
  _SingleOptionTextButtonState createState() => _SingleOptionTextButtonState();
}


class _SingleOptionTextButtonState extends State<SingleOptionTextButton> {
  late bool isBoolLowerText;

  @override
  void initState() {
    super.initState();
    isBoolLowerText = widget.initialBoolLowerText; // 初期状態を設定
  }

  void toggleText() {
    setState(() {
      isBoolLowerText = !isBoolLowerText;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: TextButton(
        style: TextButton.styleFrom(
          fixedSize: const Size(120, 120),
          backgroundColor:
            (isBoolLowerText)
            ? const Color(0xfffefefe)
            : const Color(0xffdedede),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ).copyWith(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
        onPressed: () {
          toggleText();
          print('Button pressed');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ===================== 上部分 =====================
            Expanded(
              flex: 1,
              child: Center(
                child: AutoSizeText(
                  widget.upperText,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Color(0xff444444),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2, // 必要に応じて行数を設定
                  minFontSize: 10, // 最小フォントサイズを設定
                ),
              ),
            ),
            // =================================================

            // ===================== 下部分 =====================
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: AutoSizeText(
                      (isBoolLowerText) ? widget.trueLowerText : widget.falseLowerText,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 30,
                      ),
                      maxLines: 2, // 必要に応じて行数を設定
                      minFontSize: 10, // 最小フォントサイズを設定
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'タップして変更',
                      style: TextStyle(
                        fontSize: 9,
                        color: Color(0xff999999),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // =================================================
          ],
        ),
      ),
    );
  }
}
