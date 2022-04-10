import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_getx/model/instagram_user.dart';
import 'package:insta_getx/src/controller/auth_controller.dart';

class MypageController extends GetxController with GetTickerProviderStateMixin{
  late TabController tabController;
  Rx<IUser> targetUser = IUser().obs;


  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  void setTargetUser(){
    var uid = Get.parameters['targetUid'];      // 다른 사람일때 parameter로 targetUid를 보내서 볼 수 있다.
    if(uid==null){                              // uid가 없으면 내 페이지이다.
      targetUser(AuthController.to.user.value);
    }else {
      //TODO 상대 uid로 users collection 조회
    }
  }

  void _loadData() {
    // 포스트 리스트 로드
    // 사용자 정보 로드
    setTargetUser();
  }
}

