import 'package:flutter/material.dart';
import 'package:creeasy/components/display_parts/title_text_comp.dart';
import 'package:creeasy/components/display_parts/select_tile_comps/select_tile_comp.dart';
//  選択されたカード名
// import文：import 'package:creeasy/card_manage/card_manage_COMPS/selected_card_intro.dart';



Container selectedCardIntro(String? cardName) {
  return Container(
    margin: const EdgeInsets.only(top: 5),
    child: selectTileComp(
      titleComp: titleTextComp(
          resvIcon: Icons.credit_card_outlined, resvText: '選択されたカード名'),
      fieldInput: Container(
        child: Text(
          cardName ?? '未選択',
          style: const TextStyle(fontSize: 20),
        ),
      )
    ),
  );
}
