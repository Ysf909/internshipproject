import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../presentation/viewmodels/expert_profile_view_model.dart';
import '../../widgets/program_card.dart';
import '../../widgets/custom_button.dart';

class ExpertProfileScreen extends ConsumerWidget {
  final String expertId;
  const ExpertProfileScreen({super.key, required this.expertId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // ── View talks only to its ViewModel ──────────────────
    final state = ref.watch(expertProfileViewModelProvider(expertId));

    if (state.isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (state.error != null) return Scaffold(body: Center(child: Text('Error: ${state.error}')));
    final expert = state.expert!;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text('Expert Profile', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        elevation: 0,
        leading: GestureDetector(onTap: () => context.pop(), child: const Icon(Icons.arrow_back_rounded)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ── Profile Header ────────────────────────────────
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: 88, height: 88,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 3)),
              child: ClipOval(child: Image.network(expert.imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => CircleAvatar(backgroundColor: AppColors.primary.withOpacity(0.2), child: Text(expert.name[0], style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: AppColors.primary))))),
            ),
            const SizedBox(width: 16),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(expert.name, style: AppTextStyles.headingLarge(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
              const SizedBox(height: 2),
              Text(expert.title, style: AppTextStyles.bodyLarge(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
              const SizedBox(height: 4),
              Row(children: [
                Icon(Icons.business_rounded, size: 14, color: isDark ? AppColors.primaryLight : AppColors.primary),
                const SizedBox(width: 4),
                Text(expert.company, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isDark ? AppColors.primaryLight : AppColors.primary, fontFamily: 'Inter')),
              ]),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppColors.secondary.withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
                child: Text('${expert.experienceYears}+ years experience', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.secondary, fontFamily: 'Inter')),
              ),
            ])),
          ]).animate().fadeIn(duration: 400.ms),

          const SizedBox(height: 24),

          // ── Stats ─────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight, borderRadius: BorderRadius.circular(14), border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight)),
            child: Row(children: [
              _StatItem(value: expert.rating.toString(), label: 'Rating', icon: Icons.star_rounded, color: const Color(0xFFF59E0B), isDark: isDark),
              _Div(isDark: isDark),
              _StatItem(value: '${expert.totalStudents}+', label: 'Students', icon: Icons.people_rounded, color: AppColors.primary, isDark: isDark),
              _Div(isDark: isDark),
              _StatItem(value: '${expert.experienceYears}+', label: 'Years Exp.', icon: Icons.workspace_premium_rounded, color: AppColors.secondary, isDark: isDark),
              _Div(isDark: isDark),
              _StatItem(value: '${expert.programIds.length}', label: 'Programs', icon: Icons.school_rounded, color: AppColors.accent, isDark: isDark),
            ]),
          ).animate(delay: 100.ms).fadeIn(duration: 400.ms),

          const SizedBox(height: 24),
          Divider(color: isDark ? AppColors.borderDark : AppColors.borderLight),
          const SizedBox(height: 20),

          // ── Bio ───────────────────────────────────────────
          Text('About', style: AppTextStyles.headingMedium(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
          const SizedBox(height: 10),
          Text(expert.bio, style: AppTextStyles.bodyLarge(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)).animate(delay: 150.ms).fadeIn(),

          const SizedBox(height: 24),
          Divider(color: isDark ? AppColors.borderDark : AppColors.borderLight),
          const SizedBox(height: 20),

          // ── Specializations ───────────────────────────────
          Text('Specializations', style: AppTextStyles.headingMedium(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
          const SizedBox(height: 10),
          Wrap(spacing: 8, runSpacing: 8, children: expert.specializations.asMap().entries.map((e) =>
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.primary.withOpacity(0.1), AppColors.primary.withOpacity(0.05)]), borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.primary.withOpacity(0.2))),
              child: Text(e.value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: isDark ? AppColors.primaryLight : AppColors.primary, fontFamily: 'Inter')),
            ).animate(delay: Duration(milliseconds: e.key * 60)).fadeIn(duration: 300.ms)
          ).toList()),

          const SizedBox(height: 24),
          Divider(color: isDark ? AppColors.borderDark : AppColors.borderLight),
          const SizedBox(height: 20),

          // ── Programs ──────────────────────────────────────
          Text('Programs by ${expert.name.split(' ').first}', style: AppTextStyles.headingMedium(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
          const SizedBox(height: 12),
          ...state.programs.asMap().entries.map((e) => Padding(padding: const EdgeInsets.only(bottom: 12), child: ProgramCard(program: e.value, animationIndex: e.key))),

          const SizedBox(height: 24),
          CustomButton(label: 'Apply for a Program', icon: Icons.arrow_forward_rounded, onPressed: () => context.push('/apply')).animate(delay: 200.ms).fadeIn(),
          const SizedBox(height: 32),
        ]),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value, label; final IconData icon; final Color color; final bool isDark;
  const _StatItem({required this.value, required this.label, required this.icon, required this.color, required this.isDark});
  @override
  Widget build(BuildContext context) => Expanded(child: Column(children: [
    Icon(icon, size: 18, color: color),
    const SizedBox(height: 4),
    Text(value, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
    Text(label, style: GoogleFonts.inter(fontSize: 11, color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
  ]));
}

class _Div extends StatelessWidget {
  final bool isDark;
  const _Div({required this.isDark});
  @override
  Widget build(BuildContext context) => Container(width: 1, height: 40, color: isDark ? AppColors.borderDark : AppColors.borderLight);
}
