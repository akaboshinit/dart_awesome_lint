import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:dart_awesome_lint/lints/primitive_order/shared.dart';

void primitiveOrderChangeBuilder({
  required Iterable<FieldDeclaration> fields,
  required CustomLintResolver resolver,
  required ChangeReporter reporter,
  required int priority,
  required String name,
  required List<FieldMemberInfo> members,
}) {
  reporter
      .createChangeBuilder(
    priority: priority,
    message: name,
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
