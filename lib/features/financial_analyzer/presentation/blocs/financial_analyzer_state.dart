import 'package:fin_state_analytical/features/financial_analyzer/data/models/raw_finalcial.data.dart';

abstract class FinancialAnalyzerState {}

class FinancialAnalyzerInitial extends FinancialAnalyzerState {}

class FinancialAnalyzerLoading extends FinancialAnalyzerState {}

class FinancialAnalyzerSuccess extends FinancialAnalyzerState {
  final RawFinancialData data;

  FinancialAnalyzerSuccess({required this.data});
}

class FinancialAnalyzerFailure extends FinancialAnalyzerState {
  final String errorMessage;

  FinancialAnalyzerFailure({required this.errorMessage});
}
