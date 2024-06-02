import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onclick;
  final String textButtonText;
  final double fontSize;

  CustomTextButton({required this.onclick, required this.textButtonText, required this.fontSize, super.key});

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
