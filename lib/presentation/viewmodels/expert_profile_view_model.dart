import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/expert_model.dart';
import '../../data/models/program_model.dart';
import '../../data/repositories/expert_repository.dart';

// ── State ─────────────────────────────────────────────────────────────────────
class ExpertProfileState {
  final Expert? expert;
  final List<Program> programs;
  final bool isLoading;
  final String? error;

  const ExpertProfileState({
    this.expert,
    this.programs = const [],
    this.isLoading = true,
    this.error,
  });

  ExpertProfileState copyWith({
    Expert? expert,
    List<Program>? programs,
    bool? isLoading,
    String? error,
  }) =>
      ExpertProfileState(
        expert: expert ?? this.expert,
        programs: programs ?? this.programs,
        isLoading: isLoading ?? this.isLoading,
        error: error,
      );
}

// ── ViewModel ─────────────────────────────────────────────────────────────────
class ExpertProfileViewModel extends StateNotifier<ExpertProfileState> {
  final ExpertRepository _repo;
  final String expertId;

  ExpertProfileViewModel(this._repo, this.expertId)
      : super(const ExpertProfileState()) {
    loadExpert();
  }

  Future<void> loadExpert() async {
    state = state.copyWith(isLoading: true);
    try {
      final results = await Future.wait([
        _repo.getExpertById(expertId),
        _repo.getProgramsByExpert(expertId),
      ]);
      state = state.copyWith(
        expert: results[0] as Expert?,
        programs: results[1] as List<Program>,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

// ── Provider ──────────────────────────────────────────────────────────────────
final expertProfileViewModelProvider = StateNotifierProvider.autoDispose
    .family<ExpertProfileViewModel, ExpertProfileState, String>((ref, id) {
  return ExpertProfileViewModel(ExpertRepository(), id);
});
