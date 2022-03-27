import 'package:flutter/material.dart';
import 'package:insta_getx/src/components/avatar_widget.dart';

class ActiveHistory extends StatelessWidget {
  const ActiveHistory({Key? key}) : super(key: key);

  Widget _activeitemOne() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          AvatarWidget(
              type: AvatarType.TYPE3,
              size: 40,
              thumbPath:
                  "https://helpx.adobe.com/content/dam/help/en/stock/how-to/visual-reverse-image-search/jcr_content/main-pars/image/visual-reverse-image-search-v2_intro.jpg"),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text.rich(TextSpan(
                  text: '동동이',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  children: [
                TextSpan(
                    text: '님이 회원님의 게시물을 좋아합니다.',
                    style: TextStyle(fontWeight: FontWeight.normal)),
                TextSpan(
                    text: '5일 전',
                    style: TextStyle(fontWeight: FontWeight.normal,fontSize: 13,color: Colors.black45))
              ])))
        ],
      ),
    );
  }

  Widget _newRecentlyActiveView(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          _activeitemOne(),
          _activeitemOne(),
          _activeitemOne(),
          _activeitemOne(),
          _activeitemOne(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '활동',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _newRecentlyActiveView('오늘'),
            _newRecentlyActiveView('이번주'),
            _newRecentlyActiveView('이번')
          ],
        ),
      ),
    );
  }
}
