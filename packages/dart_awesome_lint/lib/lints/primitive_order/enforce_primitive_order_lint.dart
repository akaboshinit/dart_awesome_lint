import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:dart_awesome_lint/lints/primitive_order/shared.dart';

class EnforcePrimitiveOrderLint extends DartLintRule {
  const EnforcePrimitiveOrderLint() : super(code: _code);

  static const _code = LintCode(
    name: 'enforce_primitive_order',
    problemMessage:
        'Primitive fields should be declared before non-primitive fields.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
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

          for (var i = 0; i < members.length - 1; i++) {
            final current = members.elementAt(i);
            final next = members.elementAtOrNull(i + 1);

            if (next != null && current.level > next.level) {
              final sourceRange = current.field.fields.sourceRange;
              reporter.reportErrorForOffset(
                _code,
                sourceRange.offset,
                sourceRange.length,
              );
            }
          }
        }
      },
    );
  }
}
