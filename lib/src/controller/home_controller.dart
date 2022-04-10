import 'package:get/get.dart';
import 'package:insta_getx/model/post.dart';
import 'package:insta_getx/src/repository/post_repository.dart';

class HomeController extends GetxController {

  RxList<Post> postList = <Post>[].obs;

  @override
  void onInit() {
    _loadFeedList();
    super.onInit();
  }

  void _loadFeedList() async {
    var feedList = await PostRepository.loadFeedList();
    postList.addAll(feedList);
  }
}