import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../data/models/program_model.dart';
import '../../data/repositories/program_repository.dart';

// ── Submit Status ─────────────────────────────────────────────────────────────
enum SubmitStatus { idle, loading, success, error }

// ── State ─────────────────────────────────────────────────────────────────────
class ApplyState {
  final List<Program> programs;
  final String? selectedProgramId;
  final SubmitStatus submitStatus;
  final String? errorMessage;
  final bool isProgramsLoading;

  const ApplyState({
    this.programs = const [],
    this.selectedProgramId,
    this.submitStatus = SubmitStatus.idle,
    this.errorMessage,
    this.isProgramsLoading = true,
  });

  Program? get selectedProgram {
    try {
      return programs.firstWhere((p) => p.id == selectedProgramId);
    } catch (_) {
      return null;
    }
  }

  ApplyState copyWith({
    List<Program>? programs,
    String? selectedProgramId,
    SubmitStatus? submitStatus,
    String? errorMessage,
    bool? isProgramsLoading,
    bool clearProgram = false,
  }) =>
      ApplyState(
        programs: programs ?? this.programs,
        selectedProgramId:
            clearProgram ? null : (selectedProgramId ?? this.selectedProgramId),
        submitStatus: submitStatus ?? this.submitStatus,
        errorMessage: errorMessage,
        isProgramsLoading: isProgramsLoading ?? this.isProgramsLoading,
      );
}

// ── ViewModel ─────────────────────────────────────────────────────────────────
class ApplyViewModel extends StateNotifier<ApplyState> {
  final ProgramRepository _repo;

  ApplyViewModel(this._repo, String? preselectedProgramId)
      : super(ApplyState(selectedProgramId: preselectedProgramId)) {
    _loadPrograms();
  }

  Future<void> _loadPrograms() async {
    try {
      final programs = await _repo.getAllPrograms();
      state = state.copyWith(programs: programs, isProgramsLoading: false);
    } catch (e) {
      state = state.copyWith(isProgramsLoading: false);
    }
  }

  void selectProgram(String id) {
    state = state.copyWith(selectedProgramId: id);
  }

  Future<bool> submitApplication({
    required String name,
    required String email,
    required String phone,
  }) async {
    if (state.selectedProgramId == null) return false;

    state = state.copyWith(submitStatus: SubmitStatus.loading);

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // Persist locally
      final prefs = await SharedPreferences.getInstance();
      final existing = prefs.getStringList('applications') ?? [];
      existing.add(jsonEncode({
        'name': name,
        'email': email,
        'phone': phone,
        'programId': state.selectedProgramId,
        'programTitle': state.selectedProgram?.title ?? '',
        'submittedAt': DateTime.now().toIso8601String(),
      }));
      await prefs.setStringList('applications', existing);

      state = state.copyWith(submitStatus: SubmitStatus.success);
      return true;
    } catch (e) {
      state = state.copyWith(
        submitStatus: SubmitStatus.error,
        errorMessage: 'Submission failed. Please try again.',
      );
      return false;
    }
  }

  void reset() {
    state = state.copyWith(
      submitStatus: SubmitStatus.idle,
      errorMessage: null,
      clearProgram: true,
    );
  }
}

// ── Provider ──────────────────────────────────────────────────────────────────
final applyViewModelProvider = StateNotifierProvider.autoDispose
    .family<ApplyViewModel, ApplyState, String?>((ref, preselectedId) {
  return ApplyViewModel(ProgramRepository(), preselectedId);
});
