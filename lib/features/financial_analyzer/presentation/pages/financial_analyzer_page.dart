import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../blocs/financial_analyzer_bloc.dart';
import '../blocs/financial_analyzer_event.dart';
import '../blocs/financial_analyzer_state.dart';

class FinancialAnalyzerPage extends StatelessWidget {
  const FinancialAnalyzerPage({super.key});

  @override
  Widget build(BuildContext context) {
    // โยน BLoC จากระบบ DI (sl) เข้ามาให้ Widget ลูกเรียกใช้งานได้
    return BlocProvider(
      create: (_) => sl<FinancialAnalyzerBloc>(),
      child: const FinancialAnalyzerView(),
    );
  }
}

class FinancialAnalyzerView extends StatelessWidget {
  const FinancialAnalyzerView({super.key});

  // ฟังก์ชันช่วยเหลือสำหรับเปิดหน้าต่างเลือกไฟล์ PDF
  Future<void> _pickAndAnalyzeFile(BuildContext context) async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      final filePath = result.files.single.path!;

      // ส่ง Event ไปหา BLoC เพื่อสั่งเริ่มวิเคราะห์
      context
          .read<FinancialAnalyzerBloc>()
          .add(AnalyzeReportRequested(filePath: filePath));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Financial Report Analyzer')),
      body: BlocBuilder<FinancialAnalyzerBloc, FinancialAnalyzerState>(
        builder: (context, state) {
          // 1. สถานะเริ่มต้น (Initial)
          if (state is FinancialAnalyzerInitial) {
            return Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.upload_file),
                label: const Text('อัปโหลดงบการเงิน (PDF)'),
                onPressed: () => _pickAndAnalyzeFile(context),
              ),
            );
          }

          // 2. สถานะกำลังโหลดวิเคราะห์ (Loading)
          if (state is FinancialAnalyzerLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Gemini AI กำลังแกะเอกสาร PDF...'),
                ],
              ),
            );
          }

          // 3. สถานะวิเคราะห์สำเร็จ (Success)
          if (state is FinancialAnalyzerSuccess) {
            final report = state.data;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('บริษัท: ${report.companyName}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('กลุ่มธุรกิจ: ${report.industrySector}'),
                  Text('ปีงบการเงิน: ${report.year}'),
                  const Divider(),
                  Text('สินทรัพย์หมุนเวียน: ${report.currentAssets} บาท'),
                  Text('หนี้สินหมุนเวียน: ${report.currentLiabilities} บาท'),
                  Text('กำไรสุทธิ: ${report.netIncome} บาท'),
                  // พี่สามารถลองเติมแสดงตัวเลขดิบตัวอื่นๆ ตรงนี้ได้ตามต้องการครับ...
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => _pickAndAnalyzeFile(context),
                    child: const Text('วิเคราะห์ไฟล์ใหม่'),
                  )
                ],
              ),
            );
          }

          // 4. สถานะล้มเหลว (Failure)
          if (state is FinancialAnalyzerFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 60),
                  const SizedBox(height: 16),
                  Text('เกิดข้อผิดพลาด: ${state.errorMessage}',
                      textAlign: TextAlign.center),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => _pickAndAnalyzeFile(context),
                    child: const Text('ลองอีกครั้ง'),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
