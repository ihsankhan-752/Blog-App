import 'package:blog_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData? iconData;
  final String? hintTitle;
  final Color? color;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  CustomTextField({this.iconData, this.hintTitle, this.color, super.key, this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      minLines: 1,
      maxLines: 10,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        hintText: hintTitle,
        prefixIcon: Icon(
          iconData,
          color: Colors.grey,
          size: 25,
        ),
        hintStyle: TextStyle(),
      ),
    );
  }
}

class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;

  CustomPasswordTextField({Key? key, this.controller, this.onChanged}) : super(key: key);

  @override
  State<CustomPasswordTextField> createState() => _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscureText,
      onChanged: widget.onChanged,
      controller: widget.controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.grey,
        ),
        hintText: "Password",
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
