import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/models/expert_model.dart';

class ExpertCard extends StatelessWidget {
  final Expert expert;
  final int animationIndex;
  final bool isCompact;

  const ExpertCard({
    super.key,
    required this.expert,
    this.animationIndex = 0,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (isCompact) return _buildCompact(context, isDark);
    return _buildFull(context, isDark);
  }

  Widget _buildFull(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () => context.push('/experts/${expert.id}'),
      child: Container(
        width: 214,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : AppColors.cardLight,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
        ),
        child: Column(children: [
          // Avatar with company badge
          Stack(clipBehavior: Clip.none, children: [
            Container(
              width: 68, height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.secondary.withOpacity(0.4), width: 2),
              ),
              child: ClipOval(child: Image.network(expert.imageUrl, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => CircleAvatar(
                  backgroundColor: AppColors.primary.withOpacity(0.2),
                  child: Text(expert.name[0], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.primary)),
                ),
              )),
            ),
            Positioned(bottom: -2, right: -8, child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
              ),
              child: Text(expert.company, style: GoogleFonts.syne(
                fontSize: 9, fontWeight: FontWeight.w700,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              )),
            )),
          ]),
          const SizedBox(height: 14),
          Text(expert.name, style: AppTextStyles.labelLarge(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 2),
          Text(expert.title, style: AppTextStyles.bodySmall(
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.star_rounded, size: 12, color: AppColors.accent),
            const SizedBox(width: 3),
            Text('${expert.rating}', style: GoogleFonts.syne(fontSize: 11, fontWeight: FontWeight.w700,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
            const SizedBox(width: 10),
            Icon(Icons.people_rounded, size: 12,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
            const SizedBox(width: 3),
            Text('${expert.totalStudents}', style: AppTextStyles.bodySmall(
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            )),
          ]),
          const SizedBox(height: 10),
          Wrap(spacing: 5, runSpacing: 5, alignment: WrapAlignment.center,
            children: expert.specializations.take(2).map((s) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              ),
              child: Text(s, style: GoogleFonts.syne(fontSize: 9, fontWeight: FontWeight.w600,
                color: isDark ? AppColors.primaryLight : AppColors.primary)),
            )).toList(),
          ),
        ]),
      ),
    )
    .animate(delay: Duration(milliseconds: animationIndex * 80))
    .fadeIn(duration: 400.ms)
    .slideX(begin: 0.1, end: 0, duration: 400.ms);
  }

  Widget _buildCompact(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () => context.push('/experts/${expert.id}'),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : AppColors.cardLight,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
        ),
        child: Row(children: [
          Container(
            width: 50, height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.secondary.withOpacity(0.3), width: 2),
            ),
            child: ClipOval(child: Image.network(expert.imageUrl, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.2),
                child: Text(expert.name[0], style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary)),
              ),
            )),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(expert.name, style: AppTextStyles.labelLarge(
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            )),
            Text('${expert.title} at ${expert.company}', style: AppTextStyles.bodySmall(
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            ), maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 3),
            Text('${expert.experienceYears}+ years experience', style: GoogleFonts.syne(
              fontSize: 10, fontWeight: FontWeight.w600,
              color: isDark ? AppColors.secondaryLight : AppColors.secondary,
            )),
          ])),
          Icon(Icons.chevron_right_rounded,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
        ]),
      ),
    );
  }
}
