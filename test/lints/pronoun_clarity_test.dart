import 'package:test/test.dart';
import 'package:inclusive_copy_lint/src/utils/pronoun_utils.dart';

void main() {
  group('Pronoun Clarity Logic', () {
    test('detects ambiguous pronouns at start of sentence', () {
      final violations = checkPronounClarity('It is crucial to save.');
      expect(violations, contains('It'));

      final violations2 = checkPronounClarity('This is not good.');
      expect(violations2, contains('This'));
    });

    test('allows pronouns when not at start (simplified check)', () {
      // "Save the photo." -> No "it/this/that" at start.
      final violations = checkPronounClarity('Save the photo.');
      expect(violations, isEmpty);
    });

    test('detects plural ambiguous pronouns', () {
      final violations = checkPronounClarity('These are the files.');
      expect(violations, contains('These'));
    });
  });
}

List<String> checkPronounClarity(String text) {
  return PronounUtils.checkClarity(text);
}
