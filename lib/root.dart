import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:insta_getx/model/instagram_user.dart';
import 'package:insta_getx/src/app.dart';
import 'package:insta_getx/src/controller/auth_controller.dart';
import 'package:insta_getx/src/pages/login.dart';
import 'package:insta_getx/src/pages/signup_page.dart';

class Root extends GetView<AuthController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> user) {    // FirebaseAuth_uid
          if (user.hasData) {
            return FutureBuilder<IUser?>(
                future: controller.loginUser(user.data!.uid),
                builder: (context, snapshot) {                // auth_uid와 같은 uid가 user collection안에 있으면 그 IUser, 없으면 snapshot==null
                  if (snapshot.hasData) {
                    return App();
                  } else {
                    return Obx(() => controller.user.value.uid != null
                        ? const App()
                        : SignupPage(uid: user.data!.uid));
                  }
                });
          } else {
            return const Login();
          }
        });
  }
}
