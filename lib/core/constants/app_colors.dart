import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Brand ──────────────────────────────────────────────
  static const Color primary = Color(0xFF4F46E5);      // Indigo
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF3730A3);

  static const Color secondary = Color(0xFF10B981);    // Emerald
  static const Color secondaryLight = Color(0xFF6EE7B7);

  static const Color accent = Color(0xFFF59E0B);       // Amber

  // ── Neutrals (Light Mode) ──────────────────────────────
  static const Color backgroundLight = Color(0xFFF8F9FE);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color borderLight = Color(0xFFE5E7EB);

  static const Color textPrimaryLight = Color(0xFF111827);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color textHintLight = Color(0xFF9CA3AF);

  // ── Neutrals (Dark Mode) ──────────────────────────────
  static const Color backgroundDark = Color(0xFF0F0E17);
  static const Color surfaceDark = Color(0xFF1A1A2E);
  static const Color cardDark = Color(0xFF16213E);
  static const Color borderDark = Color(0xFF2D2D44);

  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textSecondaryDark = Color(0xFF9CA3AF);
  static const Color textHintDark = Color(0xFF6B7280);

  // ── Semantic ────────────────────────────────────────────
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // ── Category Colors ─────────────────────────────────────
  static const Color catTechnology = Color(0xFF4F46E5);
  static const Color catBusiness = Color(0xFF059669);
  static const Color catDesign = Color(0xFFEC4899);
  static const Color catMarketing = Color(0xFFF59E0B);
  static const Color catFinance = Color(0xFF0EA5E9);

  // ── Gradient ────────────────────────────────────────────
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4F46E5), Color(0xFF6D28D9)],
  );

  static Color categoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'technology':
        return catTechnology;
      case 'business':
        return catBusiness;
      case 'design':
        return catDesign;
      case 'marketing':
        return catMarketing;
      case 'finance':
        return catFinance;
      default:
        return primary;
    }
  }
}
