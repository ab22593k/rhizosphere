import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'rules/ban_title_case_text_widget.dart';
import 'rules/ban_forbidden_pronouns.dart';
import 'rules/ban_latin_abbreviations.dart';
import 'rules/ban_alarmist_language.dart';

class InclusiveCopyLint extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
    const BanTitleCaseTextWidget(),
    const BanForbiddenPronouns(),
    const BanLatinAbbreviations(),
    const BanAlarmistLanguage(),
  ];
}
