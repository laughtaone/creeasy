import 'package:flutter/material.dart';
import 'package:creeasy/components/buttons/jump_screen_button_comp/border_button_comp.dart';

BorderButtonComp ChokusetsuNyuuryokuButtonComp({
  VoidCallback? argOnpressed
}) {
  return BorderButtonComp(
    buttonText: 'プリセットされていないため直接入力',
    customFontsize: 17,
    argOnpressed: argOnpressed
  );
}