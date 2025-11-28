import 'package:flutter/material.dart';

class AccessibilityViewModel extends ChangeNotifier {
  // Placeholder for future accessibility settings
  // For now, we rely on system settings (MediaQuery)

  bool _showSemanticsDebugger = false;

  bool get showSemanticsDebugger => _showSemanticsDebugger;

  void toggleSemanticsDebugger() {
    _showSemanticsDebugger = !_showSemanticsDebugger;
    notifyListeners();
  }
}
