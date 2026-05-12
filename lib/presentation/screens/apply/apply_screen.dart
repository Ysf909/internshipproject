import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/validators.dart';
import '../../../presentation/viewmodels/apply_view_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class ApplyScreen extends ConsumerStatefulWidget {
  final String? preselectedProgramId;
  const ApplyScreen({super.key, this.preselectedProgramId});
  @override
  ConsumerState<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends ConsumerState<ApplyScreen> {
  final _formKey  = GlobalKey<FormState>();
  final _nameCtrl  = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose(); _emailCtrl.dispose(); _phoneCtrl.dispose();
    super.dispose();
  }

  void _submit(ApplyViewModel vm, ApplyState state) {
    if (!_formKey.currentState!.validate()) return;
    if (state.selectedProgramId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a program', style: GoogleFonts.dmSans()),
          backgroundColor: AppColors.error, behavior: SnackBarBehavior.floating),
      );
      return;
    }
    vm.submitApplication(name: _nameCtrl.text.trim(), email: _emailCtrl.text.trim(), phone: _phoneCtrl.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state  = ref.watch(applyViewModelProvider(widget.preselectedProgramId));
    final vm     = ref.read(applyViewModelProvider(widget.preselectedProgramId).notifier);

    if (state.submitStatus == SubmitStatus.success) {
      return Scaffold(
        backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        body: _SuccessView(onDone: () { vm.reset(); context.go('/'); }),
      );
    }

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ── Header (clean, dark — website style) ─────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
            color: isDark ? AppColors.cardDark : const Color(0xFF0C0C10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.impact.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.impactLight.withOpacity(0.3)),
                ),
                child: Text('FREE TO APPLY', style: GoogleFonts.syne(
                  fontSize: 9, fontWeight: FontWeight.w800,
                  color: AppColors.impactLight, letterSpacing: 1.5,
                )),
              ),
              const SizedBox(height: 10),
              Text('Start your journey today.', style: GoogleFonts.merriweather(
                fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white, height: 1.2,
              )),
              const SizedBox(height: 6),
              Text("Fill in the form below — our team responds within 24 hours. No payment required.",
                style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white.withOpacity(0.6), height: 1.55)),
              const SizedBox(height: 14),
              Wrap(spacing: 7, runSpacing: 7, children: [
                '✓ No upfront payment', '✓ Response in 24h', '✓ Flexible start dates',
              ].map((p) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.white.withOpacity(0.15)),
                ),
                child: Text(p, style: GoogleFonts.syne(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.85))),
              )).toList()),
            ]),
          ).animate().fadeIn(duration: 400.ms),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // Personal info
                Text('Personal Information', style: AppTextStyles.headingSmall(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                )).animate(delay: 50.ms).fadeIn(),
                const SizedBox(height: 14),
                CustomTextField(label: 'Full Name', hint: 'e.g. Youssef Al-Hassan',
                    controller: _nameCtrl, validator: Validators.name,
                    prefixIcon: Icons.person_outline_rounded)
                    .animate(delay: 80.ms).fadeIn().slideY(begin: 0.1, end: 0),
                const SizedBox(height: 14),
                CustomTextField(label: 'Email Address', hint: 'e.g. youssef@example.com',
                    controller: _emailCtrl, validator: Validators.email,
                    keyboardType: TextInputType.emailAddress, prefixIcon: Icons.email_outlined)
                    .animate(delay: 110.ms).fadeIn().slideY(begin: 0.1, end: 0),
                const SizedBox(height: 14),
                CustomTextField(label: 'Phone Number', hint: 'e.g. +961 70 000 000',
                    controller: _phoneCtrl, validator: Validators.phone,
                    keyboardType: TextInputType.phone, prefixIcon: Icons.phone_outlined)
                    .animate(delay: 140.ms).fadeIn().slideY(begin: 0.1, end: 0),

                const SizedBox(height: 24),
                Divider(color: isDark ? AppColors.borderDark : AppColors.borderLight),
                const SizedBox(height: 20),

                // Program selection
                Text('Select a Program', style: AppTextStyles.headingSmall(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                )).animate(delay: 160.ms).fadeIn(),
                const SizedBox(height: 14),

                if (state.isProgramsLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  ...state.programs.asMap().entries.map((e) => GestureDetector(
                    onTap: () => vm.selectProgram(e.value.id),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: state.selectedProgramId == e.value.id
                            ? AppColors.primary.withOpacity(0.07)
                            : (isDark ? AppColors.cardDark : AppColors.surfaceLight),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: state.selectedProgramId == e.value.id
                              ? AppColors.primary.withOpacity(0.5)
                              : (isDark ? AppColors.borderDark : AppColors.borderLight),
                          width: state.selectedProgramId == e.value.id ? 1.5 : 1,
                        ),
                      ),
                      child: Row(children: [
                        // Radio dot
                        Container(
                          width: 20, height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: state.selectedProgramId == e.value.id
                                  ? AppColors.primary : AppColors.textHintLight,
                              width: 2,
                            ),
                          ),
                          child: state.selectedProgramId == e.value.id
                              ? Center(child: Container(width: 10, height: 10,
                                  decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary)))
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(e.value.title, style: GoogleFonts.syne(
                            fontSize: 13, fontWeight: FontWeight.w700,
                            color: state.selectedProgramId == e.value.id
                                ? (isDark ? AppColors.primaryLight : AppColors.primary)
                                : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                          )),
                          const SizedBox(height: 2),
                          Text('${e.value.category} · ${e.value.duration} · ${e.value.formattedPrice}',
                            style: GoogleFonts.dmSans(fontSize: 11,
                                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)),
                        ])),
                      ]),
                    ),
                  ).animate(delay: Duration(milliseconds: 160 + e.key * 50)).fadeIn(duration: 300.ms)),

                const SizedBox(height: 28),

                // Error state
                if (state.submitStatus == SubmitStatus.error)
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.error.withOpacity(0.3)),
                    ),
                    child: Row(children: [
                      const Icon(Icons.error_outline_rounded, color: AppColors.error, size: 18),
                      const SizedBox(width: 8),
                      Expanded(child: Text(state.errorMessage ?? 'An error occurred',
                          style: GoogleFonts.dmSans(color: AppColors.error, fontSize: 13))),
                    ]),
                  ).animate().fadeIn().shake(),

                CustomButton(
                  label: 'Submit Application',
                  icon: Icons.send_rounded,
                  isLoading: state.submitStatus == SubmitStatus.loading,
                  onPressed: () => _submit(vm, state),
                ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.1, end: 0),

                const SizedBox(height: 12),
                Center(child: Text("We'll reach out within 24 hours", style: AppTextStyles.bodySmall(
                  color: isDark ? AppColors.textHintDark : AppColors.textHintLight,
                ))),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  final VoidCallback onDone;
  const _SuccessView({required this.onDone});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 96, height: 96,
          decoration: BoxDecoration(
            gradient: AppColors.missionGradient,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: AppColors.secondary.withOpacity(0.3), blurRadius: 24)],
          ),
          child: const Icon(Icons.check_rounded, size: 48, color: Colors.white),
        ).animate().scale(begin: const Offset(0, 0), end: const Offset(1, 1),
            duration: 500.ms, curve: Curves.elasticOut),
        const SizedBox(height: 28),
        Text('Application Submitted!', style: GoogleFonts.merriweather(
          fontSize: 24, fontWeight: FontWeight.w700,
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
        ), textAlign: TextAlign.center).animate(delay: 200.ms).fadeIn().slideY(begin: 0.1, end: 0),
        const SizedBox(height: 12),
        Text("Thank you for applying to Praktix. Our admissions team will review your application and reach out within 24 hours.",
          style: GoogleFonts.dmSans(fontSize: 15,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight, height: 1.65),
          textAlign: TextAlign.center).animate(delay: 250.ms).fadeIn(),
        const SizedBox(height: 36),
        CustomButton(label: 'Back to Home', icon: Icons.home_rounded, onPressed: onDone)
            .animate(delay: 300.ms).fadeIn().slideY(begin: 0.1, end: 0),
      ]),
    );
  }
}
