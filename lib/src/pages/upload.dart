import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_getx/src/components/image_data.dart';
import 'package:insta_getx/src/components/upload_controller.dart';
import 'package:photo_manager/photo_manager.dart';

class Upload extends GetView<UploadController> {
  // @override
  // void initState() {
  //   _loadPhotos();
  //   super.initState();
  // }

  // void update() => setState(() {});

  Widget _imageSelectList() {
    return Obx(()=>GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        // SingleChildScrollView 랑 스크롤이 겹쳐서 여기서의 스크롤을 없애주라
        shrinkWrap: true,
        // 이것까지 해줘야한다.
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
          crossAxisCount: 4,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ),
        itemCount: controller.imageList.length,
        itemBuilder: (BuildContext context, int index) {
          return _photoWidget(controller.imageList[index], 200,
              builder: (data) {
                return GestureDetector(
                  onTap: () {
                    controller.changeSelectedImage(controller.imageList[index]);
                  },
                  child: Obx(() => Opacity(
                    opacity: controller.imageList[index] ==
                        controller.selectedImage.value
                        ? 0.3
                        : 1,
                    child: Image.memory(
                      data,
                      fit: BoxFit.cover,
                    ),
                  )),
                );
              });
        }));
  }

  Widget _photoWidget(AssetEntity asset, int size,
      {required Widget Function(Uint8List) builder}) {
    return FutureBuilder(
        future: asset.thumbDataWithSize(size, size),
        builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
          if (snapshot.hasData) {
            return builder(snapshot.data!);
          } else {
            return Container();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget _imagePreview() {
      var width = MediaQuery.of(context).size.width;
      return Obx(() => Container(
            width: width,
            height: width,
            child: _photoWidget(controller.selectedImage.value, width.toInt(),
                builder: (data) {
              return Image.memory(
                data,
                fit: BoxFit.cover,
              );
            }),
          ));
    }

    Widget _header() {
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  builder: (_) => Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 7),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black54),
                              width: 40,
                              height: 4,
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                                children: List.generate(
                                  controller.albums.length,
                                      (index) => GestureDetector(
                                        onTap: (){
                                          controller.changeAlbum(controller.albums[index]);
                                          Get.back();
                                        },

                                        child: Container(
                                    padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 20),
                                    child:
                                    Text(controller.albums[index].name),
                                  ),
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
Obx(()=>                  Text(
  controller.headerTitle.value,
  style: TextStyle(color: Colors.black, fontSize: 18),
)),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xff808080),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    ImageData(IconsPath.imageSelectIcon),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      '여러 항목 선택',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff808080),
                ),
                child: ImageData(IconsPath.cameraIcon),
              )
            ],
          )
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(IconsPath.closeImage),
          ),
        ),
        title: Text(
          'New Post',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: controller.gotoImageFilter,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.nextImage,
                width: 50,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imagePreview(),
            _header(),
            _imageSelectList(),
          ],
        ),
      ),
    );
  }
}
