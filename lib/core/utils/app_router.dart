import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_colors.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/programs/programs_screen.dart';
import '../../presentation/screens/programs/program_detail_screen.dart';
import '../../presentation/screens/experts/expert_profile_screen.dart';
import '../../presentation/screens/apply/apply_screen.dart';
import '../../presentation/providers/theme_provider.dart';

final _rootNavigatorKey  = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) =>
          _ScaffoldWithNav(child: child, location: state.uri.toString()),
      routes: [
        GoRoute(
          path: '/',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/programs',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const ProgramsScreen(),
        ),
        GoRoute(
          path: '/apply',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) {
            final programId = state.uri.queryParameters['programId'];
            return ApplyScreen(preselectedProgramId: programId);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/programs/:id',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) =>
          ProgramDetailScreen(programId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/experts/:id',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) =>
          ExpertProfileScreen(expertId: state.pathParameters['id']!),
    ),
  ],
);

// ── Shell scaffold with announcement bar + website-style bottom nav ──
class _ScaffoldWithNav extends ConsumerStatefulWidget {
  final Widget child;
  final String location;
  const _ScaffoldWithNav({required this.child, required this.location});

  @override
  ConsumerState<_ScaffoldWithNav> createState() => _ScaffoldWithNavState();
}

class _ScaffoldWithNavState extends ConsumerState<_ScaffoldWithNav> {
  bool _bannerDismissed = false;

  int get _selectedIndex {
    if (widget.location.startsWith('/programs')) return 1;
    if (widget.location.startsWith('/apply'))    return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: Column(
        children: [
          // ── Announcement bar (Tomorrow University style) ──────────
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: _bannerDismissed
                ? const SizedBox.shrink()
                : _AnnouncementBanner(
                    onDismiss: () => setState(() => _bannerDismissed = true),
                  ),
          ),
          // ── Top app bar (Turing College style) ────────────────────
          _TopNavBar(isDark: isDark, ref: ref),
          // ── Screen content ────────────────────────────────────────
          Expanded(child: widget.child),
        ],
      ),
      // ── Bottom nav (clean website tab style) ─────────────────────
      bottomNavigationBar: _BottomNavBar(
        selectedIndex: _selectedIndex,
        isDark: isDark,
        location: widget.location,
      ),
    );
  }
}

// ── Announcement banner (Tomorrow University style) ──────────────
class _AnnouncementBanner extends StatelessWidget {
  final VoidCallback onDismiss;
  const _AnnouncementBanner({required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.impactDark,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 16, right: 8, bottom: 8,
      ),
      child: Row(children: [
        Container(
          width: 6, height: 6,
          decoration: const BoxDecoration(
            color: AppColors.impactLight,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(
          'Applications Open · September 2025 Cohort · Join our Open Day →',
          style: GoogleFonts.dmSans(
            fontSize: 11, fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.92),
            height: 1.3,
          ),
          maxLines: 1, overflow: TextOverflow.ellipsis,
        )),
        GestureDetector(
          onTap: onDismiss,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Icon(Icons.close_rounded, size: 14, color: Colors.white.withOpacity(0.7)),
          ),
        ),
      ]),
    ).animate().slideY(begin: -1, end: 0, duration: 400.ms, curve: Curves.easeOut);
  }
}

// ── Top nav bar (Turing College / Tomorrow University style) ──────
class _TopNavBar extends StatelessWidget {
  final bool isDark;
  final WidgetRef ref;
  const _TopNavBar({required this.isDark, required this.ref});

