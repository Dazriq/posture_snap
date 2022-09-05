import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'pages/home/home_page.dart';
import 'services/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter with Mediapipe',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
                appBarTheme: const AppBarTheme(
                  elevation: 0.0,
                  color: Colors.transparent,
                ),
              ),
          home: const HomePage(),
        );
      },
      );
  }
}

