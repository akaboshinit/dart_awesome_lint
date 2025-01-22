import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:dart_awesome_lint/lints/primitive_order/convert_primitive_order_assist.dart';
import 'package:dart_awesome_lint/lints/primitive_order/enforce_primitive_order_lint.dart';

PluginBase createPlugin() => _DartAwesomeLint();

class _DartAwesomeLint extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => const [
        EnforcePrimitiveOrderLint(),
      ];

  @override
  List<Assist> getAssists() => [
        ConvertPrimitiveOrderAssist(),
      ];
}
