import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/program_model.dart';
import '../../data/models/expert_model.dart';
import '../../data/repositories/program_repository.dart';
import '../../data/repositories/expert_repository.dart';

// ── State ─────────────────────────────────────────────────────────────────────
class ProgramDetailState {
  final Program? program;
  final Expert? expert;
  final bool isLoading;
  final String? error;

  const ProgramDetailState({
    this.program,
    this.expert,
    this.isLoading = true,
    this.error,
  });

  ProgramDetailState copyWith({
    Program? program,
    Expert? expert,
    bool? isLoading,
    String? error,
  }) =>
      ProgramDetailState(
        program: program ?? this.program,
        expert: expert ?? this.expert,
        isLoading: isLoading ?? this.isLoading,
        error: error,
      );
}

// ── ViewModel ─────────────────────────────────────────────────────────────────
class ProgramDetailViewModel extends StateNotifier<ProgramDetailState> {
  final ProgramRepository _programRepo;
  final ExpertRepository _expertRepo;
  final String programId;

  ProgramDetailViewModel(
    this._programRepo,
    this._expertRepo,
    this.programId,
  ) : super(const ProgramDetailState()) {
    loadDetail();
  }

  Future<void> loadDetail() async {
    state = state.copyWith(isLoading: true);
    try {
      final program = await _programRepo.getProgramById(programId);
      if (program == null) {
        state = state.copyWith(isLoading: false, error: 'Program not found');
        return;
      }
      final expert = await _expertRepo.getExpertById(program.expertId);
      state = state.copyWith(
        program: program,
        expert: expert,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

// ── Provider ──────────────────────────────────────────────────────────────────
final programDetailViewModelProvider = StateNotifierProvider.autoDispose
    .family<ProgramDetailViewModel, ProgramDetailState, String>((ref, id) {
  return ProgramDetailViewModel(
    ProgramRepository(),
    ExpertRepository(),
    id,
  );
});
