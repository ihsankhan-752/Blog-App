import 'package:blog_app/constants/app_text_style.dart';
import 'package:blog_app/screens/home/widgets/home_card.dart';
import 'package:flutter/material.dart';

class CustomTabBarAll extends StatelessWidget {
  const CustomTabBarAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
                text: "All Articles",
                color: Theme.of(context).colorScheme.primary),
            SizedBox(
              height: 15,
            ),
            HomeScreenCard(),
          ],
        ),
      ),
    ));
  }
}
