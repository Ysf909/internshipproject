import '../models/expert_model.dart';
import '../models/program_model.dart';
import '../mock/mock_data.dart';

class ExpertRepository {
  Future<List<Expert>> getAllExperts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockData.experts;
  }

  Future<Expert?> getExpertById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return MockData.findExpertById(id);
  }

  Future<List<Program>> getProgramsByExpert(String expertId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return MockData.programsByExpert(expertId);
  }
}
