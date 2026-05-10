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
                Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                  Text('Praktix', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w800, color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight, height: 1.1)),
                  Text('University', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w500, color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight, letterSpacing: 1.2, height: 1.1)),
                ]),
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
                        child: SectionHeader(title: 'Degrees & Certificates', subtitle: 'Accredited programs built for real outcomes', actionLabel: 'View all', onAction: () => context.go('/programs')),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 290,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: state.featuredPrograms.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 14),
                          itemBuilder: (_, i) => ProgramCard(program: state.featuredPrograms[i], isHorizontal: true, animationIndex: i),
                        ),
                      ),
                      const SizedBox(height: 32),
                      _LearningModelSection(),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SectionHeader(title: 'Meet Our Faculty', subtitle: 'Senior professionals from Google, Meta, Apple & more'),
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
                      _TestimonialsSection(),
                      const SizedBox(height: 28),
                      _AccreditationBanner(),
                      const SizedBox(height: 28),
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
          child: const Text('🎓  New Cohort Starting September 2025', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
        ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2, end: 0),
        const SizedBox(height: 14),
        Text('Your Purpose.\nYour Career.\nYour Future.',
            style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w800, color: Colors.white, height: 1.2))
            .animate(delay: 100.ms).fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0),
        const SizedBox(height: 10),
        Text('Accredited degrees and industry certificates built by senior professionals at Google, Meta, Apple & Stripe. Learn in sprints. Grow by doing. Land the career you deserve.',
            style: GoogleFonts.inter(fontSize: 13, color: Colors.white.withOpacity(0.88), height: 1.55))
            .animate(delay: 200.ms).fadeIn(duration: 500.ms),
        const SizedBox(height: 6),
        Row(children: [
          const Icon(Icons.verified_rounded, size: 14, color: Colors.white70),
          const SizedBox(width: 4),
          Text('Accredited · 97.9% Job Placement · Top 10% Admitted', style: GoogleFonts.inter(fontSize: 11, color: Colors.white70)),
        ]).animate(delay: 250.ms).fadeIn(duration: 400.ms),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(child: ElevatedButton(
            onPressed: () => context.go('/programs'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppColors.primary, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            child: Text('Explore Programs', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 13)),
          )),
          const SizedBox(width: 10),
          Expanded(child: OutlinedButton(
            onPressed: () => context.go('/apply'),
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white, width: 1.5), padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            child: Text('Apply Now', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)),
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
    final stats = [
      ('10K+', 'Alumni'),
      ('8', 'Degrees'),
      ('40+', 'Faculty'),
      ('97.9%', 'Job Rate'),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: stats.asMap().entries.map((e) => Expanded(
          child: Column(children: [
            Text(e.value.$1, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w800, color: isDark ? AppColors.primaryLight : AppColors.primary)),
            Text(e.value.$2, style: GoogleFonts.inter(fontSize: 11, color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight, height: 1.4), textAlign: TextAlign.center),
          ]).animate(delay: Duration(milliseconds: e.key * 80)).fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),
        )).toList(),
      ),
    );
  }
}

class _LearningModelSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final steps = [
      (Icons.auto_stories_rounded, 'Sprint Learning', 'Curated resources + hands-on projects, no lectures. Move at your pace with sprint deadlines.'),
      (Icons.rate_review_rounded, 'Peer Review', 'Teach to learn. Reviewing junior work is how you solidify every skill—the Protégé Effect.'),
      (Icons.groups_rounded, 'Expert 1-on-1', 'Weekly standups and personal project reviews with senior industry professionals.'),
      (Icons.work_outline_rounded, 'Career Launch', 'Resume, portfolio, mock interviews, referrals, and a Job Guarantee on select programs.'),
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: SectionHeader(title: 'How Praktix Works', subtitle: 'Education designed for real career outcomes')),
      const SizedBox(height: 16),
      GridView.builder(
        shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.25),
        itemCount: steps.length,
        itemBuilder: (context, i) {
          final s = steps[i];
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: isDark ? AppColors.cardDark : AppColors.cardLight, borderRadius: BorderRadius.circular(14), border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(width: 32, height: 32, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.12), borderRadius: BorderRadius.circular(8)), child: Icon(s.$1, size: 16, color: isDark ? AppColors.primaryLight : AppColors.primary)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: AppColors.secondary.withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
                  child: Text('${i + 1}', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.secondary)),
                ),
              ]),
              const SizedBox(height: 10),
              Text(s.$2, style: AppTextStyles.labelLarge(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
              const SizedBox(height: 4),
              Expanded(child: Text(s.$3, style: AppTextStyles.bodySmall(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight), maxLines: 3, overflow: TextOverflow.ellipsis)),
            ]),
          ).animate(delay: Duration(milliseconds: i * 80)).fadeIn(duration: 400.ms).scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
        },
      ),
    ]);
  }
}

