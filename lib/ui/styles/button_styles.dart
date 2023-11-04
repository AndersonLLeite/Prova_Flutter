import 'package:flutter/material.dart';
import 'package:prova_flutter/ui/styles/text_styles.dart';

import 'colors_app.dart';

class ButtonStyles {
  static ButtonStyles? _instance;
  ButtonStyles._();
  static ButtonStyles get instance {
    _instance ??= ButtonStyles._();
    return _instance!;
  }

  ButtonStyle get primaryButton => ElevatedButton.styleFrom(
      backgroundColor: ColorsApp.instance.green,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      textStyle: TextStyles.instance.textSecondaryFontExtraBold
          .copyWith(fontSize: 14));
}

extension ButtonStylesExtensions on BuildContext {
  ButtonStyles get buttonStyles => ButtonStyles.instance;
}
