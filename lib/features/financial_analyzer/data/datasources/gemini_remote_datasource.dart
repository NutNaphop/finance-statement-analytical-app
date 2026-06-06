import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fin_state_analytical/core/utils/gemini_prompts.dart';
import 'package:fin_state_analytical/features/financial_analyzer/data/models/raw_finalcial.data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class GeminiRemoteDataSource {
  Future<RawFinancialData> uploadAndAnalyzePdf(String filePath);
}

class GeminiRemoteDataSourceImpl implements GeminiRemoteDataSource {
  final Dio _dio;

  GeminiRemoteDataSourceImpl({required Dio dio}) : _dio = dio;
  String get _apiKey => dotenv.env['GEMINI_API_KEY'] ?? '';

  @override
  Future<RawFinancialData> uploadAndAnalyzePdf(String filePath) async {
    try {
      final fileUri = await _uploadPdfFile(filePath);
      final rawData = await _analyzePdfWithGemini(fileUri);

      return rawData;
    } catch (e) {
      throw Exception('Failed to analyze PDF with Gemini: $e');
    }
  }

  Future<String> _uploadPdfFile(String filePath) async {
    final file = File(filePath);
    final numBytes = await file.length();
    final initResponse = await _dio.post(
        "https://generativelanguage.googleapis.com/upload/v1beta/files?key=$_apiKey",
        data: {
          "file": {"displayName": "financial_statement.pdf"}
        },
        options: Options(headers: {
          "X-Goog-Upload-Protocol": "resumable",
          "X-Goog-Upload-Command": "start",
          "X-Goog-Upload-Header-Content-Length": numBytes.toString(),
          "X-Goog-Upload-Header-Content-Type": "application/pdf",
          "Content-Type": "application/json",
        }));
    final uploadUrl = initResponse.headers.value("x-goog-upload-url");
    if (uploadUrl == null) {
      throw Exception("Failed to get upload URL from Gemini");
    }

    final fileBytes = await file.readAsBytes();
    final uploadResponse = await _dio.post(
      uploadUrl,
      data: Stream.fromIterable([fileBytes]), // Stream Upload
      options: Options(
        headers: {
          "Content-Length": numBytes.toString(),
          "X-Goog-Upload-Offset": "0",
          "X-Goog-Upload-Command": "upload, finalize",
        },
      ),
    );

    final fileUri = uploadResponse.data['file']['uri'] as String?;
    if (fileUri == null) {
      throw Exception("Upload completed but failed to retrieve File URI");
    }
    return fileUri;
  }

  Future<RawFinancialData> _analyzePdfWithGemini(String fileUri) async {
    final req = {
      "contents": [
        {
          "parts": [
            {"text": kFinancialAnalysisPrompt},
            {
              "fileData": {"fileUri": fileUri, "mimeType": "application/pdf"}
            }
          ]
        }
      ],
      "generationConfig": {
        "responseMimeType": "application/json",
        "responseSchema": kFinancialResponseSchema
      }
    };

    final response = await _dio.post(
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_apiKey",
      data: req,
      options: Options(headers: {"Content-Type": "application/json"}),
    );

    final responseText =
        response.data['candidates'][0]['content']['parts'][0]['text'] as String;

    final Map<String, dynamic> jsonMap = jsonDecode(responseText);
    return RawFinancialData.fromJson(jsonMap);
  }
}
