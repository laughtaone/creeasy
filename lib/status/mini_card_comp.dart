import 'package:flutter/material.dart';
// import文：import 'package:creeasy/status/mini_card_comp.dart';


Container cardIconNameComp(String recvCardName) {
  return Container(
    margin: const EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 3),
    padding: const EdgeInsets.fromLTRB(7, 3, 7, 3),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    height: 30,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.credit_card, size: 16, color: Colors.black,),
        const SizedBox(width: 3),
        Text(recvCardName, style: const TextStyle(fontSize: 14, color: Colors.black),)
      ],
    ),
  );
}