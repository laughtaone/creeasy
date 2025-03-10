import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
// import文：import 'package:creeasy/COMMON_COMPS/display_parts/basic_text.dart';

Padding basicText({
  required String recvText,
  double customTextSize = 16 ,
  TextAlign customTextAlign = TextAlign.center,
  List<double> customTBPadding = const [10, 10],
  List<double> customLRPadding = const [0, 0],
  bool isOneLine = false,
  int customMaxLines = 0,
}) {
  return Padding(
    padding: EdgeInsets.only(top: customTBPadding[0], bottom: customTBPadding[0], left: customLRPadding[0], right: customLRPadding[1]),
    child: AutoSizeText(
      recvText,
      style: TextStyle(fontSize: customTextSize, fontWeight: FontWeight.w500),
      textAlign: customTextAlign,
      overflow: (isOneLine) ?TextOverflow.ellipsis :null,
      maxLines: (customMaxLines!=0) ?customMaxLines :null,
    ),
  );
}