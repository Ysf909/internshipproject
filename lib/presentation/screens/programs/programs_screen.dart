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
    // ── View talks only to its ViewModel ──────────────────
    final state = ref.watch(programsViewModelProvider);
    final vm = ref.read(programsViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text('Programs', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 20, color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        elevation: 0,
        bottom: PreferredSize(preferredSize: const Size.fromHeight(1), child: Divider(height: 1, color: isDark ? AppColors.borderDark : AppColors.borderLight)),
      ),
      body: Column(children: [
        // ── Search Bar ─────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: TextField(
            onChanged: vm.onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search programs...',
              hintStyle: GoogleFonts.inter(color: isDark ? AppColors.textHintDark : AppColors.textHintLight, fontSize: 14),
              prefixIcon: Icon(Icons.search_rounded, color: isDark ? AppColors.textHintDark : AppColors.textHintLight),
              suffixIcon: state.searchQuery.isNotEmpty
                  ? IconButton(icon: const Icon(Icons.close_rounded, size: 18), onPressed: () => vm.onSearchChanged(''))
                  : null,
              filled: true,
              fillColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isDark ? AppColors.primaryLight : AppColors.primary, width: 2)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ).animate().fadeIn(duration: 300.ms),
        ),

        // ── Category Chips ─────────────────────────────────
        SizedBox(
          height: 54,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            itemCount: state.categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final cat = state.categories[i];
              final isSelected = state.selectedCategory == cat;
              return FilterChip(
                label: Text(cat, style: GoogleFonts.inter(fontSize: 13, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400, color: isSelected ? (isDark ? AppColors.primaryLight : AppColors.primary) : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight))),
                selected: isSelected,
                onSelected: (_) => vm.onCategorySelected(cat),
                backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                selectedColor: isDark ? AppColors.primaryLight.withOpacity(0.15) : AppColors.primary.withOpacity(0.1),
                side: BorderSide(color: isSelected ? (isDark ? AppColors.primaryLight : AppColors.primary) : (isDark ? AppColors.borderDark : AppColors.borderLight), width: isSelected ? 1.5 : 1),
                checkmarkColor: isDark ? AppColors.primaryLight : AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 4),
              );
            },
          ),
        ),

        // ── Program List ───────────────────────────────────
        Expanded(
          child: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.filteredPrograms.isEmpty
                  ? _EmptyState(onReset: vm.resetFilters)
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, mainAxisSpacing: 14, childAspectRatio: 1.35),
                      itemCount: state.filteredPrograms.length,
                      itemBuilder: (context, i) => ProgramCard(program: state.filteredPrograms[i], animationIndex: i),
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
      Icon(Icons.search_off_rounded, size: 64, color: isDark ? AppColors.textHintDark : AppColors.textHintLight),
      const SizedBox(height: 16),
      Text('No programs found', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
      const SizedBox(height: 6),
      Text('Try a different search or category', style: GoogleFonts.inter(fontSize: 14, color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
      const SizedBox(height: 20),
      TextButton(onPressed: onReset, child: const Text('Clear filters')),
    ]));
  }
}
