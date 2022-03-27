import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_getx/root.dart';
import 'package:insta_getx/src/app.dart';
import 'package:insta_getx/src/binding/init_bindings.dart';

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
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(color: Colors.black))),
      initialBinding: InitBinding(),
      home: Root(),
      // initialRoute: "/",
      // getPages: [
      //   GetPage(name: "/", page: ()=> App(), transition: Transition.zoom),
      // ],
    );
  }
}
