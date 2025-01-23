import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
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

          reporter
              .createChangeBuilder(
            priority: _priority,
            message: _name,
          )
              .addDartFileEdit((builder) {
            final sortedMembers = members.toList()
              ..sort((a, b) {
                final levelComparison = a.level.compareTo(b.level);
                if (levelComparison != 0) {
                  return levelComparison;
                }
                return a.field.fields.variables.first.name.lexeme.compareTo(
                  b.field.fields.variables.first.name.lexeme,
                );
              });

            final replacementProps = sortedMembers.indexed.map((e) {
              final index = e.$1;
              final member = e.$2;

              final source = member.field.toSource();

              if (index == 0) {
                return source;
              }

              final currentBeginToken = member.field.beginToken;

              final indent = ''.padLeft(
                resolver.lineInfo
                    .getLocation(currentBeginToken.offset - 1)
                    .columnNumber,
              );

              return indent + source;
            }).join(
              '\n',
            );

            final fieldsFirstTokenOffset = fields.first.beginToken.offset;
            final fieldsLastTokenOffset =
                fields.last.semicolon.offset + fields.last.semicolon.length;

            builder.addSimpleReplacement(
              SourceRange(
                fieldsFirstTokenOffset,
                fieldsLastTokenOffset - fieldsFirstTokenOffset,
              ),
              replacementProps,
            );
          });
        }
      },
    );
  }
}
