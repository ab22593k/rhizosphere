import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/l10n/app_localizations_en.dart';

void main() {
  test('AppLocalizations keys return correct keys/defaults', () {
    // Since we are using Intl.message directly with defaults in our manual class
    // We can test the getters.
    // Note: Without generating code, Intl.message might just return default text or key.
    // We need to ensure it returns the default text we provided.

    final l10n = AppLocalizationsEn('en');

    // We can't easily mock Intl.message behavior without setup,
    // but usually it returns default text if no locale data is loaded.
    expect(l10n.savePhoto, 'Save photo');
    expect(l10n.removePhoto, 'Remove photo');
    expect(l10n.signOut, 'Sign out');
    expect(l10n.yourSteps, 'Your steps');
  });
}
