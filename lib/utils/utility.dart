import 'package:equitysoft_practical/constants/colors_constant.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utility{
  static void showToast(String string) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: string,
      timeInSecForIosWeb: 3,
      backgroundColor: AppColorConstants.greyColor,
      fontSize: 16,
      textColor: AppColorConstants.whiteColor,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}