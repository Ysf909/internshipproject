import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../presentation/viewmodels/programs_view_model.dart';
import '../../widgets/program_card.dart';

class ProgramsScreen extends ConsumerWidget {
  const ProgramsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(programsViewModelProvider);
    final vm    = ref.read(programsViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: Column(children: [
        // ── Header (clean, website-style) ─────────────────────
        Container(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                decoration: BoxDecoration(
                  color: (isDark ? AppColors.primaryLight : AppColors.primary).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text('PROGRAMS', style: GoogleFonts.syne(
                  fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 1.8,
                  color: isDark ? AppColors.primaryLight : AppColors.primary,
                )),
              ),
            ]),
            const SizedBox(height: 8),
            Text('Find your next chapter.', style: GoogleFonts.merriweather(
              fontSize: 22, fontWeight: FontWeight.w700,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            )),
            const SizedBox(height: 2),
            Text('9 programs — from 6-week courses to accredited degrees.',
              style: GoogleFonts.dmSans(fontSize: 13,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
          ]),
        ),

        // ── Type Toggle ──────────────────────────────────────
        Container(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
            ),
            child: Row(children: [
              for (final t in [
                ('all', 'All Programs', null),
                ('course', 'Courses', Icons.bolt_rounded),
                ('degree', 'Degrees', Icons.school_rounded),
              ])
                Expanded(child: GestureDetector(
                  onTap: () => vm.onTypeSelected(t.$1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    decoration: BoxDecoration(
                      color: state.selectedType == t.$1
                          ? (t.$1 == 'degree'
                              ? AppColors.impact
                              : (isDark ? AppColors.primaryLight.withOpacity(0.2) : AppColors.primary))
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      if (t.$3 != null) ...[
                        Icon(t.$3, size: 13, color: state.selectedType == t.$1
                          ? Colors.white
                          : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
                        const SizedBox(width: 4),
                      ],
                      Text(t.$2, style: GoogleFonts.syne(
                        fontSize: 11, fontWeight: FontWeight.w700,
                        color: state.selectedType == t.$1
                            ? Colors.white
                            : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                      )),
                    ]),
                  ),
                )),
            ]),
          ),
        ),

        // ── Search + Filters ─────────────────────────────────
        Container(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
          child: Column(children: [
            // Search
            TextField(
              onChanged: vm.onSearchChanged,
              style: GoogleFonts.dmSans(fontSize: 14, color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
              decoration: InputDecoration(
                hintText: 'Search programs…',
                hintStyle: GoogleFonts.dmSans(fontSize: 13,
                    color: isDark ? AppColors.textHintDark : AppColors.textHintLight),
                prefixIcon: Icon(Icons.search_rounded, size: 20,
                    color: isDark ? AppColors.textHintDark : AppColors.textHintLight),
                suffixIcon: state.searchQuery.isNotEmpty
                    ? IconButton(icon: const Icon(Icons.close_rounded, size: 17),
                        onPressed: () => vm.onSearchChanged(''))
                    : null,
                filled: true,
                fillColor: isDark ? AppColors.cardDark : AppColors.backgroundLight,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: isDark ? AppColors.primaryLight : AppColors.primary, width: 2)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ).animate().fadeIn(duration: 300.ms),
            const SizedBox(height: 10),
            // Category chips
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: state.categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final cat = state.categories[i];
                  final isSelected = state.selectedCategory == cat;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (isDark ? AppColors.primaryLight.withOpacity(0.15) : AppColors.primary.withOpacity(0.1))
                          : (isDark ? AppColors.cardDark : AppColors.backgroundLight),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? (isDark ? AppColors.primaryLight : AppColors.primary)
                            : (isDark ? AppColors.borderDark : AppColors.borderLight),
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () => vm.onCategorySelected(cat),
                      child: Text(cat, style: GoogleFonts.syne(
                        fontSize: 11, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? (isDark ? AppColors.primaryLight : AppColors.primary)
                            : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                      )),
                    ),
                  );
                },
              ),
            ),
          ]),
        ),
        Container(height: 1, color: isDark ? AppColors.borderDark : AppColors.borderLight),

        // ── Grid ─────────────────────────────────────────────
        Expanded(
          child: state.isLoading
              ? Center(child: CircularProgressIndicator(color: AppColors.primary))
              : state.filteredPrograms.isEmpty
                  ? _EmptyState(onReset: vm.resetFilters)
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1, mainAxisSpacing: 14, childAspectRatio: 1.1,
                      ),
                      itemCount: state.filteredPrograms.length,
                      itemBuilder: (context, i) => ProgramCard(
                        program: state.filteredPrograms[i], animationIndex: i,
                      ),
                    ),
        ),
      ]),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onReset;
  const _EmptyState({required this.onReset});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 72, height: 72, decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
      ), child: Icon(Icons.search_off_rounded, size: 36,
          color: isDark ? AppColors.textHintDark : AppColors.textHintLight)),
      const SizedBox(height: 16),
      Text('No programs found', style: GoogleFonts.syne(fontSize: 17, fontWeight: FontWeight.w700,
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
      const SizedBox(height: 6),
      Text('Try a different search or category', style: GoogleFonts.dmSans(fontSize: 13,
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
      const SizedBox(height: 20),
      TextButton(onPressed: onReset,
        style: TextButton.styleFrom(foregroundColor: AppColors.primary),
        child: Text('Clear filters', style: GoogleFonts.syne(fontWeight: FontWeight.w700))),
    ]));
  }
}
