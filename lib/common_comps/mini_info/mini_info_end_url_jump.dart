import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


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
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            passText,
            style: TextStyle(
              color: customColor,
              fontSize: customTextSize,
            ),
            overflow: TextOverflow.ellipsis,
          )
        ),
        const SizedBox(width: 2),
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