# **dart_awesome_lint**

`dart_awesome_lint` is a lint package designed to enhance code quality in Dart projects!
This package provides **custom lint rules** to enforce best practices and maintain consistent coding standards.

## ✨ Features

- ✅ **Custom lint rules**
- 🚀 **Flexible integration with `custom_lint`**
- 📚 **Improved code readability and consistency**

## 📋 List of Lint Rules

**Rule**: `enforce_primitive_order`
- Forces class properties to be ordered in primitive order
- Sort the properties alphabetically by type in primitive order

#### 🔍 Example:
```dart
// 🔴 NG
class ExampleClass {
    int b;
    String a;
    MyClass c;
    void Function() d;
    double e;
}

// 🟢 OK
class ExampleClass {
    String a;
    int b;
    double e;
    MyClass c;
    void Function() d;
}
```

## ⚙️ Setup with custom_lint
To use dart_awesome_lint in your project, follow the steps below:

🛠️ Steps
Add dependencies to pubspec.yaml:
Add the following to your pubspec.yaml file:

```yaml
dev_dependencies:
  custom_lint: ^latest
  dart_awesome_lint: ^latest
```

Enable the linter:
Create a .analysis_options.yaml file in your project root and add the following:

```yaml
analyzer:
  plugins:
    - custom_lint
```
Run custom_lint:
Execute the following command in your terminal:

```bash
dart run custom_lint
```

## 🤝 Contribution
This project is open source! ✨
We welcome contributions from the community.

If you have ideas for new lint rules or features, feel free to send a Pull Request!
For bug reports or suggestions, please open an Issue.
💡 Want to make rule creation easier? Join us in improving the development environment!

## 🚀 Roadmap
- 🆕 Add new lint rules
- 🛠️ Expand auto-fix capabilities
- 🙌 Incorporate user feedback
- ✏️ Simplify the process of adding new rules

## 📜 License
This project is licensed under the MIT License.
Feel free to use and modify it for your own projects!
