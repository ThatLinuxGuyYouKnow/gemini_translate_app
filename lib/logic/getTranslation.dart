import 'dart:convert';
import 'package:gemini_translate/data/apikey.dart';
import 'package:http/http.dart' as http;

Future<String> getTranslation({
  required String originalLanguage,
  required String targetLanguage,
  required String targetText,
}) async {
  try {
    print('trying to translate');
    Apikey apikey = Apikey();
    String apiKey = apikey.get();

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
      throw Exception('Failed to translate text: ${response.body}');
    }
  } catch (e) {
    throw Exception('Error during translation: $e');
  }
}
