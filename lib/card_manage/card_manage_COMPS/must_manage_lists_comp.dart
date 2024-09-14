import 'package:flutter/material.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/title_text_comp.dart';
import 'package:creeasy/COMMON_COMPS/mini_info/mini_info.dart';
import 'package:creeasy/COMMON_COMPS/display_parts/select_tile_comps/select_tile_comp.dart';
// import文：import 'package:creeasy/card_manage/card_manage_COMPS/must_manage_lists_comp.dart';


selectTileComp mustManageListComp() {
  return selectTileComp(
    customBackColor: const Color(0xfff2f2f2),
    titleComp: titleTextComp(resvText: '必須項目', resvTextSize: 20),
    fieldInput: Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Column(children: [
        const Text('次の2つの項目はデフォルトで管理され、これらの管理をオフにすることはできません', style: TextStyle(fontSize: 15)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            // color: const Color(0xffe8e8e8),
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Align(child: SizedBox(
            width: 170,
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                miniInfo(passText: '使用金額', customIcon: Icons.currency_yen_outlined, customTextSize: 17, isLimitOneline: true),
                miniInfo(passText: '口座残高の確保', customIcon: Icons.account_balance_wallet_outlined, customTextSize: 17, isLimitOneline: true),
              ],
            ),
          )),
        ),
      ]),
    )
  );
}