import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:creeasy/status/mini_card_comp.dart';
import 'package:creeasy/status/money_transfer_page.dart';
// import文：import 'package:creeasy/status/status_fundbox_tile_comp.dart';



class StatusFundboxTileComp extends StatelessWidget {
  const StatusFundboxTileComp({super.key,
    required this.fundboxName,
    required this.fundboxBalance,
    required this.gaitoCard
  });

  final String fundboxName;
  final int fundboxBalance;
  final List<String> gaitoCard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MoneyTransferPage(selectedBoxName: fundboxName, fundboxBalance: fundboxBalance,),
              fullscreenDialog: true,
            ),
          );
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xffeeeeee),
          side: const BorderSide(color: Colors.black, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          fixedSize: const Size.fromHeight(180)
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
                          fundboxName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: (fundboxName.length<9) ?22 :18
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis
                        ),
                      ],
                    ),
                  ),
                  Text(
                    formatYen(fundboxBalance),
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
              flex: 6,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      // color: Colors.amberAccent,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('該当カード', style: TextStyle(fontSize: 14, color: Colors.black),),
                          (gaitoCard.length > 4)
                            ? Text('他${gaitoCard.length > 4 ? gaitoCard.length - 4 : 0}枚 | 計${gaitoCard.length}枚', style: const TextStyle(fontSize: 13, color: Colors.black),)
                            : Text('計${gaitoCard.length}枚', style: const TextStyle(fontSize: 13, color: Colors.black),)
                        ],
                      )
                    )
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      // color: Colors.amberAccent,
                      width: double.infinity,
                      child: Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          spacing: 0, // アイテム間の水平スペース
                          runSpacing: 3.0, // アイテム間の垂直スペース
                          children: gaitoCard.take(4).map((cardName) => cardIconNameComp(cardName)).toList(),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            // -------------------------------------------------------------------------------------------------

            const SizedBox(height: 3),
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