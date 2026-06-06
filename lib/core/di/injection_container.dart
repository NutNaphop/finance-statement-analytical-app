import 'package:dio/dio.dart';
import 'package:fin_state_analytical/features/financial_analyzer/data/datasources/financial_local_datasource.dart';
import 'package:fin_state_analytical/features/financial_analyzer/data/datasources/gemini_remote_datasource.dart';
import 'package:fin_state_analytical/features/financial_analyzer/data/repositories/financial_report_repository_impl.dart';
import 'package:fin_state_analytical/features/financial_analyzer/domain/repositories/financial_report_repository.dart';
import 'package:fin_state_analytical/features/financial_analyzer/presentation/blocs/financial_analyzer_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

// Use for init DI External , Datasource , Repo , Use case , Bloc
Future<void> initDepedencies() async {
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<GeminiRemoteDataSource>(
      () => GeminiRemoteDataSourceImpl(dio: sl()));

  // Datasource
  sl.registerLazySingleton<FinancialLocalDataSource>(
      () => FinancialLocalDataSourceImpl());

  // Repo
  sl.registerLazySingleton<FinancialReportRepository>(
    () => FinancialReportRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Bloc
  sl.registerFactory<FinancialAnalyzerBloc>(
      () => FinancialAnalyzerBloc(repository: sl()));
}
