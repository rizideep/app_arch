import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_constant.dart';
import 'app_colors.dart';

final lightTheme = ThemeData(
  cardColor: backgroundColor,
  appBarTheme: const AppBarTheme(
    shadowColor: Colors.transparent,
    elevation: 0.0,
    centerTitle: true,
    backgroundColor: colorsBlue100,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  ),
  useMaterial3: true,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Colors.grey, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    ),
    labelStyle: const TextStyle(fontSize: 14, color: Colors.black),
    hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
    errorStyle: const TextStyle(fontStyle: FontStyle.italic, color: Colors.red),
    filled: true,
    fillColor: Colors.grey[50],
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: colorWhite,
  ),
  scaffoldBackgroundColor: backgroundColor,
  unselectedWidgetColor: colorGrayBackground,
  brightness: Brightness.dark,
  fontFamily: "poppins",
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: primaryColor,
    onPrimary: onPrimaryColor,
    surfaceVariant: onBackgroundColor,
    primaryContainer: primaryContainerColor,
    onPrimaryContainer: onPrimaryContainerColor,
    secondary: secondaryColor,
    onSecondary: onSecondaryColor,
    secondaryContainer: secondaryColor,
    onSecondaryContainer: onSecondaryContainerColor,
    error: errorColor,
    onError: onErrorColor,
    brightness: Brightness.dark,
    surface: surfaceColor,
    onSurface: onSurfaceColor,
    surfaceTint: Colors.transparent,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: textColorBlack,
      fontFamily: AppConstant.appFontInter,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: textColorBlack,
      fontFamily: AppConstant.appFontInter,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: textColorBlack,
      fontFamily: AppConstant.appFontInter,
    ),
    headlineLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: textColorBlack,
      fontFamily: AppConstant.appFontInter,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: textColorBlack,
      fontFamily: AppConstant.appFontInter,
    ),
    headlineSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: textColorBlack,
      fontFamily: AppConstant.appFontInter,
    ),
    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: textColorBlack,
      fontFamily: AppConstant.appFontInter,
    ),
    titleMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: textColorBlack,
      fontFamily: AppConstant.appFontInter,
    ),
    titleSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: textColorBlack,
      fontFamily: AppConstant.appFontInter,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: textColorBlack,
      fontFamily: AppConstant.appFontInter,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: textColorBlack,
      fontWeight: FontWeight.w400,
      fontFamily: AppConstant.appFontInter,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: textColorBlack,
      fontFamily: AppConstant.appFontInter,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: textColorBlack,
      fontFamily: AppConstant.appFontInter,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      color: textColorBlack,
      fontWeight: FontWeight.w400,
      fontFamily: AppConstant.appFontInter,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      color: textColorBlack,
      fontWeight: FontWeight.w400,
      fontFamily: AppConstant.appFontInter,
    ),
  ),
);

final darkTheme = ThemeData(
  cardColor: backgroundColor,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark, // 2
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: colorWhite,
  ),
  scaffoldBackgroundColor: backgroundColor,
  unselectedWidgetColor: colorGrayBackground,
  brightness: Brightness.dark,
  fontFamily: "poppins",
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: primaryColor,
    onPrimary: onPrimaryColor,
    surfaceVariant: onBackgroundColor,
    primaryContainer: primaryContainerColor,
    onPrimaryContainer: onPrimaryContainerColor,
    secondary: secondaryColor,
    onSecondary: onSecondaryColor,
    secondaryContainer: secondaryColor,
    onSecondaryContainer: onSecondaryContainerColor,
    error: errorColor,
    onError: onErrorColor,
    brightness: Brightness.dark,
    surface: surfaceColor,
    onSurface: onSurfaceColor,
    surfaceTint: Colors.transparent,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: textColorBlack,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: textColorBlack,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: textColorBlack,
    ),
    headlineLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: textColorBlack,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: textColorBlack,
    ),
    headlineSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: textColorBlack,
    ),
    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: textColorBlack,
    ),
    titleMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: textColorBlack,
    ),
    titleSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: textColorBlack,
    ),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
  ),
);
