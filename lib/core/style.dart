import 'package:flutter/material.dart';

abstract class AppColors {
  const AppColors._();

  static const contrast = Colors.white;
  static const backGroundContrast = Color(0xFFECECEC);
  static const white = Color(0xFFF6F6F6);
  static const itemsContrast = Color(0xFFFDFDFD);

  static const primaryYellow = Color(0xFFFFB800);


  static const darkGrey = Color(0xFF4F4F4F);
  static const grey = Color(0xFFA7A7A7);
  static const lightGrey = Color(0xFFD9D9D9);
  static const greyText = Color(0xFF4D4D4D);
  static const greyTransparent = Color(0xFFC6C6C8);



  static const green = Color(0xFF39A314);
  static const blue = Color(0xFF0098EE);

}


abstract class AppTextStyle {
  const AppTextStyle._();

  static const header1 = TextStyle(
      fontFamily: "SF Pro Text",
      fontSize: 34,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.374,
      color: AppColors.darkGrey
  );


  static const header8 = TextStyle(
    fontFamily: "SF Pro Text",
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.24,
    color: AppColors.darkGrey
  );

  static const header9 = TextStyle(
    fontFamily: "SF Pro Text",
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.38,
    color: AppColors.darkGrey
  );



  static const body1 = TextStyle(
    fontFamily: "SF Pro Text",
    fontSize: 17,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.408,
    color: AppColors.darkGrey
  );

  static const bodyBold = TextStyle(
    fontFamily: "SF Pro Text",
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.408,
    color: AppColors.darkGrey
  );

  static const button = TextStyle(
    fontFamily: "SF Pro Text",
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.32,
    color: AppColors.darkGrey
  );

  static const caption = TextStyle(
    fontFamily: "SF Pro Text",
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.066,
    color: AppColors.grey
  );


    static const caption1 = TextStyle(
    fontFamily: "SF Pro Text",
    fontSize: 12,
    fontWeight: FontWeight.w500,

    color: AppColors.grey
  );

    static const caption2 = TextStyle(
    fontFamily: "SF Pro Text",
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.066,
    color: AppColors.grey
  );

    static const callout  = TextStyle(
    fontFamily: "SF Pro Text",
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.32,
    color: AppColors.grey
  );


    static const footNoteText  = TextStyle(
    fontFamily: "SF Pro Text",
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.078,
    color: AppColors.grey
  );

    static const t3  = TextStyle(
    fontFamily: "SF Pro Text",
    fontSize: 20,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.38,
    color: AppColors.blue
  );

    static const t3Bold  = TextStyle(
    fontFamily: "SF Pro Text",
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.38,
    color: AppColors.blue
  );









}
