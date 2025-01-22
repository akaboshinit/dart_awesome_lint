import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/type.dart';

typedef FieldMemberInfo = ({int level, FieldDeclaration field});

FieldMemberInfo getTypeLevel({
  required DartType? dartType,
  required FieldDeclaration field,
}) {
  if (dartType == null) {
    return (level: 99, field: field);
  }

  if (dartType.isDartCoreInt ||
      dartType.isDartCoreDouble ||
      dartType.isDartCoreBool ||
      dartType.isDartCoreString) {
    return (level: 1, field: field);
  }

  if (dartType.isDartCoreEnum || dartType.isDartCoreRecord) {
    return (level: 2, field: field);
  }

  if (dartType.isDartCoreList ||
      dartType.isDartCoreSet ||
      dartType.isDartCoreMap ||
      dartType.isDartCoreObject ||
      dartType.isDartCoreIterable ||
      dartType.isDartCoreSymbol) {
    return (level: 3, field: field);
  }

  if (dartType.isDartAsyncFuture ||
      dartType.isDartAsyncFutureOr ||
      dartType.isDartAsyncStream ||
      dartType.isDartCoreFunction) {
    return (level: 5, field: field);
  } else {
    return (level: 4, field: field);
  }
}
