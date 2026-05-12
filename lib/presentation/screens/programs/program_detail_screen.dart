import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../presentation/viewmodels/program_detail_view_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/expert_card.dart';

class ProgramDetailScreen extends ConsumerWidget {
  final String programId;
  const ProgramDetailScreen({super.key, required this.programId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state  = ref.watch(programDetailViewModelProvider(programId));
    if (state.isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (state.error != null) return Scaffold(body: Center(child: Text('Error: ${state.error}')));
    final program = state.program!;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: Stack(children: [
        CustomScrollView(slivers: [
          SliverAppBar(
            expandedHeight: 270, pinned: true,
            backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            leading: GestureDetector(
              onTap: () => context.pop(),
              child: Container(margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.arrow_back_rounded, color: Colors.white)),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(fit: StackFit.expand, children: [
                Image.network(program.imageUrl, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(decoration: const BoxDecoration(gradient: AppColors.cardGradient))),
                Container(decoration: BoxDecoration(gradient: LinearGradient(
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ))),
                Positioned(bottom: 16, left: 16, right: 16, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: AppColors.categoryColor(program.category), borderRadius: BorderRadius.circular(20)),
                    child: Text(program.category, style: GoogleFonts.syne(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white))),
                  const SizedBox(height: 6),
                  Text(program.title, style: GoogleFonts.merriweather(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                ])),
              ]),
            ),
          ),
          SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                _InfoChip(icon: Icons.access_time_rounded, label: program.duration, isDark: isDark),
                const SizedBox(width: 8),
                _InfoChip(icon: Icons.bar_chart_rounded, label: program.level, isDark: isDark),
                const SizedBox(width: 8),
                _InfoChip(icon: Icons.calendar_today_rounded, label: program.startDate, isDark: isDark),
              ]).animate().fadeIn(duration: 400.ms),
              const SizedBox(height: 14),
              Row(children: [
                ...List.generate(5, (i) => Icon(i < program.rating.floor() ? Icons.star_rounded : Icons.star_border_rounded,
                    size: 16, color: AppColors.accent)),
                const SizedBox(width: 8),
                Text('${program.rating}', style: GoogleFonts.syne(fontSize: 14, fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
                const SizedBox(width: 6),
                Text('(${program.totalStudents} students)', style: AppTextStyles.bodySmall(
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
              ]).animate(delay: 50.ms).fadeIn(),
              const SizedBox(height: 22),
              Divider(color: isDark ? AppColors.borderDark : AppColors.borderLight),
              const SizedBox(height: 18),
              Text('About This Program', style: AppTextStyles.headingMedium(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
              const SizedBox(height: 10),
              Text(program.description, style: AppTextStyles.bodyLarge(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight))
                  .animate(delay: 100.ms).fadeIn(),
              const SizedBox(height: 22),
              Divider(color: isDark ? AppColors.borderDark : AppColors.borderLight),
              const SizedBox(height: 18),
              Text("What You'll Learn", style: AppTextStyles.headingMedium(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
              const SizedBox(height: 12),
              ...program.outcomes.asMap().entries.map((e) => _OutcomeItem(text: e.value, index: e.key, isDark: isDark)),
              const SizedBox(height: 22),
              Divider(color: isDark ? AppColors.borderDark : AppColors.borderLight),
              const SizedBox(height: 18),
              Text('Topics Covered', style: AppTextStyles.headingMedium(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
              const SizedBox(height: 10),
              Wrap(spacing: 8, runSpacing: 8, children: program.tags.map((t) => _TagChip(tag: t, isDark: isDark)).toList()),
              const SizedBox(height: 22),
              Divider(color: isDark ? AppColors.borderDark : AppColors.borderLight),
              const SizedBox(height: 18),
              Text('Your Instructor', style: AppTextStyles.headingMedium(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
              const SizedBox(height: 12),
              if (state.expert != null) ExpertCard(expert: state.expert!, isCompact: true),
              const SizedBox(height: 100),
            ]),
          )),
        ]),
        // Sticky bottom CTA
        Positioned(bottom: 0, left: 0, right: 0, child: Container(
          padding: EdgeInsets.fromLTRB(20, 12, 20, MediaQuery.of(context).padding.bottom + 12),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            border: Border(top: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 16, offset: const Offset(0, -4))],
          ),
          child: Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              ShaderMask(
                shaderCallback: (b) => AppColors.cardGradient.createShader(b),
                child: Text(program.formattedPrice, style: GoogleFonts.syne(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
              ),
              Text(program.duration, style: AppTextStyles.bodySmall(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
            ]),
            const SizedBox(width: 16),
            Expanded(child: CustomButton(label: 'Apply Now', icon: Icons.arrow_forward_rounded,
                onPressed: () => context.go('/apply?programId=${program.id}'))),
          ]),
        ).animate().slideY(begin: 0.5, end: 0, duration: 400.ms)),
      ]),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon; final String label; final bool isDark;
  const _InfoChip({required this.icon, required this.label, required this.isDark});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(10)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 12, color: isDark ? AppColors.primaryLight : AppColors.primary),
      const SizedBox(width: 5),
      Text(label, style: GoogleFonts.syne(fontSize: 11, fontWeight: FontWeight.w600,
          color: isDark ? AppColors.primaryLight : AppColors.primary)),
    ]),
  );
}

class _OutcomeItem extends StatelessWidget {
  final String text; final int index; final bool isDark;
  const _OutcomeItem({required this.text, required this.index, required this.isDark});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 22, height: 22, margin: const EdgeInsets.only(top: 1),
        decoration: BoxDecoration(color: AppColors.secondary.withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
        child: Icon(Icons.check_rounded, size: 13, color: AppColors.secondary)),
      const SizedBox(width: 10),
      Expanded(child: Text(text, style: AppTextStyles.bodyMedium(
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight))),
    ]),
  ).animate(delay: Duration(milliseconds: index * 55)).fadeIn(duration: 300.ms).slideX(begin: -0.05, end: 0);
}

class _TagChip extends StatelessWidget {
  final String tag; final bool isDark;
  const _TagChip({required this.tag, required this.isDark});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: isDark ? AppColors.surfaceDark : AppColors.backgroundLight,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
    ),
    child: Text(tag, style: GoogleFonts.syne(fontSize: 12, fontWeight: FontWeight.w600,
        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
  );
}
