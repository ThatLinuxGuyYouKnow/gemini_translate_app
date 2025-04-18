# Gemini Translate

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Gemini API](https://img.shields.io/badge/Powered%20by-Gemini%20API-4285F4?logo=google)](https://ai.google.dev/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

A Flutter application for translating text between languages using the Google Gemini API.

## Overview

Gemini Translate is a simple, elegant mobile app built with Flutter that provides text translation services using Google's Gemini API. The app features a clean, dark-themed UI with CupertinoApp styling for an iOS-like experience.

## Features

- Translate text between multiple languages
- Support for common languages including English, Spanish, French, German, and Chinese
- Auto-detect input language option
- Dark mode UI design
- Secure API key management
- Simple and intuitive interface

## Requirements

- Flutter SDK
- Gemini API key
- get_storage package for local storage
- http package for API communication

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/thatlinuxguyyouknow/gemini_translate.git
cd gemini_translate
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Get a Gemini API Key

You'll need to obtain an API key from the Google Gemini AI platform:
1. Visit [Google AI Studio](https://ai.google.dev/)
2. Create an account or sign in
3. Generate an API key

### 4. Run the app

```bash
flutter run
```

## Usage

1. **Set Your API Key**
   - Tap the key icon on the top left of the main screen
   - Enter your Gemini API key
   - Tap "Save API Key"

2. **Translate Text**
   - Select your input language (or use "Auto Detect")
   - Select your output language
   - Enter the text you want to translate
   - Tap the "Translate" button
   - View the translated text in the result area

## Project Structure

- `lib/main.dart` - Main application and UI components
- `lib/data/apikey.dart` - API key storage management
- `lib/logic/getTranslation.dart` - Translation functionality
- `lib/setKeyScreen.dart` - API key management screen

 