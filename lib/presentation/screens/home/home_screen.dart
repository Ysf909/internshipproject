import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../presentation/viewmodels/home_view_model.dart';
import '../../widgets/program_card.dart';
import '../../widgets/expert_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/custom_button.dart';
import '../../../data/mock/mock_data.dart';
import '../../../data/models/program_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state  = ref.watch(homeViewModelProvider);
    final vm     = ref.read(homeViewModelProvider.notifier);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: vm.refresh,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: state.isLoading
                ? const SizedBox(height: 400, child: Center(child: CircularProgressIndicator()))
                : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    _HeroSection(),
                    _StatsRow(),
                    const SizedBox(height: 36),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SectionHeader(
                        title: 'Featured Programs',
                        subtitle: 'Industry-co-created, results-driven',
                        actionLabel: 'See all',
                        onAction: () => context.go('/programs'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 292,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: state.featuredPrograms.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 14),
                        itemBuilder: (_, i) => ProgramCard(
                          program: state.featuredPrograms[i],
                          isHorizontal: true,
                          animationIndex: i,
                        ),
                      ),
                    ),

                    const SizedBox(height: 36),
                    _TwoPathsSection(),

                    const SizedBox(height: 36),
                    _WhyPraktixSection(),

                    const SizedBox(height: 8),
                    _LearningMethodSection(),

                    const SizedBox(height: 36),
                    _MissionSection(),

                    const SizedBox(height: 36),
                    _ImpactSection(),

                    const SizedBox(height: 36),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SectionHeader(
                        title: 'Meet Our Experts',
                        subtitle: 'Practitioners from Google, Meta, Apple & WEF',
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 220,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: state.experts.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 14),
                        itemBuilder: (_, i) => ExpertCard(
                          expert: state.experts[i],
                          animationIndex: i,
                        ),
                      ),
                    ),

                    const SizedBox(height: 36),
                    _VirtualCampusSection(),

                    const SizedBox(height: 36),
                    _TestimonialsSection(),

                    const SizedBox(height: 36),
                    _CompaniesSection(isDark: isDark),

                    const SizedBox(height: 36),
                    _CTABanner(),
                    const SizedBox(height: 40),
                  ]),
          ),
        ],
      ),
    );
  }
}

