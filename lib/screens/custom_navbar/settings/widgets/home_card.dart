import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/constants/app_text_style.dart';
import 'package:blog_app/constants/lists.dart';
import 'package:blog_app/screens/custom_navbar/home/blog_details_screen.dart';
import 'package:blog_app/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreenCard extends StatefulWidget {
  HomeScreenCard({
    super.key,
  });

  @override
  State<HomeScreenCard> createState() => _HomeScreenCardState();
}

class _HomeScreenCardState extends State<HomeScreenCard> {
  List<bool> isLovedList = List.generate(blogTitle.length, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: blogTitle.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return BlogDetailScreen(
                      title: blogTitle[index],
                      image: blogImages[index],
                      des: blogDis[index],
                    );
                  }));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(fit: BoxFit.fill, image: AssetImage(blogImages[index])),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleText(
                            text: blogTitle[index],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SubTitleText(
                            text: blogDis[index],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: AppColors.primaryLightGrey), shape: BoxShape.circle),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/profile.jpg",
                      ),
                      radius: 20,
                    ),
                  ),
                  CustomTextButton(onclick: () {}, textButtonText: blogPublishBy[index], fontSize: 18),
                  SmallText(
                    text: blogPublished[index],
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      isLovedList[index] ? Icons.favorite : Icons.favorite_border,
                      color: isLovedList[index] ? Colors.red : null,
                    ),
                    onPressed: () {
                      setState(() {
                        isLovedList[index] = !isLovedList[index];
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                thickness: .6,
                color: AppColors.primaryLightGrey,
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 10,
          );
        },
      ),
    );
  }
}
