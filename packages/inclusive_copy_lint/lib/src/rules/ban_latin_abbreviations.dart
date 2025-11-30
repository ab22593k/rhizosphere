import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class BanLatinAbbreviations extends DartLintRule {
  const BanLatinAbbreviations() : super(code: _code);

  static const _code = LintCode(
    name: 'ban_latin_abbreviations',
    problemMessage:
        'Avoid Latin abbreviations (e.g., i.e., etc.). Use "for example", "that is", "and so on".',
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

      final firstArg = arguments.first;
      final source = firstArg.toSource().toLowerCase();

      final forbidden = ['e.g.', 'i.e.', 'etc.', 'vs.', 'cf.'];

      for (final abbr in forbidden) {
        if (source.contains(abbr)) {
          reporter.atNode(firstArg, _code);
          break;
        }
      }
    });
  }
}
