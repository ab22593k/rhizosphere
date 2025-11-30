import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class BanAlarmistLanguage extends DartLintRule {
  const BanAlarmistLanguage() : super(code: _code);

  static const _code = LintCode(
    name: 'ban_alarmist_language',
    problemMessage:
        'Avoid alarmist language (warning, danger, beware). Use "Information" or "Note".',
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

      final forbidden = ['warning', 'careful', 'danger', 'beware'];

      for (final word in forbidden) {
        if (source.contains(word)) {
          reporter.atNode(firstArg, _code);
          break;
        }
      }
    });
  }
}
