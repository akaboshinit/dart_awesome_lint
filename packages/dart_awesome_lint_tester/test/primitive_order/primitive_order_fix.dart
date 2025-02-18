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
  final MyClass myClass;
  final String title;
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

  final Padding bbb;

  int get vvv => 1;

  // demo comment
  final String ccc;

  /// demo doc
  final VoidCallback ddd;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @immutable
  final String eee;
}
