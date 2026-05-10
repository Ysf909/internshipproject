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
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _submit(ApplyViewModel vm, ApplyState state) {
    if (!_formKey.currentState!.validate()) return;
    if (state.selectedProgramId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a program to apply for')));
      return;
    }
    vm.submitApplication(name: _nameCtrl.text.trim(), email: _emailCtrl.text.trim(), phone: _phoneCtrl.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(applyViewModelProvider(widget.preselectedProgramId));
    final vm = ref.read(applyViewModelProvider(widget.preselectedProgramId).notifier);

    if (state.submitStatus == SubmitStatus.success) {
      return Scaffold(
        backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        body: _SuccessView(onDone: () { vm.reset(); context.go('/'); }),
      );
    }

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text('Admissions', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 20, color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => context.canPop() ? context.pop() : context.go('/'),
          child: const Icon(Icons.arrow_back_rounded),
        ),
        bottom: PreferredSize(preferredSize: const Size.fromHeight(1), child: Divider(height: 1, color: isDark ? AppColors.borderDark : AppColors.borderLight)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Hero Banner
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(gradient: AppColors.heroGradient, borderRadius: BorderRadius.circular(16)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Container(width: 42, height: 42, decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.school_rounded, color: Colors.white, size: 22)),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Apply to Praktix University', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                    Text('September 2025 Cohort · Rolling Admissions', style: GoogleFonts.inter(fontSize: 12, color: Colors.white.withOpacity(0.8))),
                  ])),
                ]),
                const SizedBox(height: 14),
                Row(children: [
                  _AdmissionBadge(Icons.timer_outlined, '24h Response'),
                  const SizedBox(width: 8),
                  _AdmissionBadge(Icons.attach_money_rounded, 'Free to Apply'),
                  const SizedBox(width: 8),
                  _AdmissionBadge(Icons.groups_outlined, 'Top 10% Cohort'),
                ]),
              ]),
            ).animate().fadeIn(duration: 400.ms),

            const SizedBox(height: 20),

            // Admission steps
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: isDark ? AppColors.cardDark : AppColors.cardLight, borderRadius: BorderRadius.circular(14), border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('How Admissions Works', style: AppTextStyles.labelLarge(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
                const SizedBox(height: 12),
                _AdmissionStep('1', 'Submit Application', 'Fill this form — free, no essays required', isDark),
                _AdmissionStep('2', 'Assessment', 'Short online assessment to match you to the right cohort', isDark),
                _AdmissionStep('3', 'Admission Decision', 'Receive your offer within 48 hours', isDark),
                _AdmissionStep('4', 'Enrol', 'Confirm your place and start your sprint journey', isDark),
              ]),
            ).animate(delay: 50.ms).fadeIn(),

            const SizedBox(height: 28),
            Text('Your Information', style: AppTextStyles.headingSmall(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)).animate(delay: 80.ms).fadeIn(),
            const SizedBox(height: 6),
            Text('We only admit the top 10% of candidates. Tell us about yourself.', style: AppTextStyles.bodySmall(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)).animate(delay: 80.ms).fadeIn(),
            const SizedBox(height: 14),
            CustomTextField(label: 'Full Name', hint: 'e.g. Youssef Al-Hassan', controller: _nameCtrl, validator: Validators.name, prefixIcon: Icons.person_outline_rounded).animate(delay: 100.ms).fadeIn().slideY(begin: 0.1, end: 0),
            const SizedBox(height: 14),
            CustomTextField(label: 'Email Address', hint: 'e.g. youssef@example.com', controller: _emailCtrl, validator: Validators.email, keyboardType: TextInputType.emailAddress, prefixIcon: Icons.email_outlined).animate(delay: 120.ms).fadeIn().slideY(begin: 0.1, end: 0),
            const SizedBox(height: 14),
            CustomTextField(label: 'Phone Number', hint: 'e.g. +1 234 567 8900', controller: _phoneCtrl, validator: Validators.phone, keyboardType: TextInputType.phone, prefixIcon: Icons.phone_outlined).animate(delay: 140.ms).fadeIn().slideY(begin: 0.1, end: 0),

            const SizedBox(height: 24),
            Divider(color: isDark ? AppColors.borderDark : AppColors.borderLight),
            const SizedBox(height: 20),

            Text('Choose Your Program', style: AppTextStyles.headingSmall(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)).animate(delay: 160.ms).fadeIn(),
            const SizedBox(height: 6),
            Text('Select the degree or certificate you want to apply for.', style: AppTextStyles.bodySmall(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)).animate(delay: 160.ms).fadeIn(),
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
                    color: state.selectedProgramId == e.value.id ? AppColors.primary.withOpacity(0.08) : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: state.selectedProgramId == e.value.id ? AppColors.primary.withOpacity(0.5) : (isDark ? AppColors.borderDark : AppColors.borderLight), width: state.selectedProgramId == e.value.id ? 1.5 : 1),
                  ),
                  child: Row(children: [
                    Container(
                      width: 20, height: 20,
                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: state.selectedProgramId == e.value.id ? AppColors.primary : AppColors.textHintLight, width: 2)),
                      child: state.selectedProgramId == e.value.id ? Center(child: Container(width: 10, height: 10, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary))) : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(e.value.title, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: state.selectedProgramId == e.value.id ? (isDark ? AppColors.primaryLight : AppColors.primary) : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight), fontFamily: 'Inter')),
                      const SizedBox(height: 2),
                      Text('${e.value.category} · ${e.value.duration} · ${e.value.formattedPrice}', style: TextStyle(fontSize: 12, color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight, fontFamily: 'Inter')),
                    ])),
                    if (state.selectedProgramId == e.value.id)
                      const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 18),
                  ]),
                ),
              ).animate(delay: Duration(milliseconds: 160 + e.key * 50)).fadeIn(duration: 300.ms)),

            const SizedBox(height: 28),

            if (state.submitStatus == SubmitStatus.error)
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColors.error.withOpacity(0.1), borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.error.withOpacity(0.3))),
                child: Row(children: [
                  const Icon(Icons.error_outline_rounded, color: AppColors.error, size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Text(state.errorMessage ?? 'An error occurred', style: const TextStyle(color: AppColors.error, fontSize: 13, fontFamily: 'Inter'))),
                ]),
              ).animate().fadeIn().shake(),

            CustomButton(label: 'Submit Application', icon: Icons.send_rounded, isLoading: state.submitStatus == SubmitStatus.loading, onPressed: () => _submit(vm, state)).animate(delay: 200.ms).fadeIn().slideY(begin: 0.1, end: 0),

            const SizedBox(height: 12),
            Center(child: Text("Free to apply · 7-day money-back guarantee on enrolment", style: AppTextStyles.bodySmall(color: isDark ? AppColors.textHintDark : AppColors.textHintLight), textAlign: TextAlign.center)),
            const SizedBox(height: 32),
          ]),
        ),
      ),
    );
  }
}

