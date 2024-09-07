import 'package:flutter/material.dart';
import 'package:creeasy/common_comps/title_text_comp.dart';
// 注意書き



Container cautionComp(Column details) {
  return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xfff0f0a0), width: 3),
        color: Color(0xffffffe7),
      ),
      child: Column(
        children: [
          titleTextComp(
              resvText: '注意', resvIcon: Icons.report_problem_outlined),
          details
        ],
      ));
}