// ── Hero ─────────────────────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : const Color(0xFF0C0C10),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.4 : 0.18),
            blurRadius: 28,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(children: [
        // Subtle grid overlay
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CustomPaint(painter: _GridPainter()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Cohort badge (Tomorrow University style)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.impact.withOpacity(0.25),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.impactLight.withOpacity(0.4)),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  width: 5, height: 5,
                  decoration: const BoxDecoration(
                    color: AppColors.impactLight,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Applications Open · September 2025',
                  style: GoogleFonts.dmSans(
                    fontSize: 11, fontWeight: FontWeight.w600,
                    color: AppColors.impactLight,
                    letterSpacing: 0.2,
                  ),
                ),
              ]),
            ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2, end: 0),

            const SizedBox(height: 20),

            // Headline
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Learn With\nPurpose.\n',
                  style: GoogleFonts.merriweather(
                    fontSize: 32, fontWeight: FontWeight.w700,
                    color: Colors.white, height: 1.18,
                  ),
                ),
                TextSpan(
                  text: 'Build What Matters.',
                  style: GoogleFonts.merriweather(
                    fontSize: 28, fontWeight: FontWeight.w300,
                    color: Colors.white.withOpacity(0.65),
                    height: 1.3, fontStyle: FontStyle.italic,
                  ),
                ),
              ]),
            ).animate(delay: 80.ms).fadeIn(duration: 500.ms).slideY(begin: 0.08, end: 0),

            const SizedBox(height: 14),

            Text(
              'Short courses for fast career moves. Accredited degrees for lasting impact. '
              'Fully remote, mentor-led, and built for a world that needs you.',
              style: GoogleFonts.dmSans(
                fontSize: 13.5,
                color: Colors.white.withOpacity(0.65),
                height: 1.7,
              ),
            ).animate(delay: 160.ms).fadeIn(duration: 500.ms),

            const SizedBox(height: 24),

            // CTAs (Turing College + Tomorrow University style)
            Row(children: [
              // Primary: dark white button
              Expanded(child: GestureDetector(
                onTap: () => context.go('/programs'),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text(
                    'Explore Programs',
                    style: GoogleFonts.syne(
                      fontSize: 13, fontWeight: FontWeight.w700,
                      color: const Color(0xFF0C0C10),
                    ),
                  )),
                ),
              )),
              const SizedBox(width: 10),
              // Secondary: outlined
              Expanded(child: GestureDetector(
                onTap: () => context.go('/apply'),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white.withOpacity(0.35)),
                  ),
                  child: Center(child: Text(
                    'Get Curriculum',
                    style: GoogleFonts.syne(
                      fontSize: 13, fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  )),
                ),
              )),
            ]).animate(delay: 240.ms).fadeIn(duration: 500.ms),

            const SizedBox(height: 22),

            // Social proof
            Row(children: [
              // Stacked initials
              SizedBox(
                width: 88, height: 30,
                child: Stack(children: [
                  for (var i = 0; i < 4; i++)
                    Positioned(
                      left: i * 19.0,
                      child: Container(
                        width: 30, height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF0C0C10), width: 2),
                          color: [
                            const Color(0xFF7C6FFF),
                            const Color(0xFF00B87A),
                            const Color(0xFF1A8C5B),
                            const Color(0xFF2B7ABA),
                          ][i],
                        ),
                        child: Center(child: Text(
                          ['N','C','A','J'][i],
                          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                        )),
                      ),
                    ),
                ]),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(
                '97.9% employment · 2,400+ learners · 70+ countries',
                style: GoogleFonts.dmSans(
                  fontSize: 11, color: Colors.white.withOpacity(0.55), height: 1.4,
                ),
              )),
              // Ratings badge (Turing College style)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white.withOpacity(0.15)),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.star_rounded, size: 12, color: AppColors.accent),
                  const SizedBox(width: 3),
                  Text('4.9/5', style: GoogleFonts.syne(
                    fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white,
                  )),
                ]),
              ),
            ]).animate(delay: 320.ms).fadeIn(duration: 500.ms),
          ]),
        ),
      ]),
    );
  }
}

// ── Stats Row ─────────────────────────────────────────────────────
class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final stats = [
      ('2,400+', 'Learners'),
      ('97.9%', 'Employed'),
      ('9+',    'Programs'),
      ('70+',   'Countries'),
    ];
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
      ),
      child: Row(
        children: stats.asMap().entries.map((e) {
          final isLast = e.key == stats.length - 1;
          return Expanded(child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              border: Border(
                right: isLast
                    ? BorderSide.none
                    : BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight),
              ),
            ),
            child: Column(children: [
              Text(e.value.$1, style: GoogleFonts.syne(
                fontSize: 19, fontWeight: FontWeight.w800,
                color: isDark ? AppColors.textPrimaryDark : const Color(0xFF0C0C10),
              )),
              const SizedBox(height: 2),
              Text(e.value.$2, style: GoogleFonts.dmSans(
                fontSize: 10,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ), textAlign: TextAlign.center),
            ]),
          ).animate(delay: Duration(milliseconds: e.key * 80)).fadeIn(duration: 400.ms));
        }).toList(),
      ),
    );
  }
}

