import 'package:flutter/material.dart';

class BottomTabWidget extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final Color? activeColor;
  final Function()? onPressed;

  const BottomTabWidget({super.key, this.icon, this.title, this.activeColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 25, color: activeColor),
          SizedBox(height: 2),
          Text(
            title!,
            style: TextStyle(
              fontSize: 12,
              color: activeColor,
            ),
          ),
        ],
      ),
    );
  }
}
