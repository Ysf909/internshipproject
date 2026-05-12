import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/program_model.dart';
import '../../data/repositories/program_repository.dart';

// ── State ─────────────────────────────────────────────────────────────────────
class ProgramsState {
  final List<Program> allPrograms;
  final List<Program> filteredPrograms;
  final List<String> categories;
  final String selectedCategory;
  final String searchQuery;
  final String selectedType; // 'all' | 'course' | 'degree'
  final bool isLoading;
  final String? error;

  const ProgramsState({
    this.allPrograms = const [],
    this.filteredPrograms = const [],
    this.categories = const ['All'],
    this.selectedCategory = 'All',
    this.searchQuery = '',
    this.selectedType = 'all',
    this.isLoading = true,
    this.error,
  });

  ProgramsState copyWith({
    List<Program>? allPrograms,
    List<Program>? filteredPrograms,
    List<String>? categories,
    String? selectedCategory,
    String? searchQuery,
    String? selectedType,
    bool? isLoading,
    String? error,
  }) => ProgramsState(
    allPrograms: allPrograms ?? this.allPrograms,
    filteredPrograms: filteredPrograms ?? this.filteredPrograms,
    categories: categories ?? this.categories,
    selectedCategory: selectedCategory ?? this.selectedCategory,
    searchQuery: searchQuery ?? this.searchQuery,
    selectedType: selectedType ?? this.selectedType,
    isLoading: isLoading ?? this.isLoading,
    error: error,
  );
}

// ── ViewModel ─────────────────────────────────────────────────────────────────
class ProgramsViewModel extends StateNotifier<ProgramsState> {
  final ProgramRepository _repo;

  ProgramsViewModel(this._repo) : super(const ProgramsState()) {
    loadPrograms();
  }

  Future<void> loadPrograms() async {
    state = state.copyWith(isLoading: true);
    try {
      final programs = await _repo.getAllPrograms();
      final categories = _repo.getCategories();
      state = state.copyWith(
        allPrograms: programs,
        filteredPrograms: programs,
        categories: categories,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void onSearchChanged(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFilters();
  }

  void onCategorySelected(String category) {
    state = state.copyWith(selectedCategory: category);
    _applyFilters();
  }

  void onTypeSelected(String type) {
    state = state.copyWith(selectedType: type);
    _applyFilters();
  }

  void resetFilters() {
    state = state.copyWith(
      searchQuery: '',
      selectedCategory: 'All',
      selectedType: 'all',
      filteredPrograms: state.allPrograms,
    );
  }

  void _applyFilters() {
    var result = state.allPrograms;

    if (state.selectedType != 'all') {
      result = result.where((p) => p.programType == state.selectedType).toList();
    }

    if (state.selectedCategory != 'All') {
      result = result.where((p) => p.category == state.selectedCategory).toList();
    }

    if (state.searchQuery.trim().isNotEmpty) {
      final q = state.searchQuery.toLowerCase();
      result = result
          .where((p) =>
              p.title.toLowerCase().contains(q) ||
              p.category.toLowerCase().contains(q) ||
              p.tags.any((t) => t.toLowerCase().contains(q)))
          .toList();
    }

    state = state.copyWith(filteredPrograms: result);
  }
}

// ── Provider ──────────────────────────────────────────────────────────────────
final programsViewModelProvider =
    StateNotifierProvider.autoDispose<ProgramsViewModel, ProgramsState>((ref) {
  return ProgramsViewModel(ProgramRepository());
});
