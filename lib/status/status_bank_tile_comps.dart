import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import文：import 'package:creeasy/status/status_bank_tile_comps.dart';




class StatusBankTileComp extends StatelessWidget {
  const StatusBankTileComp({super.key,
    required this.bankName,
    required this.bankBalance,
  });

  final String bankName;
  final int bankBalance;

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
          fixedSize: const Size.fromHeight(80)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bankName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: (bankName.length<9) ?22 :19
                    ),
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
    );
  }
}



// intを受け取り¥と,をつけて返す
String formatYen(int amount) {
  final formatter = NumberFormat('#,###', 'ja_JP');
  return '¥${formatter.format(amount)}';
}