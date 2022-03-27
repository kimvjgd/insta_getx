import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_getx/src/components/avatar_widget.dart';
import 'package:insta_getx/src/components/image_data.dart';
import 'package:insta_getx/src/components/user_card.dart';
import 'package:insta_getx/src/controller/auth_controller.dart';
import 'package:insta_getx/src/controller/mypage_controller.dart';

class MyPage extends GetView<MypageController> {
  const MyPage({Key? key}) : super(key: key);


  Widget _statisticsOne(String title, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _information() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Obx(()=>Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AvatarWidget(
                type: AvatarType.TYPE3,
                thumbPath:
                controller.targetUser.value.thumbnail!,
                size: 80,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _statisticsOne('Post', 15),
                    _statisticsOne('Followers', 2365),
                    _statisticsOne('Followings', 3),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Text(
            controller.targetUser.value.description!,
            style: TextStyle(fontSize: 13, color: Colors.black),
          )
        ],
      )),
    );
  }

  Widget _menu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  color: Color(0xffdedede),
                ),
              ),
              child: Text(
                'Edit profile',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                color: Color(0xffdedede),
              ),
              color: const Color(0xffefefef),
            ),
            child: ImageData(IconsPath.addFriend),
          )
        ],
      ),
    );
  }

  Widget _discoverPeople() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Discover People',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black),
              ),
              Text(
                'See All',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.blue),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: List.generate(
                10,
                    (index) =>
                    UserCard(
                        userId: '동동이$index',
                        description: '동동이$index 님이 팔로우합니다.')).toList(),
          ),
        ),
      ],
    );
  }

  Widget _tabMenu() {
    return TabBar(
        controller: controller.tabController,
        indicatorColor: Colors.black,
        indicatorWeight: 2,
        tabs: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ImageData(IconsPath.gridViewOn),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ImageData(IconsPath.myTagImageOff),
          ),
        ]);
  }

  Widget _tabView() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 100,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.grey,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Obx(()=>Text(
          controller.targetUser.value.nickname?? '',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        )),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: ImageData(
                IconsPath.uploadIcon,
                width: 50,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.menuIcon,
                width: 50,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _information(),
            _menu(),
            _discoverPeople(),
            SizedBox(
              height: 20,
            ),
            _tabMenu(),
            _tabView(),
          ],
        ),
      ),
    );
  }
}
