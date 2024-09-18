import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ↓ このコンポーネント使用時import文
// import 'package:creeasy/COMMON_COMPS/display_parts/rectangle_icon_text_comp.dart';


Container rectangleIconTextComp({
  IconData argIcon = Icons.emoji_emotions_outlined,
  String argText = '',
  Color customBackColor = Colors.white,
  Color customElementColor = Colors.black,
  double customIconSize = 15,
  double customTextSize = 14,
  bool isMinMainAxisSize = false,
  double customBetween = 2,
  int customMaxLines = 1,
  double? customHeight = null,
}) {
  return Container(
    margin: const EdgeInsets.only(left: 5),
    padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
    decoration: BoxDecoration(
      color: customBackColor,
      borderRadius: BorderRadius.circular(12),
    ),
    height: customHeight,
    child: Row(
      mainAxisSize: (isMinMainAxisSize) ? MainAxisSize.min : MainAxisSize.max,
      children: [
        Icon(
          argIcon,
          size: customIconSize,
          color: customElementColor,
        ),
        SizedBox(width: customBetween),
        Flexible(
          child: Text(
            argText,
            style: TextStyle(
              fontSize: customTextSize,
              color: customElementColor,
            ),
            maxLines: customMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    ),
  );
}