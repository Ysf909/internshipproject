import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/program_model.dart';
import '../../data/models/expert_model.dart';
import '../../data/repositories/program_repository.dart';
import '../../data/repositories/expert_repository.dart';

// ── State ─────────────────────────────────────────────────────────────────────
class HomeState {
  final List<Program> featuredPrograms;
  final List<Expert> experts;
  final bool isLoading;
  final String? error;

  const HomeState({
    this.featuredPrograms = const [],
    this.experts = const [],
    this.isLoading = true,
    this.error,
  });

  HomeState copyWith({
    List<Program>? featuredPrograms,
    List<Expert>? experts,
    bool? isLoading,
    String? error,
  }) =>
      HomeState(
        featuredPrograms: featuredPrograms ?? this.featuredPrograms,
        experts: experts ?? this.experts,
        isLoading: isLoading ?? this.isLoading,
        error: error,
      );
}

// ── ViewModel ─────────────────────────────────────────────────────────────────
class HomeViewModel extends StateNotifier<HomeState> {
  final ProgramRepository _programRepo;
  final ExpertRepository _expertRepo;

  HomeViewModel(this._programRepo, this._expertRepo) : super(const HomeState()) {
    loadData();
  }

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      final results = await Future.wait([
        _programRepo.getFeaturedPrograms(),
        _expertRepo.getAllExperts(),
      ]);
      state = state.copyWith(
        featuredPrograms: results[0] as List<Program>,
        experts: results[1] as List<Expert>,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> refresh() => loadData();
}

// ── Provider ──────────────────────────────────────────────────────────────────
final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeState>((ref) {
  return HomeViewModel(
    ProgramRepository(),
    ExpertRepository(),
  );
});