// ── Two Paths ─────────────────────────────────────────────────────
class _TwoPathsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SectionHeader(
          title: 'Two Ways to Grow',
          subtitle: 'Move fast with a short course, or go deep with a full degree',
        ),
      ),
      const SizedBox(height: 16),

      // Short Courses card — Turing College style (dark, clean)
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : const Color(0xFF0C0C10),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withOpacity(0.15)),
              ),
              child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Short Courses', style: GoogleFonts.syne(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
              Text('6–16 weeks · From \$599', style: GoogleFonts.dmSans(fontSize: 11, color: Colors.white.withOpacity(0.55))),
            ]),
          ]),
          const SizedBox(height: 16),
          ...[
            '⚡  Sprint-based · 8–12 hrs/week at your own pace',
            '🧑‍💼  1:1 mentorship from industry practitioners',
            '📂  Real portfolio projects reviewed by seniors',
            '🎯  Career-outcome focused · avg. 3 months to hire',
          ].map((t) => Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Text(t, style: GoogleFonts.dmSans(fontSize: 12, color: Colors.white.withOpacity(0.78), height: 1.5)),
          )),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => context.go('/programs'),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text('Browse Courses', style: GoogleFonts.syne(
                fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF0C0C10),
              ))),
            ),
          ),
        ]),
      ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.04, end: 0),

      const SizedBox(height: 12),

      // Degree Programs card — Tomorrow University style (green-accented, clean)
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : AppColors.cardLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: AppColors.impact.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.impact.withOpacity(0.2)),
              ),
              child: Icon(Icons.school_rounded, color: isDark ? AppColors.impactLight : AppColors.impact, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text('Degree Programs', style: GoogleFonts.syne(
                  fontSize: 16, fontWeight: FontWeight.w800,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                )),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.sdgGold.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: AppColors.sdgGold.withOpacity(0.4)),
                  ),
                  child: Text('Accredited', style: GoogleFonts.syne(
                    fontSize: 8, fontWeight: FontWeight.w800, color: AppColors.sdgGold,
                  )),
                ),
              ]),
              Text("Bachelor's · Master's · MBA",
                style: GoogleFonts.dmSans(fontSize: 11, color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
            ])),
          ]),
          const SizedBox(height: 16),
          ...[
            '🎓  State-recognized German university credential',
            '🌍  Challenge-based · no exams, real projects only',
            '🏙️  Monthly in-person city hubs on 4 continents',
            '🌱  SDG-aligned curriculum for purposeful careers',
          ].map((t) => Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Text(t, style: GoogleFonts.dmSans(
              fontSize: 12, height: 1.5,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            )),
          )),
          const SizedBox(height: 16),
          _DegreePreviewRow(isDark: isDark),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => context.go('/programs'),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isDark ? AppColors.impact : AppColors.impact,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text('Explore Degrees', style: GoogleFonts.syne(
                fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white,
              ))),
            ),
          ),
        ]),
      ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.04, end: 0),
    ]);
  }
}

class _DegreePreviewRow extends StatelessWidget {
  final bool isDark;
  const _DegreePreviewRow({required this.isDark});
  @override
  Widget build(BuildContext context) {
    final degrees = MockData.degrees.take(3).toList();
    return Column(children: degrees.asMap().entries.map((e) {
      final p = e.value;
      final isLast = e.key == degrees.length - 1;
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
        margin: EdgeInsets.only(bottom: isLast ? 0 : 7),
        decoration: BoxDecoration(
          color: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
        ),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.impact.withOpacity(0.1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(p.degreeType ?? 'Cert', style: GoogleFonts.syne(
              fontSize: 8, fontWeight: FontWeight.w800,
              color: isDark ? AppColors.impactLight : AppColors.impact,
            )),
          ),
          const SizedBox(width: 9),
          Expanded(child: Text(
            p.title.replaceAll(RegExp(r'^(B\.Sc\.\s*|M\.Sc\.\s*|Impact\s*)'), '').trim(),
            style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w600,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
            maxLines: 1, overflow: TextOverflow.ellipsis,
          )),
          Text(p.duration, style: GoogleFonts.dmSans(
            fontSize: 10, color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          )),
        ]),
      );
    }).toList());
  }
}

