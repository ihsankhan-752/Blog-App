import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class HomeDetails extends StatelessWidget {
  final String title;
  final String image;
  final String des;
  HomeDetails(
      {Key? key, required this.image, required this.title, required this.des})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(image),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(text: title, color: AppColors.primaryBlack),
                SubTitleText(text: des, color: AppColors.primaryLightBlack)
              ],
            ),
          )
        ],
      ),
    );
  }
}
