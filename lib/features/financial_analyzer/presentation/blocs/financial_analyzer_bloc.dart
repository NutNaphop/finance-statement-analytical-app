import 'package:fin_state_analytical/features/financial_analyzer/domain/repositories/financial_report_repository.dart';
import 'package:fin_state_analytical/features/financial_analyzer/presentation/blocs/financial_analyzer_event.dart';
import 'package:fin_state_analytical/features/financial_analyzer/presentation/blocs/financial_analyzer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinancialAnalyzerBloc
    extends Bloc<FinancialAnalyzerEvent, FinancialAnalyzerState> {
  final FinancialReportRepository _repository;

  FinancialAnalyzerBloc({required FinancialReportRepository repository})
      : _repository = repository,
        super(FinancialAnalyzerInitial()) {
    on<AnalyzeReportRequested>(_onAnalyzeReportRequested);
  }
  Future<void> _onAnalyzeReportRequested(
    AnalyzeReportRequested event,
    Emitter<FinancialAnalyzerState> emit,
  ) async {
    emit(FinancialAnalyzerLoading());

    try {
      final data = await _repository.analyzeReport(event.filePath);
      emit(FinancialAnalyzerSuccess(data: data));
    } catch (e) {
      emit(FinancialAnalyzerFailure(errorMessage: e.toString()));
    }
  }
}
