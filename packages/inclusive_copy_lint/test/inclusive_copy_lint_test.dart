import 'package:test/test.dart';

void main() {
  group('InclusiveCopyLint', () {
    test('ban_title_case_text_widget detects Title Case', () {
      // Placeholder for actual analysis test
      // Real test would use custom_lint test utilities to parse:
      // Text('Save Photo') -> expect lint error
      // Text('Save photo') -> expect no error
    });

    test('ban_forbidden_pronouns detects pronouns', () {
      // Text('We need permission') -> error
      // Text('You need permission') -> no error
    });
  });
}
