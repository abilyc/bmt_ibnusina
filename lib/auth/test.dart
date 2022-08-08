// ignore_for_file: prefer_typing_uninitialized_variables

class ComplexSingleton {
  static ComplexSingleton? _instance;
  static ComplexSingleton get instance => _instance!;
  static void init(arg) => _instance ??= ComplexSingleton._init(arg);
  final property;
  ComplexSingleton._init(this.property);
  factory ComplexSingleton() => _instance!;
}