import '../models/program_model.dart';
import '../mock/mock_data.dart';

class ProgramRepository {
  Future<List<Program>> getAllPrograms() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));
    return MockData.programs;
  }

  Future<List<Program>> getFeaturedPrograms() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockData.programs.where((p) => p.isFeatured).toList();
  }

  Future<Program?> getProgramById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return MockData.findProgramById(id);
  }

  Future<List<Program>> getProgramsByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (category == 'All') return MockData.programs;
    return MockData.programs
        .where((p) => p.category == category)
        .toList();
  }

  Future<List<Program>> searchPrograms(String query) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final q = query.toLowerCase();
    return MockData.programs
        .where((p) =>
            p.title.toLowerCase().contains(q) ||
            p.category.toLowerCase().contains(q) ||
            p.tags.any((t) => t.toLowerCase().contains(q)))
        .toList();
  }

  List<String> getCategories() {
    final cats = <String>{'All'};
    for (final p in MockData.programs) {
      cats.add(p.category);
    }
    return cats.toList();
  }
}
