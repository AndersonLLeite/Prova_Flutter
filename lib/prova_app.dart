import 'package:flutter/material.dart';
import 'package:prova_flutter/information_capture.dart';
import 'package:prova_flutter/ui/theme/theme_config.dart';

import 'login.dart';

class ProvaApp extends StatelessWidget {
  const ProvaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Prova Flutter',
        debugShowCheckedModeBanner: false,
        theme: ThemeConfig.theme,
        routes: {
          '/': (context) => const Login(),
          '/information_capture': (context) => const InformationCapture(),
        });
  }
}
