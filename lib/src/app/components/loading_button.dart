import 'package:flutter/material.dart';
import 'package:authentication_and_authorization_frontend/src/app/styles/app_texts.dart';
import 'package:authentication_and_authorization_frontend/src/app/styles/app_colors.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    Key? key,
    required this.title,
    required this.onPress,
    this.width,
    this.isLoading = false,
  }) : super(key: key);

  final String title;
  final VoidCallback onPress;
  final double? width;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPress,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: Size(width ?? 0.0, 48.0),
        primary: AppColors.backgroundButton,
      ),
      child: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: AppColors.backgroundButton,
              ),
            )
          : Text(title, style: AppTexts.textButton),
    );
  }
}
