import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // ── Display ─────────────────────────────────────────────
  static TextStyle displayLarge({Color? color}) => GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.w800,
        color: color ?? AppColors.textPrimaryLight,
        height: 1.2,
      );

  static TextStyle displayMedium({Color? color}) => GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.textPrimaryLight,
        height: 1.25,
      );

  // ── Heading ─────────────────────────────────────────────
  static TextStyle headingLarge({Color? color}) => GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.textPrimaryLight,
        height: 1.3,
      );

  static TextStyle headingMedium({Color? color}) => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.textPrimaryLight,
        height: 1.35,
      );

  static TextStyle headingSmall({Color? color}) => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.textPrimaryLight,
        height: 1.4,
      );

  // ── Body ─────────────────────────────────────────────────
  static TextStyle bodyLarge({Color? color}) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textSecondaryLight,
        height: 1.6,
      );

  static TextStyle bodyMedium({Color? color}) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textSecondaryLight,
        height: 1.6,
      );

  static TextStyle bodySmall({Color? color}) => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textSecondaryLight,
        height: 1.5,
      );

  // ── Label ─────────────────────────────────────────────────
  static TextStyle labelLarge({Color? color}) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.textPrimaryLight,
        letterSpacing: 0.1,
      );

  static TextStyle labelMedium({Color? color}) => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.textPrimaryLight,
        letterSpacing: 0.5,
      );

  static TextStyle labelSmall({Color? color}) => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.textSecondaryLight,
        letterSpacing: 0.5,
      );

  // ── Price ─────────────────────────────────────────────────
  static TextStyle price({Color? color}) => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.primary,
      );

  // ── Button ─────────────────────────────────────────────────
  static TextStyle button({Color? color}) => GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: color ?? Colors.white,
        letterSpacing: 0.3,
      );
}
