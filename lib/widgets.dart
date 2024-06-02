import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton({
    required this.onclick,
    required this.textButtonText,
    required this.fontSize,
    super.key,
  });

  VoidCallback onclick;
  String textButtonText;
  double fontSize;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onclick,
      child: Text(
        textButtonText,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

// class SwitchButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     return Switch(
//       value: themeProvider.themeData == darkTheme,
//       onChanged: (value) {
//         themeProvider.toggleTheme();
//       },
//     );
//   }
// }
