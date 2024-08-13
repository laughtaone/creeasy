import 'package:flutter/material.dart';
import 'package:creeasy/home/home.dart';

class HomeCardTile extends StatelessWidget {
  const HomeCardTile({
    required this.card_name,
    required this.month_price,
  });

  final String card_name;
  final int month_price;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: null,
        style: OutlinedButton.styleFrom(
          backgroundColor: Color(0xffeeeeee),
          side: BorderSide(color: Colors.black, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              card_name,
            ),
            Text(month_price.toString())
          ],
        ),
      ),
    );
  }
}
