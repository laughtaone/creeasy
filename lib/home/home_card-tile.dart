import 'package:flutter/material.dart';
import 'package:creeasy/home/home.dart';
import 'package:intl/intl.dart';

class HomeCardTile extends StatelessWidget {
  const HomeCardTile({
    required this.card_name,
    required this.month_price,
  });

  final String card_name;
  final int month_price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: OutlinedButton(
        onPressed: null,
        style: OutlinedButton.styleFrom(
          backgroundColor: Color(0xffeeeeee),
          side: BorderSide(color: Colors.black, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          fixedSize: Size.fromHeight(75)
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
                    card_name,
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ),
                ],
              ),
            ),
            Text(
              formatYen(month_price),
              style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w700),
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