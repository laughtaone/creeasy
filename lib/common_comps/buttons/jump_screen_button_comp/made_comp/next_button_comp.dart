import 'package:flutter/material.dart';
import 'package:creeasy/COMMON_COMPS/buttons/jump_screen_button_comp/no-border_button_comp.dart';


NoBorderButtonComp NextButtonComp({
  VoidCallback? argOnpressed
}) {
  return NoBorderButtonComp(buttonText: '次へ', argOnpressed: argOnpressed);
}