import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:creeasy/status/mini_card_comp.dart';
// import文：import 'package:creeasy/status/status_bank_tile_comps.dart';




class StatusBankTileComp extends StatelessWidget {
  const StatusBankTileComp({super.key,
    required this.bankName,
    required this.bankBalance,
    required this.gaitoCard
  });

  final String bankName;
  final int bankBalance;
  final List<String> gaitoCard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: OutlinedButton(
        onPressed: null,
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xffeeeeee),
          side: const BorderSide(color: Colors.black, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          fixedSize: const Size.fromHeight(165)
        ),
        child: Column(
          children: [
            // --------------------------------------------- 上部分 ---------------------------------------------
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bankName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: (bankName.length<9) ?22 :18
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis
                        ),
                      ],
                    ),
                  ),
                  Text(
                    formatYen(bankBalance),
                    style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            // -------------------------------------------------------------------------------------------------

            const Divider(height: 2, color: Colors.black),
            const SizedBox(height: 3),

            // --------------------------------------------- 下部分 ---------------------------------------------
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.amberAccent,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('該当カード', style: TextStyle(fontSize: 13, color: Colors.black),),
                          Text('他枚', style: TextStyle(fontSize: 13, color: Colors.black),),
                        ],
                      )
                    )
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                      child: Container(
                        color: Colors.amberAccent,
                        // 外側のContainerに制約を設ける
                        constraints: BoxConstraints(
                          maxHeight: 200, // 必要に応じて高さを調整
                        ),
                        width: double.infinity,
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            spacing: 0, // アイテム間の水平スペース
                            runSpacing: 3.0, // アイテム間の垂直スペース
                            children: gaitoCard.take(2).map((cardName) => cardIconNameComp(cardName)).toList(),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
            // -------------------------------------------------------------------------------------------------
          ],
        ),
      ),
    );
  }
}



// intを受け取り¥と,をつけて返す
String formatYen(int amount) {
  final formatter = NumberFormat('#,###', 'ja_JP');
  return '¥${formatter.format(amount)}';
}