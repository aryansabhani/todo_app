import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/heloper/helper.dart';
import 'package:todo_app/heloper/themeHelper.dart';
import 'package:todo_app/screen/add_todo.dart';
import 'package:todo_app/screen/home_screen.dart';
import 'package:todo_app/screen/login.dart';
import 'package:todo_app/screen/regitter.dart';
import 'package:todo_app/screen/splesh_screen.dart';
import 'package:todo_app/screen/upd_todo.dart';
import 'package:todo_app/screen/view_todo.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ApiHelper.apihelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Color(0xff5949F0)),
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Color(0xff5949F0),),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

        useMaterial3: true,
      ),
      // themeMode: ThemeHelper.isdark ? ThemeMode.dark : ThemeMode.light,
      getPages: [
        GetPage(
          name: '/',
          page: () => AnimatedSplas(),
        ),
        GetPage(
          name: '/login',
          page: () => Login(),
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/register',
          page: () => Register(),
        ),
        GetPage(
          name: '/addTodo',
          page: () => AddTodo(),
        ),GetPage(
          name: '/updtodo',
          page: () => UpdTodo(),
        ),GetPage(
          name: '/tODOView',
          page: () => TODOView(),
        ),
      ],
    );
  }
}
