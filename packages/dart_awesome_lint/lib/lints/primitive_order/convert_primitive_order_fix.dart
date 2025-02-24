import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:dart_awesome_lint/lints/primitive_order/primitive_order_change_builder.dart';
import 'package:dart_awesome_lint/lints/primitive_order/shared.dart';

class ConvertPrimitiveOrderFix extends DartFix {
  static const _name = 'Fix primitive field order';
  static const _priority = 1;

  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    context.registry.addClassDeclaration(
      (node) {
        final fields = node.members.whereType<FieldDeclaration>();
        if (fields.isNotEmpty) {
          final members = <FieldMemberInfo>[];

          for (final field in fields) {
            final typeAnnotation = field.fields.type;
            final dartType = typeAnnotation?.type;
            members.add(
              getTypeLevel(
                dartType: dartType,
                field: field,
              ),
            );
          }

          primitiveOrderChangeBuilder(
            fields: fields,
            resolver: resolver,
            reporter: reporter,
            priority: _priority,
            name: _name,
            members: members,
          );
        }
      },
    );
  }
}
