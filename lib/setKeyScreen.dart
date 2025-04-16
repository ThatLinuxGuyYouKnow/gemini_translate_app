import 'package:flutter/cupertino.dart';
import 'package:gemini_translate/data/apikey.dart';
import 'package:get_storage/get_storage.dart';

class TranslationScreen extends StatelessWidget {
  const TranslationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Gemini Translate',
            style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: ApiKeyButton(),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Translation Screen'),
            ],
          ),
        ),
      ),
    );
  }
}

class ApiKeyButton extends StatelessWidget {
  const ApiKeyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => ApiKeyScreen()),
        );
      },
      child: const Icon(CupertinoIcons.settings,
          color: CupertinoColors.systemBlue),
    );
  }
}

class ApiKeyScreen extends StatefulWidget {
  const ApiKeyScreen({Key? key}) : super(key: key);

  @override
  _ApiKeyScreenState createState() => _ApiKeyScreenState();
}

class _ApiKeyScreenState extends State<ApiKeyScreen> {
  final Apikey _apikeyManager = Apikey();
  final TextEditingController _apiKeyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _apiKeyController.text = _apikeyManager.get(); // Load existing API key
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  void _saveApiKey() {
    final apiKey = _apiKeyController.text.trim();
    if (apiKey.isNotEmpty) {
      _apikeyManager.store(apiKey: apiKey);
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Success'),
          content: const Text('API key saved successfully.'),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Error'),
          content: const Text('Please enter a valid API key.'),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _deleteApiKey() {
    _apikeyManager.delete();
    _apiKeyController.clear();
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Success'),
        content: const Text('API key deleted successfully.'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Manage API Key'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'API Key',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              CupertinoTextField(
                controller: _apiKeyController,
                placeholder: 'Enter your API key',
                style:
                    const TextStyle(fontSize: 16, color: CupertinoColors.white),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: CupertinoColors.darkBackgroundGray,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 20),
              CupertinoButton.filled(
                onPressed: _saveApiKey,
                child: const Text('Save API Key'),
              ),
              const SizedBox(height: 10),
              CupertinoButton(
                onPressed: _deleteApiKey,
                child: const Text(
                  'Delete API Key',
                  style: TextStyle(color: CupertinoColors.destructiveRed),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
