import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Display - use Playfair-like via Merriweather for editorial serif feel
  static TextStyle displayLarge({Color? color}) => GoogleFonts.merriweather(
    fontSize: 34, fontWeight: FontWeight.w700,
    color: color ?? AppColors.textPrimaryDark, height: 1.15,
  );
  static TextStyle displayMedium({Color? color}) => GoogleFonts.merriweather(
    fontSize: 26, fontWeight: FontWeight.w700,
    color: color ?? AppColors.textPrimaryDark, height: 1.2,
  );

  // Heading - Syne-style via Nunito for punchy weight
  static TextStyle headingLarge({Color? color}) => GoogleFonts.syne(
    fontSize: 22, fontWeight: FontWeight.w700,
    color: color ?? AppColors.textPrimaryDark, height: 1.3,
  );
  static TextStyle headingMedium({Color? color}) => GoogleFonts.syne(
    fontSize: 18, fontWeight: FontWeight.w700,
    color: color ?? AppColors.textPrimaryDark, height: 1.35,
  );
  static TextStyle headingSmall({Color? color}) => GoogleFonts.syne(
    fontSize: 15, fontWeight: FontWeight.w600,
    color: color ?? AppColors.textPrimaryDark, height: 1.4,
  );

  // Body - DM Sans feel via Nunito
  static TextStyle bodyLarge({Color? color}) => GoogleFonts.dmSans(
    fontSize: 15, fontWeight: FontWeight.w400,
    color: color ?? AppColors.textSecondaryDark, height: 1.7,
  );
  static TextStyle bodyMedium({Color? color}) => GoogleFonts.dmSans(
    fontSize: 13, fontWeight: FontWeight.w400,
    color: color ?? AppColors.textSecondaryDark, height: 1.65,
  );
  static TextStyle bodySmall({Color? color}) => GoogleFonts.dmSans(
    fontSize: 11, fontWeight: FontWeight.w400,
    color: color ?? AppColors.textSecondaryDark, height: 1.55,
  );

  // Label
  static TextStyle labelLarge({Color? color}) => GoogleFonts.syne(
    fontSize: 13, fontWeight: FontWeight.w700,
    color: color ?? AppColors.textPrimaryDark, letterSpacing: 0.1,
  );
  static TextStyle labelMedium({Color? color}) => GoogleFonts.syne(
    fontSize: 11, fontWeight: FontWeight.w700,
    color: color ?? AppColors.textPrimaryDark, letterSpacing: 0.5,
  );
  static TextStyle labelSmall({Color? color}) => GoogleFonts.syne(
    fontSize: 10, fontWeight: FontWeight.w600,
    color: color ?? AppColors.textSecondaryDark, letterSpacing: 0.5,
  );
  static TextStyle kicker({Color? color}) => GoogleFonts.syne(
    fontSize: 10, fontWeight: FontWeight.w800,
    color: color ?? AppColors.primaryLight, letterSpacing: 1.6,
  );

  // Price
  static TextStyle price({Color? color}) => GoogleFonts.syne(
    fontSize: 20, fontWeight: FontWeight.w800,
    color: color ?? AppColors.primary,
  );

  // Button
  static TextStyle button({Color? color}) => GoogleFonts.syne(
    fontSize: 14, fontWeight: FontWeight.w700,
    color: color ?? Colors.white, letterSpacing: 0.4,
  );
}
