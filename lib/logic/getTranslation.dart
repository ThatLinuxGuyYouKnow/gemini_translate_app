import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gemini_translate/data/apikey.dart';
import 'package:http/http.dart' as http;

Future<String> getTranslation(
    {required String originalLanguage,
    required String targetLanguage,
    required String targetText,
    required context}) async {
  try {
    print('trying to translate');
    Apikey keyHandler = Apikey();
    String apiKey = keyHandler.get();
    if (apiKey.length < 1) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(
          content: Text(
              'You need to set your api key, tap the key icon on the top left')));
      return '';
    }
    final url =
        Uri.parse('https://gemini-translate-dzxg.onrender.com/translate');

    final Map<String, String> requestBody = {
      "original_language": originalLanguage,
      "target_language": targetLanguage,
      "text": targetText,
      "api_key": apiKey,
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print('all good!');

      print(response.body);
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print(responseData['translated_text']);

      return responseData['translated_text'];
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(
          content: Text('Failed to translate text: ${response.body}')));
    }
    return '';
  } catch (e) {
    throw Exception('Error during translation: $e');
  }
}
