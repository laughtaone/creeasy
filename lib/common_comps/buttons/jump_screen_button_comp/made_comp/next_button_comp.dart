import 'package:flutter/material.dart';
import 'package:creeasy/COMMON_COMPS/buttons/jump_screen_button_comp/no-border_button_comp.dart';
// import文：import 'package:creeasy/COMMON_COMPS/buttons/jump_screen_button_comp/made_comp/next_button_comp.dart';


NoBorderButtonComp NextButtonComp({
  required bool isCanPressNextButton,
  VoidCallback? argOnpressed
}) {
  return NoBorderButtonComp(
    buttonText: '次へ',
    argOnpressed: argOnpressed,
    isCanPressNextButton: isCanPressNextButton,
  );
}