class _AdmissionBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  const _AdmissionBadge(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 12, color: Colors.white),
        const SizedBox(width: 4),
        Text(label, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.white)),
      ]),
    );
  }
}

class _AdmissionStep extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;
  final bool isDark;
  const _AdmissionStep(this.number, this.title, this.subtitle, this.isDark);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 22, height: 22,
          decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
          child: Center(child: Text(number, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary))),
        ),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)),
          Text(subtitle, style: GoogleFonts.inter(fontSize: 11.5, color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight, height: 1.4)),
        ])),
      ]),
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
        Container(width: 100, height: 100, decoration: BoxDecoration(color: AppColors.secondary.withOpacity(0.12), shape: BoxShape.circle), child: const Icon(Icons.school_rounded, size: 52, color: AppColors.secondary)).animate().scale(begin: const Offset(0, 0), end: const Offset(1, 1), duration: 500.ms, curve: Curves.elasticOut),
        const SizedBox(height: 24),
        Text('Application Submitted!', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight), textAlign: TextAlign.center).animate(delay: 200.ms).fadeIn().slideY(begin: 0.1, end: 0),
        const SizedBox(height: 10),
        Text("Welcome to the Praktix community. Our admissions team will review your application and reach out within 24 hours. Your journey to an impactful career starts here.", style: GoogleFonts.inter(fontSize: 14, color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight, height: 1.6), textAlign: TextAlign.center).animate(delay: 250.ms).fadeIn(),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppColors.secondary.withOpacity(0.08), borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.secondary.withOpacity(0.2))),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _SuccessStat('97.9%', 'Job Placement'),
            _SuccessStat('10K+', 'Alumni'),
            _SuccessStat('24h', 'Response'),
          ]),
        ).animate(delay: 300.ms).fadeIn(),
        const SizedBox(height: 36),
        CustomButton(label: 'Explore Programs', icon: Icons.school_rounded, onPressed: onDone).animate(delay: 350.ms).fadeIn().slideY(begin: 0.1, end: 0),
      ]),
    );
  }
}

class _SuccessStat extends StatelessWidget {
  final String value;
  final String label;
  const _SuccessStat(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(value, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.secondary)),
      Text(label, style: GoogleFonts.inter(fontSize: 11, color: AppColors.secondary.withOpacity(0.8))),
    ]);
  }
}
