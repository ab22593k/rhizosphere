import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import '../utils/pronoun_utils.dart';

class CheckPronounClarity extends DartLintRule {
  const CheckPronounClarity() : super(code: _code);

  static const _code = LintCode(
    name: 'check_pronoun_clarity',
    problemMessage:
        'Avoid starting sentences with ambiguous pronouns (It, This, That). Use specific nouns instead.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      // Target Text widgets
      if (node.constructorName.type.element2?.displayName != 'Text') return;

      final arguments = node.argumentList.arguments;
      if (arguments.isEmpty) return;

      final firstArg = arguments.first;
      final source = firstArg.toSource();

      // Basic string literal check (ignoring variables for MVP simplicity)
      if (source.length < 2) return;

      // Remove quotes
      final text = source.substring(1, source.length - 1);

      final violations = PronounUtils.checkClarity(text);

      if (violations.isNotEmpty) {
        reporter.atNode(firstArg, _code);
      }
    });
  }
}
