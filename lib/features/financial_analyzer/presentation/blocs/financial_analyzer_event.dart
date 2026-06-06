abstract class FinancialAnalyzerEvent {}

class AnalyzeReportRequested extends FinancialAnalyzerEvent {
  final String filePath;

  AnalyzeReportRequested({required this.filePath});
}
