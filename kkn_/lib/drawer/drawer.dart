import 'package:flutter/material.dart';

import 'package:kkn_/community/dto/post_dto.dart';
import 'package:kkn_/community/community_controller.dart';
import 'package:kkn_/home/dto/home_dto.dart';
import 'package:kkn_/home/home_view.dart';
import 'package:kkn_/community/community_view.dart';
import 'package:kkn_/like/like_controller.dart';
import 'package:kkn_/like/dto/like_load_response_dto.dart';
import 'package:kkn_/like/dto/like_load_send_dto.dart';
import 'package:kkn_/login/login_view.dart';
import 'package:kkn_/calendar/calendar_view.dart';
import 'package:kkn_/mypage/dto/mypage_dto.dart';
import 'package:kkn_/mypage/dto/mypage_response_dto.dart';
import 'package:kkn_/mypage/mypage_controller.dart';
import 'package:kkn_/mypage/mypage_view.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key, required this.homeDto}) : super(key: key);

  final HomeDto homeDto;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  void myPageViewPrepare() async {
    MypageResponseDto mypageResponseDto =
        await MypageController().memberInformationLoad(widget.homeDto.userid);

    if (mypageResponseDto.errorMessage.isEmpty) {
      toMyPageView(mypageResponseDto.mypageDto!);
    }
  }

  void toMyPageView(MypageDto myPageDto) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MypageView(homeDto: widget.homeDto, myPageDto: myPageDto),
      ),
    );
  }

  void communityViewPrepare() async {
    List<PostDto> postList =
        await CommunityController().postListLoad(DateTime.now().toString());

    List<int> postNumList = postNumSelect(postList);
    LikeLoadResponseDto likeLoadResponseDto = await LikeController()
        .likeCheckListLoad(LikeLoadSendDto(widget.homeDto.userid, postNumList));

    toCommunity(postList, likeLoadResponseDto.likeCheckList);
  }

  List<int> postNumSelect(List<PostDto> postList) {
    List<int> postNumList = [];
    for (PostDto post in postList) {
      postNumList.add(int.parse(post.num));
    }

    return postNumList;
  }

  void toCommunity(List<PostDto> postList, List<dynamic> likeCheckList) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CommunityView(
            homeDto: widget.homeDto,
            postList: postList,
            likeCheckList: likeCheckList),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xff9880F7),
            ),
            child: Image.asset('assets/logo.png'),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.grey[850],
            ),
            title: const Text('홈',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeView(homeDto: widget.homeDto),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Colors.grey[850],
            ),
            title: const Text('마이 페이지',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
            onTap: myPageViewPrepare,
          ),
          ListTile(
              leading: Icon(
                Icons.people,
                color: Colors.grey[850],
              ),
              title: const Text('커뮤니티',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
              onTap: communityViewPrepare),
          ListTile(
            leading: Icon(
              Icons.calendar_month,
              color: Colors.grey[850],
            ),
            title: const Text('건강 기록',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CalendarView(homeDto: widget.homeDto),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.grey[850],
            ),
            title: const Text('로그아웃',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
              );
            },
          ),
        ],
      ),
    );
  }
}
