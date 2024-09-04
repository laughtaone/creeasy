import 'package:flutter/material.dart';

class OptionTextButton extends StatefulWidget {
  final List textList;
  final Function(int?) onItemSelected;

  OptionTextButton({
    required this.textList,
    required this.onItemSelected,
  });

  @override
  _OptionTextButtonState createState() => _OptionTextButtonState();
}

class _OptionTextButtonState extends State<OptionTextButton> {
  int? selectedIndex; // 選択中の要素のインデックス

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.textList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size(130, 5),
                backgroundColor: (selectedIndex == index)
                    ? Color(0xffdedede)
                    : Color(0xfffefefe),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ).copyWith(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onItemSelected(index);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    color:
                        (selectedIndex == index) ? Colors.black : Colors.white,
                  ),
                  SizedBox(width: 4),
                  Text(
                    widget.textList[index],
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff444444),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
