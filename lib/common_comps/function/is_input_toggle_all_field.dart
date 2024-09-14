// import文：import 'package:creeasy/COMMON_COMPS/function/is_input_toggle_all_field.dart';

bool? isInputToggleAllField(parentIndex, child) {
    if (parentIndex==0) {
      return true;
    } else if (parentIndex==1) {
      if (child!=null) {
        return true;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }