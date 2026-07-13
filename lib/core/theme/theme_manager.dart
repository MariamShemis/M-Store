import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/color_manager.dart';

class ThemeManager {
  static ThemeData lightTheme = ThemeData(
    primaryColor: ColorManager.primaryColor,
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorManager.background,

    colorScheme: const ColorScheme.light(
      primary: ColorManager.primaryColor,
      onPrimary: ColorManager.white,
      secondary: ColorManager.secondary,
      onSecondary: ColorManager.blackText,
      background: ColorManager.background,
      onBackground: ColorManager.blackText,
      surface: ColorManager.white,
      onSurface: ColorManager.blackText,
      error: ColorManager.red,
      onError: ColorManager.white,
    ),

    /// TEXT THEME (تم ربط نصوص التصميم بالأسود الكربوني والرمادي والخطوط المناسبة)
    textTheme: TextTheme(
      displayLarge: GoogleFonts.inter(
        color: ColorManager.blackText,
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.inter(
        color: ColorManager.white,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      headlineLarge: GoogleFonts.inter(
        color: ColorManager.mediumGold,
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: GoogleFonts.inter(
        color: ColorManager.blackText,
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: GoogleFonts.poppins(
        color: ColorManager.secondary,
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
      ),
      bodyMedium: GoogleFonts.inter(
        color: ColorManager.greyDark,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: GoogleFonts.inter(
        color: ColorManager.secondary,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: GoogleFonts.inter(
        color: ColorManager.blackText,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: GoogleFonts.inter(
        color: ColorManager.blackText,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.inter(
        color: ColorManager.blackText,
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
      ),
      titleLarge: GoogleFonts.inter(
        color: ColorManager.mediumGold,
        fontWeight: FontWeight.bold,
        fontSize: 24.sp,
      ),
      titleMedium: GoogleFonts.inter(
        color: ColorManager.blackText,
        fontWeight: FontWeight.bold,
        fontSize: 20.sp,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 10.sp,
        fontWeight: FontWeight.bold,
        color: ColorManager.blackText,
      ),
    ),

    /// APPBAR
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.inter(
        color: ColorManager.blackText,
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
      ),
      iconTheme: const IconThemeData(color: ColorManager.blackText),
    ),

    /// BUTTON TYPES (الزرار الأساسي بالذهبي والكتابة عليه بالأبيض)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primaryColor,
        foregroundColor: ColorManager.white,
        padding: REdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: GoogleFonts.inter(
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorManager.primaryColor,
        padding: REdgeInsets.symmetric(horizontal: 20, vertical: 14),
        side: BorderSide(color: ColorManager.primaryColor, width: 1.4.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    ),

    /// TEXT FORM FIELD DECORATION (الـ Inputs واخدة خلفية رمادية خفيفة جداً متناسقة)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.white,
      contentPadding: REdgeInsets.symmetric(horizontal: 18, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: ColorManager.lightGreyEF, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: ColorManager.lightGreyEF, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: ColorManager.primaryColor, width: 1.5),
      ),
      hintStyle: GoogleFonts.inter(color: ColorManager.secondary),
    ),

    /// CARD THEME
    cardTheme: CardThemeData(
      color: ColorManager.white,
      margin: REdgeInsets.all(8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: ColorManager.lightGreyEF, width: 1.w),
      ),
    ),

    /// BOTTOM NAVIGATION
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: ColorManager.white,
      selectedItemColor: ColorManager.primaryColor,
      unselectedItemColor: ColorManager.secondary,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 5,
    ),
  );
}
