import '../screens/custom_navbar/add_blog/add_blog_screen.dart';
import '../screens/custom_navbar/favourite/favorites_screen.dart';
import '../screens/custom_navbar/home/home_screen.dart';
import '../screens/custom_navbar/notification/notification_screen.dart';
import '../screens/custom_navbar/settings/profile_screen.dart';

List<String> blogTitle = [
  "How to choose the right colors",
  "My methods of mixing paints",
  "Me and my easels",
  "My bright House",
  "Something you should Know",
  "Tips that will change your life",
];

List<String> blogImages = [
  "assets/0.jpg",
  "assets/1.jpg",
  "assets/2.jpg",
  "assets/1.jpg",
  "assets/0.jpg",
  "assets/2.jpg",
];

List<String> blogDis = [
  "Understand the color psychology and Colors can have a profound",
  "For me, this is real magic. Just me and paints",
  "My story Begins in childhood, when I was given my first",
  "Have you ever wondered you have house and that could",
  "For me, this is real magic. Just me and paints",
  "For me, this is real magic. Just me and paints",
];

List<String> tabList = [
  "Technology",
  "Sports",
  "Politics",
  "Health and Wellness",
  "Travel",
  "Food and Recipes",
  "Personal Development",
  "Finance and Business",
  "Education",
  "Parenting and Family",
];

final List<String> communityLogos = [
  "assets/0.jpg",
  "assets/1.jpg",
  "assets/2.jpg",
  "assets/0.jpg",
  "assets/2.jpg",
  "assets/1.jpg",
];

List screens = [
  HomeScreen(),
  FavoriteScreen(),
  AddBlogScreen(),
  NotificationScreen(),
  ProfileScreen(),
];
