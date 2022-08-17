import 'package:authentication_and_authorization_frontend/src/app/styles/app_colors.dart';
import 'package:authentication_and_authorization_frontend/src/app/styles/app_texts.dart';
import 'package:flutter/material.dart';

ThemeData loadTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.backgroundSnackbar,
      shape: RoundedRectangleBorder(),
      contentTextStyle: AppTexts.textSnackbar,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.backgroundButton,
      height: 48.0,
      minWidth: 0.0,
      shape: RoundedRectangleBorder(),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      errorMaxLines: 1,
      hintStyle: AppTexts.hintInput,
      labelStyle: AppTexts.hintInput,
      errorStyle: AppTexts.errorMessage,
      floatingLabelStyle: AppTexts.hintInput.copyWith(
        color: AppColors.focusInput,
      ),
      fillColor: AppColors.backgroundInput,
      prefixIconColor: AppColors.iconInput,
      suffixIconColor: AppColors.iconInput,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: const BorderSide(
          width: 1.5,
          color: Colors.transparent,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: const BorderSide(
          width: 1.5,
          color: AppColors.focusInput,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: const BorderSide(
          width: 1.5,
          color: AppColors.focusInput,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: const BorderSide(
          width: 1.5,
          color: AppColors.errorInput,
        ),
      ),
    ),
  );
}
