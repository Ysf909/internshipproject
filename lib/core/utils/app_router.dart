import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/programs/programs_screen.dart';
import '../../presentation/screens/programs/program_detail_screen.dart';
import '../../presentation/screens/experts/expert_profile_screen.dart';
import '../../presentation/screens/apply/apply_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
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

    // ── Full-screen routes (outside shell) ──────────────────
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

class _ScaffoldWithNav extends StatelessWidget {
  final Widget child;
  final String location;

  const _ScaffoldWithNav({required this.child, required this.location});

  int get _selectedIndex {
    if (location.startsWith('/programs')) return 1;
    if (location.startsWith('/apply')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          border: Border(
            top: BorderSide(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 60,
            child: Row(
              children: [
                _NavItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home_rounded,
                  label: 'Home',
                  isActive: _selectedIndex == 0,
                  onTap: () => context.go('/'),
                  isDark: isDark,
                ),
                _NavItem(
                  icon: Icons.menu_book_outlined,
                  activeIcon: Icons.menu_book_rounded,
                  label: 'Degrees',
                  isActive: _selectedIndex == 1,
                  onTap: () => context.go('/programs'),
                  isDark: isDark,
                ),
                _NavItem(
                  icon: Icons.how_to_reg_outlined,
                  activeIcon: Icons.how_to_reg_rounded,
                  label: 'Admissions',
                  isActive: _selectedIndex == 2,
                  onTap: () => context.go('/apply'),
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final bool isDark;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = isDark ? AppColors.primaryLight : AppColors.primary;
    final inactiveColor =
        isDark ? AppColors.textHintDark : AppColors.textHintLight;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isActive ? activeIcon : icon,
                size: 22,
                color: isActive ? activeColor : inactiveColor,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight:
                      isActive ? FontWeight.w600 : FontWeight.w400,
                  color: isActive ? activeColor : inactiveColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