// ── Why Praktix ────────────────────────────────────────────────────
class _WhyPraktixSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final features = [
      (Icons.verified_rounded,  AppColors.primary,  'Industry Experts',  'Practitioners from Google, Meta, Apple, WEF & Stripe'),
      (Icons.build_rounded,     AppColors.secondary, 'Real Projects',    '9–24 portfolio projects per program'),
      (Icons.people_rounded,    AppColors.impact,    '1:1 Mentorship',   'Weekly + async feedback from senior mentors'),
      (Icons.eco_rounded,       AppColors.sdgGold,   'Purpose-Driven',   'SDG-aligned programs with real global impact'),
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SectionHeader(title: 'Why Praktix', subtitle: 'Built for real outcomes and lasting impact'),
      ),
      const SizedBox(height: 14),
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 1.25,
        ),
        itemCount: features.length,
        itemBuilder: (context, i) {
          final f = features[i];
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : AppColors.cardLight,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  color: f.$2.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(f.$1, size: 18, color: f.$2),
              ),
              const SizedBox(height: 10),
              Text(f.$3, style: AppTextStyles.headingSmall(
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              )),
              const SizedBox(height: 3),
              Text(f.$4, style: AppTextStyles.bodySmall(
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ), maxLines: 3, overflow: TextOverflow.ellipsis),
            ]),
          ).animate(delay: Duration(milliseconds: i * 70)).fadeIn(duration: 400.ms).scale(
            begin: const Offset(0.96, 0.96), end: const Offset(1, 1),
          );
        },
      ),
    ]);
  }
}

// ── Learning Method ────────────────────────────────────────────────
class _LearningMethodSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final steps = [
      ('01', Icons.menu_book_rounded,    AppColors.primary,   'Sprint Learning',   'Bite-sized modules replace lectures. Study 8–12 hrs/week, entirely on your schedule.'),
      ('02', Icons.handyman_rounded,     AppColors.secondary, 'Challenge Projects', 'Every sprint ends with a real project reviewed by a senior industry professional.'),
      ('03', Icons.people_outline_rounded,AppColors.accent,   'Peer Reviews',      'Review peers\' work to deepen your understanding — the Protégé Effect in action.'),
      ('04', Icons.person_search_rounded, AppColors.impact,   '1:1 Mentoring',     'Weekly standups + async Q&A with Senior Team Leads from Google, Meta, and WEF.'),
      ('05', Icons.workspace_premium_rounded, AppColors.sky,  'Graduate & Impact', 'Portfolio, certificate, and the confidence to create meaningful change.'),
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SectionHeader(title: 'How You Will Learn', subtitle: 'No lectures. No exams. Just real growth.'),
      ),
      const SizedBox(height: 16),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
        ),
        child: Column(children: steps.asMap().entries.map((e) {
          final s = e.value;
          final isLast = e.key == steps.length - 1;
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border(
                bottom: isLast ? BorderSide.none : BorderSide(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
              ),
            ),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  color: s.$3.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(s.$2, size: 18, color: s.$3),
              ),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Text(s.$1, style: GoogleFonts.syne(
                    fontSize: 9, fontWeight: FontWeight.w800,
                    color: isDark ? AppColors.textHintDark : AppColors.textHintLight,
                    letterSpacing: 1.2,
                  )),
                  const SizedBox(width: 8),
                  Text(s.$4, style: AppTextStyles.labelLarge(
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  )),
                ]),
                const SizedBox(height: 3),
                Text(s.$5, style: AppTextStyles.bodySmall(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                )),
              ])),
            ]),
          ).animate(delay: Duration(milliseconds: e.key * 60)).fadeIn(duration: 400.ms).slideX(begin: -0.04, end: 0);
        }).toList()),
      ),
    ]);
  }
}

