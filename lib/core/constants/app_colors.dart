import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary      = Color(0xFF6C63FF);
  static const Color primaryLight = Color(0xFFA09AFF);
  static const Color primaryDark  = Color(0xFF4F46E5);
  static const Color secondary      = Color(0xFF00C98D);
  static const Color secondaryLight = Color(0xFF5EEFC4);
  static const Color accent = Color(0xFFF5A623);
  static const Color coral  = Color(0xFFFF6B4A);

  // Impact / Sustainability palette (Tomorrow University influence)
  static const Color impact        = Color(0xFF1A8C5B);
  static const Color impactLight   = Color(0xFF4EC98A);
  static const Color impactDark    = Color(0xFF0F5C3A);
  static const Color earth         = Color(0xFF7B5E45);
  static const Color sky           = Color(0xFF2B7ABA);
  static const Color sdgGold       = Color(0xFFE8B420);

  static const Color backgroundDark = Color(0xFF0B0D0F);
  static const Color surfaceDark    = Color(0xFF111418);
  static const Color cardDark       = Color(0xFF161A1F);
  static const Color borderDark     = Color(0xFF1F2530);
  static const Color textPrimaryDark   = Color(0xFFF0EDE8);
  static const Color textSecondaryDark = Color(0xFF8A8F9A);
  static const Color textHintDark      = Color(0xFF444A56);

  static const Color backgroundLight = Color(0xFFF5F2EC);
  static const Color surfaceLight    = Color(0xFFFFFFFF);
  static const Color cardLight       = Color(0xFFFFFFFF);
  static const Color borderLight     = Color(0xFFE8E4DE);
  static const Color textPrimaryLight   = Color(0xFF0C0C10);
  static const Color textSecondaryLight = Color(0xFF666872);
  static const Color textHintLight      = Color(0xFF9CA3AF);

  static const Color success = Color(0xFF00C98D);
  static const Color warning = Color(0xFFF5A623);
  static const Color error   = Color(0xFFEF4444);
  static const Color info    = Color(0xFF3B82F6);

  static const Color catTechnology   = Color(0xFF6C63FF);
  static const Color catBusiness     = Color(0xFF00C98D);
  static const Color catDesign       = Color(0xFFFF6B4A);
  static const Color catMarketing    = Color(0xFFF5A623);
  static const Color catFinance      = Color(0xFF0EA5E9);
  static const Color catSustainability = Color(0xFF1A8C5B);

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft, end: Alignment.bottomRight,
    colors: [Color(0xFF6C63FF), Color(0xFF3A86FF), Color(0xFF00C98D)],
  );
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft, end: Alignment.bottomRight,
    colors: [Color(0xFF6C63FF), Color(0xFF4F46E5)],
  );
  static const LinearGradient missionGradient = LinearGradient(
    begin: Alignment.topLeft, end: Alignment.bottomRight,
    colors: [Color(0xFF00C98D), Color(0xFF0EA5E9)],
  );
  static const LinearGradient impactGradient = LinearGradient(
    begin: Alignment.topLeft, end: Alignment.bottomRight,
    colors: [Color(0xFF1A8C5B), Color(0xFF2B7ABA)],
  );
  static const LinearGradient degreeGradient = LinearGradient(
    begin: Alignment.topLeft, end: Alignment.bottomRight,
    colors: [Color(0xFF1B3D6E), Color(0xFF6C63FF)],
  );

  static Color categoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'technology':     return catTechnology;
      case 'business':       return catBusiness;
      case 'design':         return catDesign;
      case 'marketing':      return catMarketing;
      case 'finance':        return catFinance;
      case 'sustainability': return catSustainability;
      default:               return primary;
    }
  }
  static Color categoryBg(String category) =>
      categoryColor(category).withOpacity(0.12);
}
