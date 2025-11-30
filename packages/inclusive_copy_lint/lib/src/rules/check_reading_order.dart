import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class CheckReadingOrder extends DartLintRule {
  const CheckReadingOrder() : super(code: _code);

  static const _code = LintCode(
    name: 'check_reading_order',
    problemMessage:
        'Skipped heading level. Headings should follow a logical order (e.g., H1 -> H2, not H1 -> H3).',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // We need to track state across the file.
    int lastLevel = 0; // 0 means no header seen yet.

    context.registry.addInstanceCreationExpression((node) {
      if (node.constructorName.type.element2?.displayName !=
          'AccessibleHeader') {
        return;
      }

      final args = node.argumentList.arguments;
      int? currentLevel;

      for (final arg in args) {
        if (arg is NamedExpression) {
          if (arg.name.label.name == 'level') {
            final val = arg.expression.toSource();
            currentLevel = int.tryParse(val);
            break;
          }
        }
      }

      // Default is 1 if not specified
      currentLevel ??= 1;

      if (lastLevel != 0) {
        if (currentLevel > lastLevel + 1) {
          reporter.atNode(node, _code);
        }
      }

      lastLevel = currentLevel;
    });
  }
}