// ── Mission Section ────────────────────────────────────────────────
class _MissionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pillars = [
      ('01', '🎯', 'Purpose-Driven', 'Every program connects learning to real-world impact and your career transformation.'),
      ('02', '🌍', 'Community-Powered', 'A global cohort from 70+ countries — peer reviews, co-working, lifelong alumni network.'),
      ('03', '⚡', 'Flexible + Accountable', 'Study on your schedule with structured sprints — no need to quit your day job.'),
      ('04', '🤖', 'AI-Enhanced', 'Co-created with active practitioners. Always reflects what companies need today.'),
    ];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Header band — clean dark (not gradient)
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1A1F28) : const Color(0xFF0C0C10),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('OUR MISSION', style: GoogleFonts.syne(
              fontSize: 9, fontWeight: FontWeight.w800,
              color: Colors.white.withOpacity(0.5), letterSpacing: 2,
            )),
            const SizedBox(height: 8),
            Text(
              '"Education should be purposeful, accessible, and deeply connected to the world you\'re entering."',
              style: GoogleFonts.merriweather(
                fontSize: 13, fontStyle: FontStyle.italic,
                color: Colors.white.withOpacity(0.88), height: 1.65,
              ),
            ),
          ]),
        ),
        ...pillars.asMap().entries.map((e) {
          final p = e.value;
          final isLast = e.key == pillars.length - 1;
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: isLast ? BorderSide.none : BorderSide(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
              ),
            ),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(p.$1, style: GoogleFonts.syne(
                fontSize: 9, fontWeight: FontWeight.w800,
                color: isDark ? AppColors.textHintDark : AppColors.textHintLight,
                letterSpacing: 1,
              )),
              const SizedBox(width: 10),
              Text(p.$2, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 10),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(p.$3, style: AppTextStyles.labelLarge(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                )),
                const SizedBox(height: 2),
                Text(p.$4, style: AppTextStyles.bodySmall(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                )),
              ])),
            ]),
          ).animate(delay: Duration(milliseconds: e.key * 70)).fadeIn(duration: 400.ms).slideX(begin: -0.04, end: 0);
        }),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
          child: Wrap(spacing: 7, runSpacing: 7, children: [
            '🏛 State-Recognized', '📱 Fully Remote', '🤝 1:1 Mentored', '🌱 Impact-Focused',
          ].map((t) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
            ),
            child: Text(t, style: GoogleFonts.dmSans(
              fontSize: 10,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            )),
          )).toList()),
        ),
      ]),
    ).animate().fadeIn(duration: 500.ms);
  }
}

// ── Impact Section ─────────────────────────────────────────────────
class _ImpactSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sdgs = [
      ('🎓', '4',  'Quality\nEducation',   AppColors.primary),
      ('⚡', '7',  'Clean\nEnergy',         AppColors.sdgGold),
      ('📈', '8',  'Decent\nWork',          AppColors.secondary),
      ('🌱', '13', 'Climate\nAction',       AppColors.impact),
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SectionHeader(
          title: 'Powered by Purpose',
          subtitle: 'Programs aligned with the UN Sustainable Development Goals',
        ),
      ),
      const SizedBox(height: 16),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : AppColors.cardLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Text('🌍', style: TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
            Expanded(child: Text(
              'Every program is built to create measurable real-world impact.',
              style: GoogleFonts.merriweather(
                fontSize: 12, fontStyle: FontStyle.italic,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                height: 1.5,
              ),
            )),
          ]),
          const SizedBox(height: 16),
          Row(children: sdgs.asMap().entries.map((e) {
            final s = e.value;
            return Expanded(child: Container(
              margin: EdgeInsets.only(right: e.key < sdgs.length - 1 ? 8 : 0),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: s.$4.withOpacity(0.07),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: s.$4.withOpacity(0.2)),
              ),
              child: Column(children: [
                Text(s.$1, style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 4),
                Container(
                  width: 20, height: 20,
                  decoration: BoxDecoration(
                    color: s.$4,
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Text(s.$2,
                    style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w900))),
                ),
                const SizedBox(height: 4),
                Text(s.$3, style: GoogleFonts.syne(
                  fontSize: 8, fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  height: 1.3,
                ), textAlign: TextAlign.center),
              ]),
            ).animate(delay: Duration(milliseconds: e.key * 60)).fadeIn(duration: 400.ms));
          }).toList()),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () => context.go('/programs'),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 11),
              decoration: BoxDecoration(
                color: AppColors.impact,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text('View Accredited Degrees', style: GoogleFonts.syne(
                  fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white,
                )),
                const SizedBox(width: 6),
                const Icon(Icons.arrow_forward_rounded, size: 13, color: Colors.white),
              ])),
            ),
          ),
        ]),
      ).animate().fadeIn(duration: 500.ms),
    ]);
  }
}

