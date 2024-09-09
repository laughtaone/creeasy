import 'package:flutter/material.dart';

Container BankExampleIcon() {
  return Container(
    height: 80,
    width: 180,
    alignment: Alignment.center,
    padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(
        color: Colors.black,
        width: 2,
      )
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(Icons.account_balance_outlined),
              SizedBox(width: 10),
              Text(
                '通常口座',
                // style: TextStyle(fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Icon(Icons.savings_outlined),
              SizedBox(width: 10),
              Text(
                '口座内のボックス',
                // style: TextStyle(fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )
      ],
    ),
  );
}