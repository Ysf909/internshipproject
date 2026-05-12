import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(child: Text(title, style: AppTextStyles.headingLarge(
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
        ))),
        if (actionLabel != null)
          GestureDetector(
            onTap: onAction,
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Text(actionLabel!, style: GoogleFonts.syne(
                fontSize: 12, fontWeight: FontWeight.w700,
                color: isDark ? AppColors.primaryLight : AppColors.primary,
              )),
              const SizedBox(width: 3),
              Icon(Icons.arrow_forward_rounded, size: 13,
                  color: isDark ? AppColors.primaryLight : AppColors.primary),
            ]),
          ),
      ]),
      if (subtitle != null) ...[
        const SizedBox(height: 4),
        Text(subtitle!, style: AppTextStyles.bodyMedium(
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
        )),
      ],
    ]);
  }
}
