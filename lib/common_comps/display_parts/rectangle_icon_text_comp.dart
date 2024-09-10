import 'package:flutter/material.dart';

// ↓ このコンポーネント使用時import文
// import 'package:creeasy/COMMON_COMPS/display_parts/rectangle_icon_text_comp.dart';


Container rectangleIconTextComp({
  IconData argIcon = Icons.emoji_emotions_outlined,
  String argText = '',
  Color customBackColor = Colors.white,
  Color customElementColor = Colors.black,
  double customIconSize = 15,
  double customTextSize = 14
}) {
  return Container(
    margin: const EdgeInsets.only(left: 5),
    padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
    decoration: BoxDecoration(
      color: customBackColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Icon(
          argIcon,
          size: customIconSize,
          color: customElementColor,
        ),
        const SizedBox(width: 2),
        Text(
          argText,
          style: TextStyle(
            fontSize: customTextSize,
            color: customElementColor,
          ),
        )
      ],
    ),
  );
}