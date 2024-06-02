import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/constants/app_text_style.dart';
import 'package:blog_app/constants/lists.dart';
import 'package:blog_app/screens/home/custom_tabbar_pages/custom_tabbar_all.dart';
import 'package:blog_app/screens/home/custom_tabbar_pages/custom_tabbar_politics.dart';
import 'package:blog_app/screens/home/custom_tabbar_pages/custom_tabbar_sports.dart';
import 'package:blog_app/screens/home/custom_tabbar_pages/custom_tabbar_technology.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int current = 0;

  PageController pageController = PageController();

  List<Widget> tabScreens = [
    CustomTabBarAll(),
    CustomTabBarRecent(),
    CustomTabBarSports(),
    CustomTabBarPolitics(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: TitleText(
          text: "Blog App",
          color: Theme.of(context).colorScheme.primary,
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: tabList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      current = index;
                    });
                    pageController.animateToPage(
                      current,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.ease,
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.all(5),
                    width: 80,
                    decoration: BoxDecoration(
                      color: current == index ? Colors.white70 : Colors.white54,
                      borderRadius:
                          BorderRadius.circular(current == index ? 12 : 7),
                      border: current == index
                          ? Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2.5)
                          : Border.all(
                              color: AppColors.primaryLightGrey, width: 1.5),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tabList[index],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: current == index
                                  ? Colors.black
                                  : Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: PageView.builder(
              itemCount: tabList.length,
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  current = index;
                });
              },
              itemBuilder: (context, index) {
                return tabScreens[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}
