import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/constants/app_text_style.dart';
import 'package:blog_app/constants/lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<bool> isLovedList = List.generate(blogTitle.length, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: AppColors.primaryWhite),
        title: TitleText(
          text: "My Favorites",
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: ListView.separated(
        itemCount: blogImages.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ListTile(
                shape: Border(
                    bottom: BorderSide(
                        color: AppColors.primaryLightGrey.withOpacity(.21))),
                leading: GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(right: 10, left: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryLightGrey,
                        width: 1,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 15.sp,
                      backgroundImage: AssetImage(blogImages[index]),
                    ),
                  ),
                ),
                title: TitleText(
                  text: blogTitle[index],
                ),
                subtitle: SubTitleText(
                  text: blogDis[index],
                ),
                trailing: IconButton(
                  icon: Icon(
                    isLovedList[index] ? Icons.favorite_border : Icons.favorite,
                    color: isLovedList[index] ? null : Colors.red,
                  ),
                  onPressed: () {
                    setState(() {
                      isLovedList[index] = !isLovedList[index];
                    });
                  },
                ),
              )
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
