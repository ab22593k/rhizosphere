import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class BanForbiddenPronouns extends DartLintRule {
  const BanForbiddenPronouns() : super(code: _code);

  static const _code = LintCode(
    name: 'ban_forbidden_pronouns',
    problemMessage:
        'Avoid first person pronouns (we, our, us, I, me, my). Use "you/your".',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // Check if file is legal screen
    // resolver.path ...
    // But we don't have easy path access in `run` without resolving unit?
    // `resolver.source.fullName`

    // Wait, we need to check the path.

    context.registry.addInstanceCreationExpression((node) {
      if (resolver.source.fullName.contains('legal') ||
          resolver.source.fullName.contains('terms')) {
        return;
      }

      if (node.constructorName.type.element2?.displayName != 'Text') return;

      final arguments = node.argumentList.arguments;
      if (arguments.isEmpty) return;

      final firstArg = arguments.first;
      final source = firstArg.toSource();
      if (source.length < 2) return;
      final text = source.substring(1, source.length - 1).toLowerCase();

      // Basic word boundary check
      final forbidden = ['we', 'our', 'us', 'i', 'me', 'my'];
      final words = text.split(RegExp(r'[^\w]')); // split by non-word chars

      for (final word in words) {
        if (forbidden.contains(word)) {
          reporter.atNode(firstArg, _code);
          break;
        }
      }
    });
  }
}
