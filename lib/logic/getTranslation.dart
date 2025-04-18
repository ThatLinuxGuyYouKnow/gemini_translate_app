import 'dart:convert';
import 'package:flutter/cupertino.dart';
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
  final String apiKey = keyHandler.get();

  if (apiKey.length < 2) {
    await showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Missing API Key'),
        content:
            const Text('Tap the key icon on the top left to set your key.'),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
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
      await showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text('Something went wrong'),
          content: Text(response.body),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
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
