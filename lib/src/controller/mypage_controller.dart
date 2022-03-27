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
    var uid = Get.parameters['targetUid'];
    if(uid==null){
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