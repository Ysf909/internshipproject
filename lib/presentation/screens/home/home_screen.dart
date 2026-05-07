import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../presentation/viewmodels/home_view_model.dart';
import '../../../presentation/providers/theme_provider.dart';
import '../../widgets/program_card.dart';
import '../../widgets/expert_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/custom_button.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // ── View talks only to its ViewModel ──────────────────
    final state = ref.watch(homeViewModelProvider);
    final vm = ref.read(homeViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: RefreshIndicator(
        onRefresh: vm.refresh,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              elevation: 0,
              title: Row(children: [
                Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(gradient: AppColors.heroGradient, borderRadius: BorderRadius.circular(8)),
                  child: const Center(child: Text('P', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800, fontFamily: 'Poppins'))),
                ),
                const SizedBox(width: 8),
                Text('Praktix', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w800, color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
              ]),
              actions: [
                IconButton(
                  icon: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded, color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                  onPressed: () => ref.read(themeProvider.notifier).toggle(),
                ),
                IconButton(icon: Icon(Icons.notifications_outlined, color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight), onPressed: () {}),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Divider(height: 1, color: isDark ? AppColors.borderDark : AppColors.borderLight),
              ),
            ),
            SliverToBoxAdapter(
              child: state.isLoading
                  ? const SizedBox(height: 400, child: Center(child: CircularProgressIndicator()))
                  : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      _HeroSection(),
                      const SizedBox(height: 28),
                      _StatsRow(),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SectionHeader(title: 'Featured Programs', subtitle: 'Hand-picked by our team', actionLabel: 'See all', onAction: () => context.go('/programs')),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 280,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: state.featuredPrograms.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 14),
                          itemBuilder: (_, i) => ProgramCard(program: state.featuredPrograms[i], isHorizontal: true, animationIndex: i),
                        ),
                      ),
                      const SizedBox(height: 32),
                      _WhyPraktixSection(),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SectionHeader(title: 'Meet Our Experts', subtitle: 'Industry professionals who guide you'),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 210,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: state.experts.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 14),
                          itemBuilder: (_, i) => ExpertCard(expert: state.experts[i], animationIndex: i),
                        ),
                      ),
                      const SizedBox(height: 32),
                      _CTABanner(),
                      const SizedBox(height: 32),
                    ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(gradient: AppColors.heroGradient, borderRadius: BorderRadius.circular(24)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
          child: const Text('🚀  New Cohort Starting June 2025', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
        ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2, end: 0),
        const SizedBox(height: 14),
        Text('Build Real Skills.\nLaunch Real Careers.',
            style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w800, color: Colors.white, height: 1.2))
            .animate(delay: 100.ms).fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0),
        const SizedBox(height: 10),
        Text('Learn from industry leaders at Google, Meta, Apple & Spotify. Get mentored, build portfolio projects, and land your dream role.',
            style: GoogleFonts.inter(fontSize: 14, color: Colors.white.withOpacity(0.85), height: 1.5))
            .animate(delay: 200.ms).fadeIn(duration: 500.ms),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(child: ElevatedButton(
            onPressed: () => context.go('/programs'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppColors.primary, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            child: Text('Explore Programs', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 14)),
          )),
          const SizedBox(width: 10),
          Expanded(child: OutlinedButton(
            onPressed: () => context.go('/apply'),
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white, width: 1.5), padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            child: Text('Apply Now', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
          )),
        ]).animate(delay: 300.ms).fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0),
      ]),
    );
  }
}

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final stats = [('1,200+', 'Students'), ('50+', 'Programs'), ('30+', 'Experts'), ('94%', 'Job Rate')];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: stats.asMap().entries.map((e) => Expanded(
          child: Column(children: [
            Text(e.value.$1, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w800, color: isDark ? AppColors.primaryLight : AppColors.primary)),
            Text(e.value.$2, style: GoogleFonts.inter(fontSize: 12, color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
          ]).animate(delay: Duration(milliseconds: e.key * 80)).fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),
        )).toList(),
      ),
    );
  }
}

class _WhyPraktixSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final features = [
      (Icons.verified_rounded, 'Industry Experts', 'Learn from practitioners at top tech companies'),
      (Icons.work_outline_rounded, 'Real Projects', 'Build a portfolio that impresses employers'),
      (Icons.support_agent_rounded, '1:1 Mentorship', 'Weekly sessions with your dedicated expert'),
      (Icons.emoji_events_rounded, 'Career Support', 'Resume review, mock interviews & referrals'),
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: SectionHeader(title: 'Why Praktix?', subtitle: 'The platform built for real outcomes')),
      const SizedBox(height: 16),
      GridView.builder(
        shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.4),
        itemCount: features.length,
        itemBuilder: (context, i) {
          final f = features[i];
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: isDark ? AppColors.cardDark : AppColors.cardLight, borderRadius: BorderRadius.circular(14), border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(f.$1, size: 18, color: isDark ? AppColors.primaryLight : AppColors.primary)),
              const SizedBox(height: 8),
              Text(f.$2, style: AppTextStyles.labelLarge(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
              const SizedBox(height: 3),
              Text(f.$3, style: AppTextStyles.bodySmall(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight), maxLines: 2, overflow: TextOverflow.ellipsis),
            ]),
          ).animate(delay: Duration(milliseconds: i * 80)).fadeIn(duration: 400.ms).scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
        },
      ),
    ]);
  }
}

class _CTABanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.primary.withOpacity(0.2))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Ready to level up?', style: AppTextStyles.headingMedium(color: AppColors.primary)),
        const SizedBox(height: 6),
        Text('Join 1,200+ professionals who transformed their careers with Praktix.', style: AppTextStyles.bodyMedium()),
        const SizedBox(height: 16),
        CustomButton(label: 'Apply for Free', icon: Icons.arrow_forward_rounded, onPressed: () => context.go('/apply'), width: 200),
      ]),
    ).animate().fadeIn(duration: 500.ms);
  }
}
