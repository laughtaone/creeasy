import 'package:flutter/material.dart';


Container cardIconNameComp(String recvCardName) {
  return Container(
    margin: const EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 3),
    padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    height: 37,
    width: 142,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 2),
        const Icon(Icons.credit_card, size: 18, color: Colors.black,),
        const SizedBox(width: 3),
        Expanded(
          child: Text(
            recvCardName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: (recvCardName.length<7) ?15.5 :13,
              color: const Color(0xff444444),
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    ),
  );
}