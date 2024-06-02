//
// class CustomTabBar extends StatefulWidget {
//   const CustomTabBar({Key? key}) : super(key: key);
//
//   @override
//   State<CustomTabBar> createState() => _CustomTabBarState();
// }
//
// class _CustomTabBarState extends State<CustomTabBar> {
//   int current = 0;
//   PageController pageController = PageController();
//
//   List<Widget> tabScreens = [
//     CustomTabBarAll(),
//     CustomTabBarRecent(),
//     CustomTabBarSports(),
//     CustomTabBarPolitics(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: AppColors.primaryBlue,
//         onPressed: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (_) => AddNewBlog()));
//         },
//         child: Icon(Icons.add),
//         elevation: 0,
//       ),
//       appBar: AppBar(
//         title: TitleText(text: "Blog App", color: AppColors.primaryWhite),
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (_) => NotificationScreen()));
//               },
//               icon: Icon(
//                 Icons.notifications,
//                 color: AppColors.primaryWhite,
//               )),
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                   context, MaterialPageRoute(builder: (_) => FavoriteScreen()));
//             },
//             icon: Icon(
//               Icons.favorite,
//               color: AppColors.primaryWhite,
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                   context, MaterialPageRoute(builder: (_) => ProfileScreen()));
//             },
//             child: Container(
//               margin: EdgeInsets.only(right: 10, left: 10),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: AppColors.primaryLightGrey,
//                   width: 1,
//                 ),
//               ),
//               child: CircleAvatar(
//                 radius: 15.sp,
//                 backgroundImage: AssetImage('assets/profile.jpg'),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             width: double.infinity,
//             height: 40.h,
//             child: ListView.builder(
//               physics: const BouncingScrollPhysics(),
//               itemCount: tabList.length,
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (ctx, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       current = index;
//                     });
//                     pageController.animateToPage(
//                       current,
//                       duration: const Duration(milliseconds: 200),
//                       curve: Curves.ease,
//                     );
//                   },
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 300),
//                     margin: const EdgeInsets.all(5),
//                     width: 80,
//                     decoration: BoxDecoration(
//                       color: current == index ? Colors.white70 : Colors.white54,
//                       borderRadius:
//                       BorderRadius.circular(current == index ? 12 : 7),
//                       border: current == index
//                           ? Border.all(color: AppColors.primaryBlue, width: 2.5)
//                           : Border.all(
//                           color: AppColors.primaryLightGrey, width: 1.5),
//                     ),
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             tabList[index],
//                             style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               color: current == index
//                                   ? Colors.black
//                                   : Colors.grey.shade400,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Expanded(
//             child: PageView.builder(
//               itemCount: tabList.length,
//               controller: pageController,
//               onPageChanged: (index) {
//                 setState(() {
//                   current = index;
//                 });
//               },
//               itemBuilder: (context, index) {
//                 return tabScreens[index];
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
