import 'package:flutter/material.dart';
import 'package:creeasy/components/buttons/jump_screen_button_comp/no-border_button_comp.dart';
// import文：import 'package:creeasy/COMMON_COMPS/buttons/jump_screen_button_comp/made_comp/confirm_button_comp.dart';


NoBorderButtonComp confirmButtonComp({
  required bool isCanPressNextButton,
  VoidCallback? argOnpressed
}) {
  return NoBorderButtonComp(
    buttonText: '確認へ',
    argOnpressed: argOnpressed,
    isCanPressNextButton: isCanPressNextButton,
    customBackColor: const Color(0xff0C3D6D)
  );
}