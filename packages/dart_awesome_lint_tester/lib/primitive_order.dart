import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({
    required this.title,
    required this.description,
    required this.padding,
    required this.myClass,
    required this.onPressed,
    this.size,
    super.key,
  });

  final Padding padding;
  final Size? size;
  // expect_lint: enforce_primitive_order
  final MyClass myClass;
  final String title;
  // expect_lint: enforce_primitive_order
  final VoidCallback onPressed;
  final String description;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(title),
        ),
      ),
    );
  }
}

class MyClass {}
