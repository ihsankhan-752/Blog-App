import 'package:blog_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    this.iconData,
    this.hintTitle,
    this.color,
    super.key,
    this.controller,
    this.onChanged,
  });
  IconData? iconData;
  String? hintTitle;
  Color? color;

  final TextEditingController? controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      minLines: 1,
      maxLines: 10,
      decoration: InputDecoration(
          filled: true,
          fillColor: color,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.primaryLightGrey,
            ),
          ),
          hintText: hintTitle,
          prefixIcon: Icon(
            iconData,
            color: Theme.of(context).colorScheme.primary,
            size: 25,
          ),
          hintStyle: TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}

class CustomPasswordTextField extends StatefulWidget {
  CustomPasswordTextField({
    Key? key,
    this.controller,
    this.onChanged,
  }) : super(key: key);
  final TextEditingController? controller;
  final Function(String)? onChanged;
  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
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
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primaryLightGrey),
        ),
        prefixIcon: Icon(
          Icons.lock,
          color: Theme.of(context).colorScheme.primary,
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
          ),
        ),
        hintStyle: TextStyle(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
