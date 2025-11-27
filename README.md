# Rhizosphere

A Flutter package for building accessible UI components and managing accessibility state.

## Features

- **Accessibility Config Management**: Centralized management for text scaling and high contrast modes.
- **AccessibleWrapper**: Automatically applies text scaling and contrast settings to your app.
- **Accessible Components**: Pre-built accessible widgets like `AccessibleButton` and `AccessibleTextField`.
- **Gesture Handling**: Built-in support for alternative gestures (long press, swipe) for motor accessibility.
- **Live Announcements**: Support for screen reader live regions via `LiveAnnouncer`.

## Getting Started

Add `rhizosphere` and `flutter_riverpod` to your `pubspec.yaml`:

```yaml
dependencies:
  rhizosphere: ^0.1.0
  flutter_riverpod: ^2.0.0
```

## Usage

Wrap your application with `ProviderScope` and use `AccessibleWrapper` in your `MaterialApp` builder:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhizosphere/rhizosphere.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(accessibilityProvider);

    return MaterialApp(
      // Apply AccessibleWrapper
      builder: (context, child) => AccessibleWrapper(child: child!),
      theme: ThemeData(
        // Use config for theme adjustments
        colorScheme: config.highContrast 
            ? const ColorScheme.highContrastLight() 
            : ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(),
    );
  }
}
```

### Using Accessible Components

```dart
AccessibleButton(
  label: 'Submit',
  semanticLabel: 'Submit form to server',
  onPressed: () => print('Submitted'),
);

AccessibleTextField(
  label: 'Username',
  hint: 'Enter your username',
  controller: myController,
);
```

## Additional Information

This package aims to simplify meeting WCAG standards for Flutter applications by providing easy-to-use wrappers and components.
