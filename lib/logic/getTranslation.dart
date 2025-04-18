import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gemini_translate/data/apikey.dart';
import 'package:http/http.dart' as http;

Future<String> getTranslation({
  required BuildContext context,
  required String originalLanguage,
  required String targetLanguage,
  required String targetText,
}) async {
  final keyHandler = Apikey();
  final apiKey = keyHandler.get();

  if (apiKey.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'You need to set your API key! Tap the key icon on the top left.',
        ),
      ),
    );
    return '';
  }

  final url = Uri.parse('https://gemini-translate-dzxg.onrender.com/translate');
  final body = jsonEncode({
    "original_language": originalLanguage,
    "target_language": targetLanguage,
    "text": targetText,
    "api_key": apiKey,
  });

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['translated_text'] as String? ?? '';
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Translate failed: ${response.body}')),
      );
      return '';
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error during translation: $e')),
    );
    return '';
  }
}