class _TestimonialsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final testimonials = [
      (
        '"Switching careers felt impossible until Praktix. The sprint model and 1-on-1 reviews gave me confidence I never had at a traditional university."',
        'Lena K.',
        'Now: Data Analyst at Wise',
        'https://randomuser.me/api/portraits/women/29.jpg',
      ),
      (
        '"I finished two universities. Praktix is the most advanced learning environment I have encountered. The peer review alone changed how I think."',
        'Carlos M.',
        'Now: Flutter Engineer at NordSecurity',
        'https://randomuser.me/api/portraits/men/41.jpg',
      ),
      (
        '"Defining my personal mission from day one kept me motivated throughout. Praktix is not just education—it is a transformation."',
        'Amira N.',
        'Now: Impact MBA Graduate',
        'https://randomuser.me/api/portraits/women/52.jpg',
      ),
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: SectionHeader(title: 'Student Stories', subtitle: 'Real outcomes from real people')),
      const SizedBox(height: 16),
      SizedBox(
        height: 200,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: testimonials.length,
          separatorBuilder: (_, __) => const SizedBox(width: 14),
          itemBuilder: (_, i) {
            final t = testimonials[i];
            return Container(
              width: 280,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isDark ? AppColors.cardDark : AppColors.cardLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: List.generate(5, (_) => const Icon(Icons.star_rounded, size: 14, color: AppColors.accent))),
                const SizedBox(height: 10),
                Expanded(child: Text(t.$1, style: GoogleFonts.inter(fontSize: 12.5, color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight, height: 1.55, fontStyle: FontStyle.italic), overflow: TextOverflow.ellipsis, maxLines: 5)),
                const SizedBox(height: 10),
                Row(children: [
                  CircleAvatar(backgroundImage: NetworkImage(t.$4), radius: 14),
                  const SizedBox(width: 8),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(t.$2, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
                    Text(t.$3, style: GoogleFonts.inter(fontSize: 11, color: AppColors.secondary)),
                  ])),
                ]),
              ]),
            ).animate(delay: Duration(milliseconds: i * 100)).fadeIn(duration: 400.ms);
          },
        ),
      ),
    ]);
  }
}

class _AccreditationBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final badges = [
      (Icons.verified_rounded, 'Accredited\nDegrees'),
      (Icons.public_rounded, 'UN SDG\nAligned'),
      (Icons.emoji_events_rounded, 'Fortune Mag\nTop School'),
      (Icons.handshake_outlined, 'Industry\nPartners'),
    ];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : const Color(0xFFF0F4FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFD0D9F5)),
      ),
      child: Column(children: [
        Text('Trusted Worldwide', style: AppTextStyles.headingSmall(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
        const SizedBox(height: 4),
        Text('Accredited programs · Top 10% admission · Job guarantee', style: GoogleFonts.inter(fontSize: 12, color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight), textAlign: TextAlign.center),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: badges.asMap().entries.map((e) => Column(children: [
          Icon(e.value.$1, size: 24, color: isDark ? AppColors.primaryLight : AppColors.primary),
          const SizedBox(height: 6),
          Text(e.value.$2, style: GoogleFonts.inter(fontSize: 10.5, fontWeight: FontWeight.w600, color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight, height: 1.3), textAlign: TextAlign.center),
        ]).animate(delay: Duration(milliseconds: e.key * 60)).fadeIn(duration: 400.ms)).toList()),
      ]),
    ).animate().fadeIn(duration: 400.ms);
  }
}

class _CTABanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(gradient: AppColors.heroGradient, borderRadius: BorderRadius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Start Your Journey', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
        const SizedBox(height: 6),
        Text('Join 10,000+ alumni who transformed their careers and lives with Praktix University. Applications open for September 2025.', style: GoogleFonts.inter(fontSize: 13, color: Colors.white.withOpacity(0.88), height: 1.5)),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: ElevatedButton(
            onPressed: () => context.go('/apply'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppColors.primary, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            child: Text('Apply Free', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 13)),
          )),
          const SizedBox(width: 10),
          Expanded(child: OutlinedButton(
            onPressed: () => context.go('/programs'),
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white, width: 1.5), padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            child: Text('Browse Degrees', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)),
          )),
        ]),
      ]),
    ).animate().fadeIn(duration: 500.ms);
  }
}
