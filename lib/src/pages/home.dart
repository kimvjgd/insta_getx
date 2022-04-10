import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_getx/src/components/avatar_widget.dart';
import 'package:insta_getx/src/components/image_data.dart';
import 'package:insta_getx/src/components/post_widget.dart';
import 'package:insta_getx/src/controller/home_controller.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  Widget _myStory() {
    return Stack(
      children: [
        AvatarWidget(
            type: AvatarType.TYPE2,
            size: 70,
            thumbPath:
                'https://www.akamai.com/content/dam/site/im-demo/perceptual-standard.jpg?imbypass=true'),
        Positioned(
            right: 5,
            bottom: 0,
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  border: Border.all(color: Colors.white, width: 2)),
              child: const Center(
                child: Text(
                  '+',
                  style:
                      TextStyle(fontSize: 20, color: Colors.white, height: 1.1),
                ),
              ),
            )),
      ],
    );
  }

  Widget _storyBoardList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            height: 20,
          ),
          _myStory(),
          SizedBox(
            height: 5,
          ),
          ...List.generate(
              100,
              (index) => AvatarWidget(
                  type: AvatarType.TYPE1,
                  thumbPath:
                      'https://cafeptthumb-phinf.pstatic.net/MjAyMjAyMjJfMjAz/MDAxNjQ1NDk1NDg4MTA1.vftMXqleBRPOoEsZmscskGx2z8W65im0GMjXG5jeZQkg.E81cTKANXvPbv0yD3LAUC0C4bT5PjD4zBDqKDOJkpqMg.PNG/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2022-02-22_%EC%98%A4%EC%A0%84_11.03.47.png?type=w1600'))
        ],
      ),
    );
  }

  Widget _postList() {
    return Obx(()=>Column(
      children: List.generate(controller.postList.length, (index) => PostWidget(post: controller.postList[index])).toList(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: ImageData(
          IconsPath.logo,
          width: 270,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.directMessage,
                width: 50,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          _storyBoardList(),
          _postList(),
        ],
      ),
    );
  }
}