// ── Virtual Campus ─────────────────────────────────────────────────
class _VirtualCampusSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hubs = [
      ('🇩🇪', 'Berlin',    'HQ'),
      ('🇬🇧', 'London',    'Hub'),
      ('🇰🇪', 'Nairobi',   'Hub'),
      ('🇸🇬', 'Singapore', 'Hub'),
      ('🇧🇷', 'São Paulo', 'Hub'),
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SectionHeader(
          title: 'Virtual Campus',
          subtitle: 'Global community · local hubs · connected by purpose',
        ),
      ),
      const SizedBox(height: 16),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : AppColors.cardLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Learn anywhere. Meet everywhere.', style: GoogleFonts.syne(
                fontSize: 14, fontWeight: FontWeight.w800,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              )),
              const SizedBox(height: 5),
              Text(
                'Our mobile-first platform works on all devices. Complement online learning with monthly in-person events at city hubs worldwide.',
                style: GoogleFonts.dmSans(fontSize: 12, height: 1.65,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
              ),
              const SizedBox(height: 16),
              Text('CITY HUBS', style: GoogleFonts.syne(
                fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2,
                color: isDark ? AppColors.textHintDark : AppColors.textHintLight,
              )),
              const SizedBox(height: 10),
              Wrap(spacing: 7, runSpacing: 7, children: hubs.map((h) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(h.$1, style: const TextStyle(fontSize: 13)),
                  const SizedBox(width: 5),
                  Text(h.$2, style: GoogleFonts.syne(
                    fontSize: 11, fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  )),
                  if (h.$3 == 'HQ') ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('HQ', style: GoogleFonts.syne(
                        fontSize: 7, fontWeight: FontWeight.w800, color: AppColors.primary,
                      )),
                    ),
                  ],
                ]),
              )).toList()),
              const SizedBox(height: 14),
              Row(children: [
                _PlatformChip(Icons.phone_android_rounded, 'Mobile', isDark),
                const SizedBox(width: 7),
                _PlatformChip(Icons.desktop_mac_rounded,   'Web',    isDark),
                const SizedBox(width: 7),
                _PlatformChip(Icons.discord,               'Discord', isDark),
              ]),
            ]),
          ),
        ]),
      ).animate().fadeIn(duration: 500.ms),
    ]);
  }
}

class _PlatformChip extends StatelessWidget {
  final IconData icon; final String label; final bool isDark;
  const _PlatformChip(this.icon, this.label, this.isDark);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      borderRadius: BorderRadius.circular(7),
      border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 12, color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
      const SizedBox(width: 5),
      Text(label, style: GoogleFonts.syne(
        fontSize: 10, fontWeight: FontWeight.w700,
        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
      )),
    ]),
  );
}

