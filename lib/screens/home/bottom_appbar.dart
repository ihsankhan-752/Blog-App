import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/screens/home/add_blog.dart';
import 'package:blog_app/screens/home/custom_tabbar.dart';
import 'package:blog_app/screens/home/favorites_screen.dart';
import 'package:blog_app/screens/home/notification/notification_screen.dart';
import 'package:blog_app/screens/home/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomAppBar extends StatefulWidget {
  const CustomBottomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int current = 0;
  PageController pageController = PageController();
  List<Widget> bottomScreens = [
    CustomTabBar(),
    FavoriteScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: PageView.builder(
        itemCount: bottomScreens.length,
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            current = index;
          });
        },
        itemBuilder: (context, index) {
          return bottomScreens[index];
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Theme.of(context).colorScheme.primary,
        height: 45.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  current = 0;
                  pageController.jumpToPage(current);
                });
              },
              icon: Icon(Icons.home),
              color: current == 0 ? AppColors.primaryWhite : Colors.white54,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  current = 1;
                  pageController.jumpToPage(current);
                });
              },
              icon: Icon(Icons.favorite),
              color: current == 1 ? AppColors.primaryWhite : Colors.white54,
            ),
            SizedBox(width: 48),
            IconButton(
              onPressed: () {
                setState(() {
                  current = 2;
                  pageController.jumpToPage(current);
                });
              },
              icon: Icon(Icons.notifications),
              color: current == 2 ? AppColors.primaryWhite : Colors.white54,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  current = 3;
                  pageController.jumpToPage(current);
                });
              },
              icon: Icon(Icons.person),
              color: current == 3 ? AppColors.primaryWhite : Colors.white54,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddNewBlog()),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white54,
        ),
        elevation: 0,
      ),
    );
  }
}
