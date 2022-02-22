import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_getx/src/components/image_data.dart';
import 'package:insta_getx/src/controller/bottom_nav_controller.dart';

class SearchFocus extends StatefulWidget {
  const SearchFocus({Key? key}) : super(key: key);

  @override
  _SearchFocusState createState() => _SearchFocusState();
}

class _SearchFocusState extends State<SearchFocus>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  Widget _tabMenuOne(String menu) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Text(
        menu,
        style: TextStyle(fontSize: 15, color: Colors.black),
      ),
    );
  }

  PreferredSizeWidget _tabMenu() {
    return PreferredSize(
      child: Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xffe4e4e4)))),
        height: 50,
        width: Size.infinite.width,
        child: TabBar(
          controller: tabController,
          tabs: [
            _tabMenuOne('인기'),
            _tabMenuOne('계정'),
            _tabMenuOne('오디오'),
            _tabMenuOne('태그'),
            _tabMenuOne('장소'),
          ],
          indicatorColor: Colors.black,
        ),
      ),
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
    );
  }

  Widget _body() {
    return Container(
      child: TabBarView(
          controller: tabController,
          children: [
            Container(child: Center(child: Text('인기페이지'))),
            Container(child: Center(child: Text('계정페이지'))),
            Container(child: Center(child: Text('오디오페이지'))),
            Container(child: Center(child: Text('태그페이지'))),
            Container(child: Center(child: Text('장페이지'))),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: BottomNavController.to.willPopAction,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(IconsPath.backBtnIcon),
          ),
        ),
        titleSpacing: 0,
        title: Container(
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xffefef)),
            child: const TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '검색',
                contentPadding: EdgeInsets.only(left: 15, top: 7, bottom: 7),
                isDense: true,
              ),
            )),
        bottom: _tabMenu(),
      ),
      body: _body(),
    );
  }
}