// ── Testimonials ───────────────────────────────────────────────────
class _TestimonialsSection extends StatelessWidget {
  static const _testimonials = [
    ('N', Color(0xFF7C6FFF), 'Nour Al-Rashidi', 'Data Analyst · Wise',      'Switching careers is never easy, but Praktix gave me the skills, support, and confidence. The projects and mentor network are unmatched.'),
    ('C', Color(0xFF00B87A), 'Carlos Mendez',   'ML Engineer · NordSecurity','The peer review system is brilliant — reviewing others\' work is where you truly solidify your own understanding.'),
    ('A', Color(0xFF1A8C5B), 'Aisha Okonkwo',   'Impact MBA Graduate',       'I joined for the MBA but stayed for the community. City hubs in Nairobi changed my network — and my life trajectory.'),
    ('J', Color(0xFF2B7ABA), 'Jonas Weber',     'AI Engineer · Klarna',      'The sprint model is tough but fair. After 12 weeks, I had a portfolio that impressed every interviewer.'),
  ];
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SectionHeader(title: 'Student Stories', subtitle: 'Real people. Real transformations.'),
      ),
      const SizedBox(height: 16),
      SizedBox(
        height: 196,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: _testimonials.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, i) {
            final t = _testimonials[i];
            return Container(
              width: 272,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.cardDark : AppColors.cardLight,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  for (var s = 0; s < 5; s++)
                    Icon(Icons.star_rounded, size: 12, color: AppColors.accent),
                ]),
                const SizedBox(height: 8),
                Expanded(child: Text(
                  '"${t.$5}"',
                  style: GoogleFonts.dmSans(
                    fontSize: 12, fontStyle: FontStyle.italic,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    height: 1.6,
                  ),
                  maxLines: 5, overflow: TextOverflow.ellipsis,
                )),
                const SizedBox(height: 10),
                Row(children: [
                  CircleAvatar(radius: 16, backgroundColor: t.$2,
                    child: Text(t.$1, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700))),
                  const SizedBox(width: 9),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(t.$3, style: AppTextStyles.labelLarge(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
                    Text(t.$4, style: AppTextStyles.bodySmall(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
                  ])),
                ]),
              ]),
            ).animate(delay: Duration(milliseconds: i * 90)).fadeIn(duration: 400.ms).slideX(begin: 0.08, end: 0);
          },
        ),
      ),
    ]);
  }
}

// ── Companies ──────────────────────────────────────────────────────
class _CompaniesSection extends StatelessWidget {
  final bool isDark;
  const _CompaniesSection({required this.isDark});
  @override
  Widget build(BuildContext context) {
    final cos = ['Google', 'Meta', 'Apple', 'Spotify', 'Stripe', 'Wise', 'WEF', 'Klarna'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        Text('OUR GRADUATES WORK AT', style: GoogleFonts.syne(
          fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 1.8,
          color: isDark ? AppColors.textHintDark : AppColors.textHintLight,
        )),
        const SizedBox(height: 14),
        Wrap(spacing: 18, runSpacing: 10, alignment: WrapAlignment.center,
          children: cos.map((c) => Opacity(
            opacity: 0.3,
            child: Text(c, style: GoogleFonts.syne(fontSize: 15, fontWeight: FontWeight.w800,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
          )).toList()),
      ]),
    );
  }
}

// ── CTA Banner ─────────────────────────────────────────────────────
class _CTABanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1F28) : const Color(0xFF0C0C10),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Ready to begin?', style: GoogleFonts.syne(
          fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white,
        )),
        const SizedBox(height: 6),
        Text(
          'Join 2,400+ professionals who transformed their careers with Praktix. No payment needed to apply.',
          style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white.withOpacity(0.6), height: 1.6),
        ),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(child: GestureDetector(
            onTap: () => context.go('/apply'),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 13),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text('Apply for Free', style: GoogleFonts.syne(
                fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF0C0C10),
              ))),
            ),
          )),
          const SizedBox(width: 10),
          Expanded(child: GestureDetector(
            onTap: () => context.go('/programs'),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withOpacity(0.25)),
              ),
              child: Center(child: Text('Browse Programs', style: GoogleFonts.syne(
                fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white,
              ))),
            ),
          )),
        ]),
        const SizedBox(height: 10),
        Center(child: Text(
          'No upfront payment · Response within 24h · Flexible start dates',
          style: GoogleFonts.dmSans(fontSize: 10, color: Colors.white.withOpacity(0.35)),
          textAlign: TextAlign.center,
        )),
      ]),
    ).animate().fadeIn(duration: 500.ms);
  }
}

// ── Grid painter ────────────────────────────────────────────────────
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..strokeWidth = 0.7;
    const step = 44.0;
    for (double x = 0; x <= size.width; x += step)
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    for (double y = 0; y <= size.height; y += step)
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
  }
  @override
  bool shouldRepaint(_GridPainter o) => false;
}
