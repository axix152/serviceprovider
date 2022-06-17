import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/route_manager.dart';
import 'package:serviceprovider/screens/main_screen.dart';
import './screens/splashScreen/splash_Screeen.dart';
import 'screens/authentication/logIn_screen.dart';
import 'screens/authentication/signUp_screen.dart';
import './screens/categories/select_category.dart';
import './screens/categories/detials_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        initialRoute: '/splashScreen',
        getPages: [
          GetPage(name: '/splashScreen', page: () => SplashScreen()),
          GetPage(name: '/logIn', page: () => LogIn()),
          GetPage(name: '/signup', page: () => SignUp()),
          GetPage(name: '/category', page: () => SelectCategory()),
          GetPage(name: '/details', page: () => DetailsScreen()),
          GetPage(name: '/mainScreen', page: () => MainScreen()),
        ],
      ),
    );
  }
}
