import 'package:flutter/material.dart';
// 単色・枠線なしのボタン
// デフォルトでは、背景色が黒・文字色が白


class NoBorderButtonComp extends StatefulWidget {
  final String buttonText;
  final VoidCallback? argOnpressed;
  final Color customBackColor;
  final Color customTextColor;
  final double customFontsize;
  final BorderRadiusGeometry customBorderRadius;

  const NoBorderButtonComp({super.key, 
    required this.buttonText,
    required this.argOnpressed,
    this.customBackColor = const Color(0xff333333),
    this.customTextColor = Colors.white,
    this.customFontsize = 20.0,
    this.customBorderRadius = const BorderRadius.all(Radius.circular(15)),
  });

  @override
  _NoBorderButtonCompState createState() => _NoBorderButtonCompState();
}

class _NoBorderButtonCompState extends State<NoBorderButtonComp> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      height: 57,
      child: OutlinedButton(
        onPressed: widget.argOnpressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: widget.customBackColor,
          shape: RoundedRectangleBorder(
            borderRadius: widget.customBorderRadius,
          ),
        ),
        child: Text(
          widget.buttonText,
          style: TextStyle(
            color: widget.customTextColor,
            fontSize: widget.customFontsize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// // 単色・枠線なしのボタン
// // デフォルトでは、背景色が黒・文字色が白


// class NoBorderButtonComp extends StatefulWidget {
//   final String buttonText;
//   final VoidCallback onPressed;
//   final Color customBackColor;
//   final Color customTextColor;
//   final double customFontsize;
//   final BorderRadiusGeometry customBorderRadius;

//   NoBorderButtonComp({
//     required this.buttonText,
//     required this.onPressed,
//     this.customBackColor = const Color(0xff333333),
//     this.customTextColor = Colors.white,
//     this.customFontsize = 20.0,
//     this.customBorderRadius = const BorderRadius.all(Radius.circular(15)),
//   });

//   @override
//   _NoBorderButtonCompState createState() => _NoBorderButtonCompState();
// }

// class _NoBorderButtonCompState extends State<NoBorderButtonComp> {

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(left: 10, right: 10),
//       height: 57,
//       child: OutlinedButton(
//         onPressed: widget.onPressed,
//         style: OutlinedButton.styleFrom(
//           backgroundColor: widget.customBackColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: widget.customBorderRadius,
//           ),
//         ),
//         child: Text(
//           widget.buttonText,
//           style: TextStyle(
//             color: widget.customTextColor,
//             fontSize: widget.customFontsize,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }