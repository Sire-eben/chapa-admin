import "package:flutter/material.dart";
// import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();
  static Color primary = const Color(0xFF135633);
  static Color transparentPrimary = const Color(0xFF135633).withOpacity(.1);
  static Color secondary = const Color.fromARGB(255, 185, 229, 203);
  static Color fillColor = const Color(0xFFF9F9F9);
  static Color secondaryIconColor = const Color(0xFF84818A);
  static Color backgroundColor = const Color(0xFFEAEFF5);

  static Color black = Colors.black;
  static Color red = Colors.red;
  static Color idleState = const Color(0xFFEFEFEF);
  static Color textFieldBorder = const Color(0xFFEDF0F2);
  static const green = Color(0xff135733);
  static const white = Colors.white;
  static const grey = Colors.grey;
  static const error = Colors.red;
  static Color appBlack = const Color(0xFF000000);
}

class AppTheme {
  AppTheme._();

  static ThemeData _baseTheme(BuildContext context) => ThemeData(
        useMaterial3: true,
        toggleableActiveColor: AppColors.primary,
        typography: Typography.material2021(),
        splashFactory: InkSplash.splashFactory,
        fontFamily: Fonts.primary,
        primaryColor: AppColors.primary,
        indicatorColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.white,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.primary, //<-- SEE HERE
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(AppColors.primary),
            elevation: MaterialStateProperty.all(0),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(
                vertical: Insets.xs,
                horizontal: Insets.md,
              ),
            ),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
        textTheme: TextTheme(
            bodyMedium:
                AppStyles.urbanist14Rg.copyWith(color: AppColors.appBlack)),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.primary.withOpacity(0.8),
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
        ),
        iconTheme: const IconThemeData(color: Colors.black, size: 24),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          extendedTextStyle: AppStyles.urbanist16Md,
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle:
              AppStyles.urbanist18Smbd.copyWith(color: Colors.black),
          iconTheme: IconThemeData(color: AppColors.primary),
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.white,
          elevation: 0.0,
          centerTitle: true,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.primary,
          textTheme: ButtonTextTheme.accent,
        ),
        inputDecorationTheme: InputDecorationTheme(
          suffixIconColor: AppColors.primary,
          prefixIconColor: AppColors.primary,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 30),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textFieldBorder),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.error),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(),
          ),
          focusColor: Colors.black,
          labelStyle: TextStyle(color: AppColors.textFieldBorder),
          hintStyle: AppStyles.urbanist14Rg,
        ),
        timePickerTheme: TimePickerThemeData(
          backgroundColor: Colors.white,
          dialBackgroundColor: Colors.grey[200],
          hourMinuteTextColor: AppColors.white,
          dayPeriodTextColor: AppColors.white,
          hourMinuteColor: AppColors.primary,
          dayPeriodColor: AppColors.primary,
          dialTextColor: Colors.black,
          dialHandColor: AppColors.primary,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary),
            ),
          ),
        ),
      );

  static ThemeData defaultTheme(BuildContext context) =>
      _baseTheme(context).copyWith(
        brightness: Brightness.dark,
      );
}

class Fonts {
  static const primary = "Urbanist";
  static const secondary = "Clash";
}

class Insets {
  /// 4
  static const double xs = 4;

  /// 8
  static const double sm = 8;

  /// 16 const
  static const double md = 16;

  ///20
  static const double l = 20;

  /// 24 const
  static const double lg = 24;

  /// 32 const
  static const double xl = 36;

  /// 64 const
  static const double bottomOffset = 64;
}

class Shadows {
  static const bool enabled = true;

  static double get mRadius => 8;

  static List<BoxShadow> m(Color color, [double? opacity = 0]) {
    return [
      BoxShadow(
        color: color.withOpacity(opacity ?? .03),
        blurRadius: mRadius,
        spreadRadius: mRadius / 2,
        offset: const Offset(1, 0),
      ),
      BoxShadow(
        color: color.withOpacity(opacity ?? .04),
        blurRadius: mRadius / 2,
        spreadRadius: mRadius / 4,
        offset: const Offset(1, 0),
      )
    ];
  }

  static List<BoxShadow> get universal => [
        BoxShadow(
          color: AppColors.fillColor,
          spreadRadius: 6,
          blurRadius: 6,
          // offset: const Offset(0, 1),
        ),
      ];
  static List<BoxShadow> get small => [
        BoxShadow(
            color: const Color(0xff333333).withOpacity(.15),
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(0, 1)),
      ];
}

class FontSizes {
  static double xs = 9;
  static double sm = 13;
  static double md = 15;
  static double lg = 18;
}

class IconSizes {
  static const double xs = 8;
  static const double sm = 16;
  static const double md = 24;
  static const double lg = 32;
}

class AppStyles {
  AppStyles._();

  ///w800 - 24
  static TextStyle urbanist24Xbd = GoogleFonts.urbanist(
      fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.appBlack);

  ///w600 - 34
  static TextStyle urbanist34Smbd = GoogleFonts.urbanist(
      fontSize: 34, fontWeight: FontWeight.w600, color: AppColors.appBlack);

  ///w600 - 24
  static TextStyle urbanist24Smbd =
      GoogleFonts.urbanist(fontSize: 28, fontWeight: FontWeight.w600);

  ///w500 - 20
  static TextStyle urbanist20Md = GoogleFonts.urbanist(
      fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.appBlack);

  ///w400 - 20
  static TextStyle urbanist20Rg = GoogleFonts.urbanist(
      fontSize: 20, fontWeight: FontWeight.w400, color: AppColors.appBlack);

  ///w400 - 12
  static TextStyle urbanist12Rg = GoogleFonts.urbanist(
      fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.appBlack);

  ///w500 - 12
  static TextStyle urbanist12Md = GoogleFonts.urbanist(
      fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.appBlack);

  ///w700 - 18
  static TextStyle urbanist18Bd = GoogleFonts.urbanist(
      fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.appBlack);

  ///w600 - 18
  static TextStyle urbanist18Smbd = GoogleFonts.urbanist(
      fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.appBlack);

  ///w500 - 13
  static TextStyle urbanist13Md = GoogleFonts.urbanist(
      fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.appBlack);

  ///w600 - 13
  static TextStyle urbanist13Smbd = GoogleFonts.urbanist(
      fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.appBlack);

  ///w400 - 14
  static TextStyle urbanist14Rg = GoogleFonts.urbanist(
      fontSize: 14,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      color: AppColors.appBlack);

  ///w500 - 14
  static TextStyle urbanist14Md = GoogleFonts.urbanist(
      fontSize: 14,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      color: AppColors.appBlack);

  ///w600 - 14
  static TextStyle urbanist14Smbd = GoogleFonts.urbanist(
      fontSize: 14,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      color: AppColors.appBlack);

  ///w700 - 14
  static TextStyle urbanist14Bd = GoogleFonts.urbanist(
      fontSize: 14,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      color: AppColors.appBlack);

  ///w400 - 15
  static TextStyle urbanist15Smbd = GoogleFonts.urbanist(
      fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.appBlack);

  ///w600 - 16
  static TextStyle urbanist16SmBd = GoogleFonts.urbanist(
      fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.appBlack);

  ///w500 - 16
  static TextStyle urbanist16Md = GoogleFonts.urbanist(
      fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.appBlack);

  ///w400 - 16
  static TextStyle urbanist16Rg = GoogleFonts.urbanist(
      fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.appBlack);

  ///12w600
  static TextStyle urbanist12Smbd = GoogleFonts.urbanist(
      fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.appBlack);

  ///10w400
  static TextStyle urbanist10Rg = GoogleFonts.urbanist(
      fontWeight: FontWeight.w400, fontSize: 10, color: AppColors.appBlack);

  ///10w400
  static TextStyle urbanist10Md = GoogleFonts.urbanist(
      fontWeight: FontWeight.w500, fontSize: 10, color: AppColors.appBlack);

  ///10w600
  static TextStyle urbanist10Smbd = GoogleFonts.urbanist(
      fontWeight: FontWeight.w600, fontSize: 10, color: AppColors.appBlack);

  ///paragraph
  static TextStyle paragraph = GoogleFonts.urbanist(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: const Color(0xff1D1E25));

  ///urbanist general
  static TextStyle urbanistGeneral(double? size, FontWeight? weight,
          {Color color = Colors.black}) =>
      GoogleFonts.urbanist(
          fontSize: size == null ? 14 : size,
          fontWeight: weight ?? FontWeight.w400,
          color: color);

  ///inter general
  static TextStyle interGeneral(double? size, FontWeight? weight,
          {Color color = Colors.black}) =>
      GoogleFonts.inter(
          fontSize: size == null ? 14 : size,
          fontWeight: weight ?? FontWeight.w400,
          color: color);
}
