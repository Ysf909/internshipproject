import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/models/program_model.dart';

class ProgramCard extends StatelessWidget {
  final Program program;
  final bool isHorizontal;
  final int animationIndex;

  const ProgramCard({
    super.key,
    required this.program,
    this.isHorizontal = false,
    this.animationIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => context.push('/programs/${program.id}'),
      child: Container(
        width: isHorizontal ? 268 : null,
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : AppColors.cardLight,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: program.isDegree
                ? AppColors.impact.withOpacity(0.4)
                : (isDark ? AppColors.borderDark : AppColors.borderLight),
            width: program.isDegree ? 1.5 : 1,
          ),
          boxShadow: isDark ? null : [
            BoxShadow(
              color: program.isDegree
                  ? AppColors.impact.withOpacity(0.1)
                  : Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: Stack(children: [
              Image.network(
                program.imageUrl, height: 158, width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 158,
                  decoration: BoxDecoration(gradient: LinearGradient(
                    colors: [
                      AppColors.categoryColor(program.category).withOpacity(0.4),
                      AppColors.categoryColor(program.category).withOpacity(0.1),
                    ],
                  )),
                  child: Center(child: Icon(
                    program.isDegree ? Icons.school_rounded : Icons.auto_stories_rounded,
                    size: 48,
                    color: AppColors.categoryColor(program.category),
                  )),
                ),
              ),
              // Gradient overlay
              Positioned.fill(child: Container(
                decoration: BoxDecoration(gradient: LinearGradient(
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                )),
              )),
              // Degree badge or category
              Positioned(top: 10, left: 10, child: Row(children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.categoryColor(program.category),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(program.category, style: GoogleFonts.syne(
                    fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 0.5,
                  )),
                ),
                if (program.isDegree) ...[
                  const SizedBox(width: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.sdgGold.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Accredited', style: GoogleFonts.syne(
                      fontSize: 8, fontWeight: FontWeight.w800, color: Colors.white,
                    )),
                  ),
                ],
              ])),
              // Level / degree type
              Positioned(top: 10, right: 10, child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.55),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(program.isDegree ? (program.degreeType ?? 'Degree') : program.level,
                  style: GoogleFonts.syne(fontSize: 9, fontWeight: FontWeight.w600, color: Colors.white)),
              )),
              // ECTS badge for degrees
              if (program.isDegree && program.ects != null)
                Positioned(bottom: 10, left: 10, child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.impact.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('${program.ects} ECTS', style: GoogleFonts.syne(
                    fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white,
                  )),
                )),
            ]),
          ),
          // Body
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(program.title, style: AppTextStyles.headingSmall(
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              ), maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 8),
              Row(children: [
                Icon(Icons.star_rounded, size: 13, color: AppColors.accent),
                const SizedBox(width: 3),
                Text(program.rating.toStringAsFixed(1), style: GoogleFonts.syne(
                  fontSize: 11, fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                )),
                const SizedBox(width: 4),
                Text('(${program.totalStudents})', style: AppTextStyles.bodySmall(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                )),
              ]),
              // SDG tags for degree programs
              if (program.isDegree && program.sdgGoals.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(spacing: 4, runSpacing: 4, children: program.sdgGoals.take(2).map((sdg) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.impact.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.impact.withOpacity(0.2)),
                  ),
                  child: Text(sdg, style: GoogleFonts.dmSans(
                    fontSize: 8, color: isDark ? AppColors.impactLight : AppColors.impact,
                    fontWeight: FontWeight.w600,
                  )),
                )).toList()),
              ],
              const SizedBox(height: 10),
              Row(children: [
                Icon(Icons.access_time_rounded, size: 12,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                const SizedBox(width: 4),
                Text(program.duration, style: AppTextStyles.labelSmall(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                )),
                const Spacer(),
                ShaderMask(
                  shaderCallback: (b) => (program.isDegree ? AppColors.impactGradient : AppColors.cardGradient).createShader(b),
                  child: Text(program.formattedPrice, style: GoogleFonts.syne(
                    fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white,
                  )),
                ),
              ]),
            ]),
          ),
        ]),
      ),
    )
    .animate(delay: Duration(milliseconds: animationIndex * 80))
    .fadeIn(duration: 400.ms)
    .slideY(begin: 0.1, end: 0, duration: 400.ms);
  }
}
