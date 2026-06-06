import 'package:fin_state_analytical/features/financial_analyzer/data/datasources/financial_local_datasource.dart';
import 'package:fin_state_analytical/features/financial_analyzer/data/datasources/gemini_remote_datasource.dart';
import 'package:fin_state_analytical/features/financial_analyzer/data/models/raw_finalcial.data.dart';
import 'package:fin_state_analytical/features/financial_analyzer/domain/repositories/financial_report_repository.dart';

class FinancialReportRepositoryImpl implements FinancialReportRepository {
  final GeminiRemoteDataSource _remoteDataSource;
  final FinancialLocalDataSource _localDataSource;

  FinancialReportRepositoryImpl({
    required GeminiRemoteDataSource remoteDataSource,
    required FinancialLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<RawFinancialData> analyzeReport(String filePath) async {
    try {
      final rawData = await _remoteDataSource.uploadAndAnalyzePdf(filePath);
      await _localDataSource.cacheFinancialData(rawData);
      return rawData;
    } catch (e) {
      throw Exception('Repository Error: Failed to analyze report - $e');
    }
  }

  @override
  Future<List<RawFinancialData>> getHistory() async {
    try {
      return await _localDataSource.getCachedFinancialData();
    } catch (e) {
      throw Exception('Repository Error: Failed to fetch history - $e');
    }
  }
}
