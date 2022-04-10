import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_getx/model/post.dart';
import 'package:insta_getx/src/components/message_popup.dart';
import 'package:insta_getx/src/controller/auth_controller.dart';
import 'package:insta_getx/src/pages/upload/upload_description.dart';
import 'package:insta_getx/src/repository/post_repository.dart';
import 'package:insta_getx/src/utils/data_util.dart';
import 'package:path/path.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:image/image.dart' as imageLib;
import 'package:photofilters/filters/preset_filters.dart';
import 'package:photofilters/widgets/photo_filter.dart';

class UploadController extends GetxController {
  var albums = <AssetPathEntity>[];
  RxString headerTitle = ''.obs;
  TextEditingController textEditingController = TextEditingController();
  RxList<AssetEntity> imageList = <AssetEntity>[].obs;
  Rx<AssetEntity> selectedImage = AssetEntity(
    id: '0',
    width: 0,
    typeInt: 0,
    height: 0,
  ).obs;
  File? filteredImage;
  Post? post;

  @override
  void onInit() {
    _loadPhotos();
    super.onInit();
    post = Post.init(AuthController.to.user.value);
  }

  void _loadPhotos() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      albums = await PhotoManager.getAssetPathList(
          type: RequestType.all, // 이미지든 동영상이든 다든...
          filterOption: FilterOptionGroup(
              imageOption: const FilterOption(
                  sizeConstraint:
                      SizeConstraint(minHeight: 100, minWidth: 100)), // 사진 사이즈
              orders: [
                const OrderOption(type: OrderOptionType.createDate, asc: false),
                // 최신부터 본다.
              ]));
      _loadData();
    } else {
      // message 권한 요청
    }
  }

  void _loadData() {
    changeAlbum(albums.first);
    // update();
  }

  Future<void> _pagingPhotos(AssetPathEntity album) async {
    imageList.clear();
    var photos = await album.getAssetListPaged(0, 30);
    imageList.addAll(photos);
    changeSelectedImage(imageList.first);
  }

  changeSelectedImage(AssetEntity image) {
    selectedImage(image);
  }

  void changeAlbum(AssetPathEntity album) async {
    headerTitle(album.name);
    await _pagingPhotos(album);
  }

  void gotoImageFilter() async {
    var file = await selectedImage.value.file;
    var fileName = basename(file!.path);
    var image = imageLib.decodeImage(file.readAsBytesSync());
    image = imageLib.copyResize(image!, width: 600);
    Map imagefile = await Navigator.push(
      Get.context!,
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          title: const Text("Photo Filter Example"),
          image: image!,
          filters: presetFiltersList,
          filename: fileName,
          loader: const Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      filteredImage = imagefile['image_filtered'];
      Get.to(() => UploadDescription());
    }
  }

  void unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void uploadPost() {
    unfocusKeyboard();
    String filename = DataUtil.makeFilePath();
    var task = uploadFile(
        filteredImage!, '/${AuthController.to.user.value.uid}/${filename}');
    if (task != null) {
      task.snapshotEvents.listen((event) async {
        if (event.bytesTransferred == event.totalBytes &&
            event.state == TaskState.success) {
          var downloadUrl = await event.ref.getDownloadURL();
          var updatedPost = post!.copyWith(
              thumbnail: downloadUrl, description: textEditingController.text);
          _submitPost(updatedPost);
        }
      });
    }
  }

  UploadTask uploadFile(File file, String filename) {
    var ref = FirebaseStorage.instance.ref().child('instagram').child(filename);
    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    return ref.putFile(file, metadata);
  }

  void _submitPost(Post postData) async {
    await PostRepository.updatePost(postData);
    showDialog(
        context: Get.context!,
        builder: (context) => MessagePopup(
              title: '포스트',
              message: '포스팅이 완료되었습니다.',
              okCallback: () {
                Get.until((route) => Get.currentRoute == '/');
              },
            ));
  }
}
