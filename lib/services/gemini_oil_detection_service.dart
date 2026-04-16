import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class GeminiOilDetectionResult {
  const GeminiOilDetectionResult({
    required this.oilDetected,
    required this.confidence,
    required this.reason,
  });

  final bool oilDetected;
  final int confidence;
  final String reason;

  Map<String, dynamic> toJson() => {
        'oil_detected': oilDetected,
        'confidence': confidence,
        'reason': reason,
      };

  factory GeminiOilDetectionResult.fromJson(Map<String, dynamic> json) {
    final rawConfidence = json['confidence'];
    final parsedConfidence = rawConfidence is num
        ? rawConfidence.toInt()
        : int.tryParse(rawConfidence?.toString() ?? '') ?? 0;

    return GeminiOilDetectionResult(
      oilDetected: json['oil_detected'] == true ||
          json['oil_detected']?.toString().toLowerCase() == 'true',
      confidence: parsedConfidence.clamp(0, 100),
      reason: (json['reason'] ?? '').toString(),
    );
  }
}

class GeminiOilDetectionService {
  GeminiOilDetectionService({
    required this.apiKey,
    this.model = 'gemini-1.5-flash',
  });

  final String apiKey;
  final String model;

  static const _prompt = '''
You are a highly strict image analysis AI.

Task: Detect presence of oil in the image.

Definition of oil:
- Any shiny, reflective, viscous liquid
- May appear dark, yellowish, or transparent

Rules:
- If unsure → oil_detected = false
- Avoid false positives
- Only use visible evidence

Return ONLY JSON:
{
  "oil_detected": true or false,
  "confidence": number (0-100),
  "reason": "max 10 words"
}
''';

  Future<GeminiOilDetectionResult> detectOilFromFile(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    return detectOilFromBytes(
      bytes,
      mimeType: _guessMimeTypeFromPath(imageFile.path),
    );
  }

  Future<GeminiOilDetectionResult> detectOilFromBytes(
    List<int> bytes, {
    required String mimeType,
  }) async {
    final base64Image = base64Encode(bytes);

    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1/models/'
      '$model:generateContent?key=$apiKey',
    );

    final body = <String, dynamic>{
      'contents': [
        {
          'parts': [
            {'text': _prompt},
            {
              'inline_data': {
                'mime_type': mimeType,
                'data': base64Image,
              }
            },
          ],
        }
      ],
    };

    final response = await http.post(
      url,
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Gemini API error (${response.statusCode}): ${response.body}',
      );
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    String? text;
    final candidates = decoded['candidates'] as List<dynamic>?;
    if (candidates != null && candidates.isNotEmpty) {
      final content =
          (candidates[0] as Map<String, dynamic>)['content'] as Map<String, dynamic>?;
      final parts = content?['parts'] as List<dynamic>?;
      if (parts != null && parts.isNotEmpty) {
        final part = parts[0] as Map<String, dynamic>;
        text = part['text']?.toString();
      }
    }

    if (text == null || text.trim().isEmpty) {
      throw FormatException('Gemini returned empty text: ${response.body}');
    }

    final cleaned = _cleanGeminiJsonText(text);
    final jsonMap = jsonDecode(cleaned) as Map<String, dynamic>;
    return GeminiOilDetectionResult.fromJson(jsonMap);
  }

  String _guessMimeTypeFromPath(String path) {
    final lower = path.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    // Default to jpeg for most mobile camera outputs.
    return 'image/jpeg';
  }

  /// Gemini sometimes wraps json inside ```json ... ```
  /// This tries to extract and decode the first JSON object.
  String _cleanGeminiJsonText(String text) {
    var t = text.trim();
    t = t.replaceAll('```json', '').replaceAll('```', '').trim();

    // If Gemini returns extra text, extract first JSON object.
    final match = RegExp(r'\{[\s\S]*\}').firstMatch(t);
    if (match != null) return match.group(0)!.trim();
    return t;
  }
}

