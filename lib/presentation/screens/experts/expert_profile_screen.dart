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
    final state  = ref.watch(expertProfileViewModelProvider(expertId));
    if (state.isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (state.error != null) return Scaffold(body: Center(child: Text('Error: ${state.error}')));
    final expert = state.expert!;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: CustomScrollView(slivers: [
        // ── Hero App Bar ───────────────────────────────────────
        SliverAppBar(
          expandedHeight: 220, pinned: true,
          backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          leading: GestureDetector(
            onTap: () => context.pop(),
            child: Container(margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.35), borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.arrow_back_rounded, color: Colors.white)),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(fit: StackFit.expand, children: [
              // Gradient bg
              Container(decoration: const BoxDecoration(gradient: AppColors.cardGradient)),
              // Subtle grid
              Opacity(opacity: 0.06, child: GridPaper(
                color: Colors.white, interval: 48, divisions: 1, subdivisions: 1,
                child: const SizedBox.expand(),
              )),
              // Avatar + name
              Positioned(bottom: 20, left: 20, right: 20,
                child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Container(
                    width: 72, height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.5), width: 3),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 12)],
                    ),
                    child: ClipOval(child: Image.network(expert.imageUrl, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        child: Text(expert.name[0], style: const TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.w700)),
                      ))),
                  ),
                  const SizedBox(width: 14),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(expert.name, style: GoogleFonts.merriweather(
                      fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white,
                    )),
                    const SizedBox(height: 3),
                    Text(expert.title, style: GoogleFonts.dmSans(fontSize: 12, color: Colors.white.withOpacity(0.82))),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                      ),
                      child: Text(expert.company, style: GoogleFonts.syne(
                        fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white,
                      )),
                    ),
                  ])),
                ]),
              ),
            ]),
          ),
        ),

        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // ── Stats bar ──────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.cardDark : AppColors.cardLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
              ),
              child: Row(children: [
                _StatItem(value: expert.rating.toString(), label: 'Rating',   icon: Icons.star_rounded,             color: AppColors.accent,     isDark: isDark),
                _Div(isDark: isDark),
                _StatItem(value: '${expert.totalStudents}+', label: 'Students', icon: Icons.people_rounded,         color: AppColors.primary,    isDark: isDark),
                _Div(isDark: isDark),
                _StatItem(value: '${expert.experienceYears}+', label: 'Yrs Exp', icon: Icons.workspace_premium_rounded, color: AppColors.secondary, isDark: isDark),
                _Div(isDark: isDark),
                _StatItem(value: '${expert.programIds.length}', label: 'Programs', icon: Icons.school_rounded,     color: AppColors.coral,      isDark: isDark),
              ]),
            ).animate(delay: 100.ms).fadeIn(duration: 400.ms),

            const SizedBox(height: 22),
            Divider(color: isDark ? AppColors.borderDark : AppColors.borderLight),
            const SizedBox(height: 18),

            // ── About ──────────────────────────────────────────
            Text('About', style: AppTextStyles.headingMedium(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
            const SizedBox(height: 10),
            Text(expert.bio, style: AppTextStyles.bodyLarge(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight))
                .animate(delay: 150.ms).fadeIn(),

            const SizedBox(height: 22),
            Divider(color: isDark ? AppColors.borderDark : AppColors.borderLight),
            const SizedBox(height: 18),

            // ── Specializations ────────────────────────────────
            Text('Specializations', style: AppTextStyles.headingMedium(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
            const SizedBox(height: 10),
            Wrap(spacing: 8, runSpacing: 8, children: expert.specializations.asMap().entries.map((e) =>
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [AppColors.primary.withOpacity(0.1), AppColors.primary.withOpacity(0.04)]),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary.withOpacity(0.22)),
                ),
                child: Text(e.value, style: GoogleFonts.syne(fontSize: 12, fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.primaryLight : AppColors.primary)),
              ).animate(delay: Duration(milliseconds: e.key * 60)).fadeIn(duration: 300.ms),
            ).toList()),

            const SizedBox(height: 22),
            Divider(color: isDark ? AppColors.borderDark : AppColors.borderLight),
            const SizedBox(height: 18),

            // ── Programs ───────────────────────────────────────
            Text('Programs by ${expert.name.split(' ').first}',
                style: AppTextStyles.headingMedium(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
            const SizedBox(height: 12),
            ...state.programs.asMap().entries.map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ProgramCard(program: e.value, animationIndex: e.key),
            )),

            const SizedBox(height: 22),
            CustomButton(
              label: 'Apply for a Program',
              icon: Icons.arrow_forward_rounded,
              onPressed: () => context.go('/apply'),
            ).animate(delay: 200.ms).fadeIn(),
            const SizedBox(height: 40),
          ]),
        )),
      ]),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value, label; final IconData icon; final Color color; final bool isDark;
  const _StatItem({required this.value, required this.label, required this.icon, required this.color, required this.isDark});
  @override
  Widget build(BuildContext context) => Expanded(child: Column(children: [
    Icon(icon, size: 18, color: color),
    const SizedBox(height: 5),
    Text(value, style: GoogleFonts.syne(fontSize: 15, fontWeight: FontWeight.w800,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
    Text(label, style: GoogleFonts.dmSans(fontSize: 10,
        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
  ]));
}

class _Div extends StatelessWidget {
  final bool isDark;
  const _Div({required this.isDark});
  @override
  Widget build(BuildContext context) => Container(
    width: 1, height: 44, color: isDark ? AppColors.borderDark : AppColors.borderLight,
  );
}
