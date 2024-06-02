import 'package:blog_app/constants/app_colors.dart';
import 'package:blog_app/screens/custom_navbar/widgets/bottom_tab_widget.dart';
import 'package:flutter/material.dart';

import '../../constants/lists.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(border: Border(top: BorderSide(color: AppColors.primaryColor))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottomTabWidget(
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
                icon: Icons.home,
                title: "Home",
                activeColor: _currentIndex == 0 ? AppColors.primaryColor : Colors.grey,
              ),
              BottomTabWidget(
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
                icon: Icons.favorite,
                title: "Favourite",
                activeColor: _currentIndex == 1 ? AppColors.primaryColor : Colors.grey,
              ),
              BottomTabWidget(
                onPressed: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
                icon: Icons.add_a_photo,
                title: "Add Blog",
                activeColor: _currentIndex == 2 ? AppColors.primaryColor : Colors.grey,
              ),
              BottomTabWidget(
                onPressed: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
                icon: Icons.notifications,
                title: "Notification",
                activeColor: _currentIndex == 3 ? AppColors.primaryColor : Colors.grey,
              ),
              BottomTabWidget(
                onPressed: () {
                  setState(() {
                    _currentIndex = 4;
                  });
                },
                icon: Icons.settings,
                title: "Settings",
                activeColor: _currentIndex == 4 ? AppColors.primaryColor : Colors.grey,
              ),
            ],
          ),
        ),
      ),
      body: screens[_currentIndex],
    );
  }
}