  @override
  Widget build(BuildContext context) {
    final bg     = isDark ? AppColors.surfaceDark    : AppColors.surfaceLight;
    final border = isDark ? AppColors.borderDark     : AppColors.borderLight;
    final textP  = isDark ? AppColors.textPrimaryDark  : AppColors.textPrimaryLight;
    final textS  = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: bg,
        border: Border(bottom: BorderSide(color: border, width: 1)),
      ),
      child: Row(children: [
        // ── Logo (Turing College–style wordmark) ────────────
        GestureDetector(
          onTap: () => context.go('/'),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            // "P" logomark — clean, minimal
            Container(
              width: 30, height: 30,
              decoration: BoxDecoration(
                color: isDark ? Colors.white : const Color(0xFF0C0C10),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text(
                'P',
                style: GoogleFonts.syne(
                  fontSize: 16, fontWeight: FontWeight.w900,
                  color: isDark ? const Color(0xFF0C0C10) : Colors.white,
                ),
              )),
            ),
            const SizedBox(width: 9),
            // Wordmark
            RichText(text: TextSpan(children: [
              TextSpan(
                text: 'Praktix',
                style: GoogleFonts.syne(
                  fontSize: 16, fontWeight: FontWeight.w800, color: textP,
                ),
              ),
              TextSpan(
                text: ' Uni',
                style: GoogleFonts.syne(
                  fontSize: 13, fontWeight: FontWeight.w400,
                  color: textS,
                ),
              ),
            ])),
          ]),
        ),

        const Spacer(),

        // ── Theme toggle (small, unobtrusive) ──────────────
        GestureDetector(
          onTap: () => ref.read(themeProvider.notifier).toggle(),
          child: Container(
            width: 30, height: 30,
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: border),
            ),
            child: Center(child: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              size: 14,
              color: textS,
            )),
          ),
        ),

        const SizedBox(width: 8),

        // ── "Log in" text button (Turing College style) ─────
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: textS,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text('Log in', style: GoogleFonts.syne(
            fontSize: 12, fontWeight: FontWeight.w600,
            color: textS,
          )),
        ),

        const SizedBox(width: 4),

        // ── "Apply now" CTA (dark button, both sites) ───────
        GestureDetector(
          onTap: () => context.go('/apply'),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: isDark ? Colors.white : const Color(0xFF0C0C10),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Text('Apply', style: GoogleFonts.syne(
                fontSize: 12, fontWeight: FontWeight.w700,
                color: isDark ? const Color(0xFF0C0C10) : Colors.white,
              )),
              const SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_rounded, size: 12,
                color: isDark ? const Color(0xFF0C0C10) : Colors.white,
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}

// ── Bottom nav (website tab style) ────────────────────────────────
class _BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final bool isDark;
  final String location;
  const _BottomNavBar({
    required this.selectedIndex,
    required this.isDark,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final bg     = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final border = isDark ? AppColors.borderDark  : AppColors.borderLight;

    final items = [
      (Icons.home_outlined,   Icons.home_rounded,   'Home',     '/'),
      (Icons.school_outlined, Icons.school_rounded, 'Programs', '/programs'),
      (Icons.edit_note_rounded, Icons.edit_rounded, 'Apply',    '/apply'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: bg,
        border: Border(top: BorderSide(color: border, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: items.asMap().entries.map((e) {
              final i    = e.key;
              final item = e.value;
              final isActive = selectedIndex == i;

              final activeColor   = isDark ? Colors.white         : const Color(0xFF0C0C10);
              final inactiveColor = isDark ? AppColors.textHintDark : const Color(0xFFAAADB8);

              return Expanded(
                child: GestureDetector(
                  onTap: () => context.go(item.$4),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    children: [
                      // ── Active indicator: top line (Turing College style)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                        height: 2,
                        width: double.infinity,
                        color: isActive
                            ? (isDark ? Colors.white : const Color(0xFF0C0C10))
                            : Colors.transparent,
                      ),
                      const SizedBox(height: 8),
                      // ── Icon
                      Icon(
                        isActive ? item.$2 : item.$1,
                        size: 20,
                        color: isActive ? activeColor : inactiveColor,
                      ),
                      const SizedBox(height: 3),
                      // ── Label
                      Text(
                        item.$3,
                        style: GoogleFonts.syne(
                          fontSize: 10,
                          fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                          color: isActive ? activeColor : inactiveColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
