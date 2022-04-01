import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_getx/model/instagram_user.dart';
import 'package:insta_getx/src/binding/init_bindings.dart';
import 'package:insta_getx/src/repository/user_repository.dart';

class AuthController extends GetxController {

  static AuthController get to => Get.find();

  Rx<IUser> user = IUser().obs;


  Future<IUser?> loginUser(String uid) async {
    // DB 조회
    var userData = await UserRepository.loginUserByUid(uid);      // uid 로 users collection에 데이터가 있는지...
    if(userData!= null) {
      user(userData);
      InitBinding.additionalBinding();
    }
    return userData;
  }

  void signup(IUser signupUser, XFile? thumbnail) async {
    if(thumbnail==null){
      _submitSignup(signupUser);
    }else {

      var task = uploadXFile(thumbnail, '${signupUser.uid}/profile.${thumbnail.path.split('.').last}');
      task.snapshotEvents.listen((event) async {
            if(event.bytesTransferred == event.totalBytes && event.state == TaskState.success){
              var downloadUrl = await event.ref.getDownloadURL();     // 이미지의 도메인을 받아올 수 있다.
              var updatedUserData = signupUser.copyWith(thumbnail: downloadUrl);
              _submitSignup(updatedUserData);
            }
      });
    }

  }
  UploadTask uploadXFile(XFile file, String filename){
    var f = File(file.path);
    var ref = FirebaseStorage.instance.ref().child('users').child(filename);
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path}
    );

    return ref.putFile(f,metadata);
  }

  void _submitSignup(IUser signupUser)async {
    var result = await UserRepository.signup(signupUser);
    if(result){
      loginUser(signupUser.uid!);
    }
  }
}