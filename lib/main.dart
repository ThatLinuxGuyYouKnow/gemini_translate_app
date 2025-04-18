import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gemini_translate/data/apikey.dart';
import 'package:gemini_translate/logic/getTranslation.dart';
import 'package:gemini_translate/setKeyScreen.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Gemini Translate',
      theme: const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.systemBlue,
        scaffoldBackgroundColor: Color.fromARGB(255, 30, 30, 30),
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(color: CupertinoColors.white),
        ),
      ),
      home: TranslationScreen(),
    );
  }
}

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({Key? key}) : super(key: key);

  @override
  _TranslationScreenState createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  // List of common languages
  final List<String> _languages = [
    'Auto Detect',
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese'
  ];

  // Default selected languages
  String _inputLanguage = 'Auto Detect';
  String _outputLanguage = 'English';
  Apikey _apiKey = Apikey();
  String translated_text = '';
  TextEditingController textToTranslateRaw = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ApiKeyScreen()),
              );
            },
            child: Icon(Icons.key)),
        middle: Text('Gemini Translate',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Input Language Selector
              CupertinoButton(
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      title: const Text('Select Input Language'),
                      actions: _languages.map((language) {
                        return CupertinoActionSheetAction(
                          onPressed: () {
                            setState(() {
                              _inputLanguage = language;
                            });
                            Navigator.pop(context);
                          },
                          child: Text(language),
                        );
                      }).toList(),
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Input Language: $_inputLanguage',
                        style: const TextStyle(fontSize: 16)),
                    const Icon(CupertinoIcons.chevron_down),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Output Language Selector
              CupertinoButton(
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      title: const Text('Select Output Language'),
                      actions: _languages.skip(1).map((language) {
                        return CupertinoActionSheetAction(
                          onPressed: () {
                            setState(() {
                              _outputLanguage = language;
                            });
                            Navigator.pop(context);
                          },
                          child: Text(language),
                        );
                      }).toList(),
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Output Language: $_outputLanguage',
                        style: const TextStyle(fontSize: 16)),
                    const Icon(CupertinoIcons.chevron_down),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Text Input Field
              CupertinoTextField(
                onChanged: (value) => setState(() {}),
                controller: textToTranslateRaw,
                placeholder: 'Enter text to translate',
                style:
                    const TextStyle(fontSize: 18, color: CupertinoColors.white),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: CupertinoColors.darkBackgroundGray, // Dark input field
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 20),

              // Translate Button
              CupertinoButton.filled(
                onPressed: textToTranslateRaw.text.length > 1
                    ? () async {
                        print('hey!');
                        translated_text = await getTranslation(
                            context: context,
                            originalLanguage: _inputLanguage,
                            targetLanguage: _outputLanguage,
                            targetText: textToTranslateRaw.text);
                        setState(() {});
                      }
                    : null,
                child: Text('Translate',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textToTranslateRaw.text.length > 1
                            ? Colors.white
                            : Colors.grey)),
              ),
              const SizedBox(height: 20),

              // Translated Text Output
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: CupertinoColors.black, // Dark container
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      translated_text.length > 1
                          ? translated_text
                          : 'Translated text will appear here',
                      style:
                          TextStyle(fontSize: 18, color: CupertinoColors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
