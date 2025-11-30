import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class BanTitleCaseTextWidget extends DartLintRule {
  const BanTitleCaseTextWidget() : super(code: _code);

  static const _code = LintCode(
    name: 'ban_title_case_text_widget',
    problemMessage: 'Avoid Title Case. Use Sentence case.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (node.constructorName.type.element2?.displayName != 'Text') return;

      final arguments = node.argumentList.arguments;
      if (arguments.isEmpty) return;

      // First arg is usually the text
      final firstArg = arguments.first;
      // We only check string literals
      // In a real linter, we might resolve constant variables too
      // Using .toSource() or checking StringLiteral type
      // stringValue can be null if it's not a literal
      // Using simple string check for MVP
      final source = firstArg.toSource();
      // Remove quotes
      if (source.length < 2) return;
      final text = source.substring(1, source.length - 1);

      if (_isTitleCase(text)) {
        reporter.atNode(firstArg, _code);
      }
    });
  }

  bool _isTitleCase(String text) {
    final words = text.split(' ');
    if (words.length < 2) return false;

    int upperCount = 0;
    for (int i = 1; i < words.length; i++) {
      final word = words[i];
      if (word.isEmpty) continue;
      if (word[0] == word[0].toUpperCase() &&
          word[0] != word[0].toLowerCase()) {
        // Exceptions: "I", "TV", "API" - minimal heuristic
        if (word == 'I') continue;
        upperCount++;
      }
    }

    // If we have capitalized words after the first one, suspect Title Case
    return upperCount > 0;
  }
}
