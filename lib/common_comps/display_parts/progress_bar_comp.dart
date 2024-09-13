import 'package:flutter/material.dart';
// import文：import 'package:creeasy/COMMON_COMPS/display_parts/progress_bar_comp.dart';


Padding progressBarComp({
  required int ratioProg,
  required int ratioNotprog,
  double customHeight = 5,
  Color customProgColor = const Color(0xff678fff),
  Color customNotprogColor = Colors.black12
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 13),
    child: Row(children: [
      Expanded(flex: ratioProg, child: Container(height: customHeight, color: customProgColor)),
      Expanded(flex: ratioNotprog, child: Container(height: customHeight, color: customNotprogColor)),
    ]),
  );
}