import '../../data/models/raw_finalcial.data.dart';

abstract class FinancialReportRepository {
  Future<RawFinancialData> analyzeReport(String filePath);
  Future<List<RawFinancialData>> getHistory();
}
