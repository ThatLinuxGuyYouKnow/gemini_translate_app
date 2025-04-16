import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        brightness: Brightness.dark, // Set the app to dark mode
        primaryColor: CupertinoColors.systemOrange,
        scaffoldBackgroundColor:
            Color.fromARGB(255, 30, 30, 30), // Dark background
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
              color: CupertinoColors.white), // Light text for contrast
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

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
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
                onPressed: () {
                  // TODO: Implement translation logic
                },
                child: const Text('Translate',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),

              // Translated Text Output
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: CupertinoColors.black, // Dark container
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const SingleChildScrollView(
                    child: Text(
                      'Translated text will appear here',
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
