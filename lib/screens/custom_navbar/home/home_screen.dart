import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/constants/app_text_style.dart';
import 'package:flutter/material.dart';

import '../settings/widgets/home_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(text: "Blog App", color: AppColors.primaryBlack),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.bookmark),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Container(
          //   margin: EdgeInsets.only(top: 50),
          //   height: MediaQuery.of(context).size.height * .12,
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //           fit: BoxFit.fill, image: AssetImage("assets/logo.png"))),
          // ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(text: "Recent Articles", color: AppColors.primaryBlue),
                  SizedBox(
                    height: 15,
                  ),
                  HomeScreenCard(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
