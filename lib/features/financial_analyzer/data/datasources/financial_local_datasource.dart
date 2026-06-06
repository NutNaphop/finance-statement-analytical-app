import 'package:hive_ce/hive.dart';
import '../models/raw_finalcial.data.dart';

abstract class FinancialLocalDataSource {
  Future<void> cacheFinancialData(RawFinancialData data);
  Future<List<RawFinancialData>> getCachedFinancialData();
}

class FinancialLocalDataSourceImpl implements FinancialLocalDataSource {
  static const String _boxName = 'financial_data_box';

  @override
  Future<void> cacheFinancialData(RawFinancialData data) async {
    try {
      final box = await Hive.openBox<RawFinancialData>(_boxName);

      final key = '${data.companyName}_${data.year}';
      await box.put(key, data);
    } catch (e) {
      throw Exception('Failed to cache financial data to Hive: $e');
    }
  }

  @override
  Future<List<RawFinancialData>> getCachedFinancialData() async {
    try {
      final box = await Hive.openBox<RawFinancialData>(_boxName);

      return box.values.toList();
    } catch (e) {
      throw Exception('Failed to retrieve financial data from Hive: $e');
    }
  }
}
