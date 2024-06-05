import 'package:blog_app/controllers/image_controller.dart';
import 'package:blog_app/controllers/loading_controller.dart';
import 'package:blog_app/controllers/user_controller.dart';
import 'package:blog_app/screens/splash/splash_screen.dart';
import 'package:blog_app/services/blog_services.dart';
import 'package:blog_app/theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (context) => themeProvider,
      child: const MyApp(),
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      minTextAdapt: true,
      designSize: Size(373, 650),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => LoadingController()),
            ChangeNotifierProvider(create: (_) => ImageController()),
            ChangeNotifierProvider(create: (_) => UserController()),
            ChangeNotifierProvider(create: (_) => BlogServices()),
          ],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Provider.of<ThemeProvider>(context).themeData,
            home: MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.2)),
              child: const SplashScreen(),
            ),
          ),
        );
      },
    );
  }
}
