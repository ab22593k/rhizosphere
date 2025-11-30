/// Utilities for checking pronoun usage clarity.
class PronounUtils {
  /// Checks for ambiguous pronouns at the start of sentences or segments.
  /// Returns a list of violations (the ambiguous pronouns found).
  static List<String> checkClarity(String text) {
    final violations = <String>[];
    final lowerText = text.trim().toLowerCase();

    // Simple heuristic: "it", "this", "that" at start of string are often ambiguous
    // unless followed by a noun (which we can't easily check without NLP).
    // We'll just flag them if they appear at the very start.
    // We also check for " these " and " those ".

    final ambiguous = ['it', 'this', 'that', 'these', 'those'];

    // Check if text starts with one of these followed by space or punctuation
    for (final word in ambiguous) {
      if (lowerText.startsWith('$word ') ||
          lowerText == word ||
          lowerText.startsWith('$word.') ||
          lowerText.startsWith('$word,')) {
        // Exception: "It is" is common but still potentially ambiguous ("It is important").
        // "This is"
        // "That is"
        // For "Inclusive Copy", we prefer specific subjects.

        // We return the word as it appears in the original text (capitalized likely)
        // We'll just grab the length from the start.
        violations.add(text.substring(0, word.length));
      }
    }

    return violations;
  }
}
