import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _instance;
  ColorsApp._();
  static ColorsApp get instance {
    _instance ??= ColorsApp._();
    return _instance!;
  }

  Color get primary => const Color(0xFF1D4F62);
  Color get secondary => const Color(0xFF2B938C);
  Color get greyDart => Color.fromARGB(255, 229, 211, 211);
  Color get green => const Color(0xFF44BD6E);
}

extension ColorAppExtensions on BuildContext {
  ColorsApp get colors => ColorsApp.instance;
}
