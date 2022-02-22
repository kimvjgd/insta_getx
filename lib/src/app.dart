import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_getx/src/components/image_data.dart';
import 'package:insta_getx/src/controller/bottom_nav_controller.dart';
import 'package:insta_getx/src/pages/home.dart';
import 'package:insta_getx/src/pages/search.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Obx(()=>Scaffold(
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [
              const Home(),
              Navigator(
                key: controller.searchPageNavigationKey,
                onGenerateRoute: (routeSetting){
                  return MaterialPageRoute(builder: (context)=> const Search());
                },
              ),
              Container(child: Center(child: Text('Upload'))),
              Container(child: Center(child: Text('Activity'))),
              Container(child: Center(child: Text('My Page'))),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: controller.pageIndex.value,
            elevation: 0,
            onTap: controller.changeBottomNav,
            items: [
              BottomNavigationBarItem(
                  icon: ImageData(IconsPath.homeOff),
                  activeIcon: ImageData(IconsPath.homeOn),
                  label: ''),
              BottomNavigationBarItem(
                  icon: ImageData(IconsPath.searchOff),
                  activeIcon: ImageData(IconsPath.searchOn),
                  label: ''),
              BottomNavigationBarItem(
                  icon: ImageData(IconsPath.uploadIcon), label: ''),
              BottomNavigationBarItem(
                  icon: ImageData(IconsPath.activeOff),
                  activeIcon: ImageData(IconsPath.activeOn),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey)),
                  label: ''),
            ],
          ),
        )),
        onWillPop: controller.willPopAction);
  }
}
