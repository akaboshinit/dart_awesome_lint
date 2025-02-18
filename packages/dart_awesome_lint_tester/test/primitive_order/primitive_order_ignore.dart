import 'package:flutter/material.dart';

class Demo {
  const Demo({
    required this.title,
    required this.description,
    required this.padding,
    required this.myClass,
    required this.onPressed,
    this.size,
  });

  final Padding padding;
  final Size? size;
  // expect_lint: enforce_primitive_order
  final MyClass myClass;
  final String title;
  // expect_lint: enforce_primitive_order
  final VoidCallback onPressed;
  final String description;
}

class MyClass {}

class Demo2 extends StatelessWidget {
  const Demo2({
    required this.aaa,
    required this.bbb,
    required this.ccc,
    required this.ddd,
    required this.eee,
    super.key,
  });

  final int aaa;

  // expect_lint: enforce_primitive_order
  final Padding bbb;

  int get vvv => 1;

  // demo comment
  final String ccc;

  /// demo doc
  // expect_lint: enforce_primitive_order
  final VoidCallback ddd;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @immutable
  final String eee;
}
