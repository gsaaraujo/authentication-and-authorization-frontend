import 'package:authentication_and_authorization_frontend/src/app/styles/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showSnackbar({required String message}) async {
  await Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: message,
    fontSize: 14.0,
    gravity: ToastGravity.TOP,
    toastLength: Toast.LENGTH_LONG,
    textColor: AppColors.textSnackbar,
    backgroundColor: AppColors.backgroundSnackbar,
  );
}
