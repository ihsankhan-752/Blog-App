import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  TitleText({
    required this.text,
    this.color,
    super.key,
    this.textAlign,
  });
  String text;
  Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: color),
    );
  }
}

class SubTitleText extends StatelessWidget {
  SubTitleText({
    required this.text,
    this.color,
    super.key,
    this.textAlign,
  });
  String text;
  Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style:
          TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: color),
    );
  }
}

class SmallText extends StatelessWidget {
  SmallText({
    required this.text,
    this.color,
    super.key,
    this.textAlign,
  });
  String text;
  Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: color),
    );
  }
}
