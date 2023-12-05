import 'package:flutter/material.dart';
import 'package:kkn_/community/community_controller.dart';

import 'package:kkn_/home/dto/home_dto.dart';
import 'package:kkn_/community/dto/post_dto.dart';
import 'package:kkn_/community/community_post.dart';
import 'package:kkn_/community/community_card.dart';
import 'package:kkn_/home/home_view.dart';
import 'package:kkn_/drawer/drawer.dart';
import 'package:kkn_/like/like_controller.dart';
import 'package:kkn_/like/dto/like_load_response_dto.dart';
import 'package:kkn_/like/dto/like_load_send_dto.dart';

class CommunityView extends StatefulWidget {
  const CommunityView(
      {Key? key,
      required this.homeDto,
      required this.postList,
      required this.likeCheckList})
      : super(key: key);

  final HomeDto homeDto;
  final List<PostDto> postList;
  final List<dynamic> likeCheckList;

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  List<PostDto> postList = [];
  List<dynamic> likeCheckList = [];

  void postListAddProcess() async {
    List<PostDto> addPostList = await CommunityController()
        .postListAdd(postList[postList.length - 1].writeDateTimeStamp);

    postList.addAll(addPostList);

    List<int> postNumList = postNumSelect(addPostList);
    LikeLoadResponseDto likeLoadResponseDto = await LikeController()
        .likeCheckListLoad(LikeLoadSendDto(widget.homeDto.userid, postNumList));

    likeCheckList.addAll(likeLoadResponseDto.likeCheckList);
  }

  List<int> postNumSelect(List<PostDto> postList) {
    List<int> postNumList = [];
    for (PostDto post in postList) {
      postNumList.add(int.parse(post.num));
    }

    return postNumList;
  }

  @override
  void initState() {
    super.initState();

    postList = widget.postList;
    likeCheckList = widget.likeCheckList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '커뮤니티',
        ),
        backgroundColor: const Color(0xff9880F7),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeView(homeDto: widget.homeDto),
                ),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      drawer: AppDrawer(homeDto: widget.homeDto),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollNotification) {
          if (scrollNotification is ScrollEndNotification) {
            final before = scrollNotification.metrics.extentBefore;
            final max = scrollNotification.metrics.maxScrollExtent;
            if (before == max) {
              postListAddProcess();

              setState(() {});
              return true;
            }
          }
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
          child: ListView.builder(
            itemCount: postList.length,
            itemBuilder: (context, index) {
              return PostCard(
                  homeDto: widget.homeDto,
                  post: postList[index],
                  isLike: likeCheckList[index]);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Post(homeDto: widget.homeDto),
            ),
          );
        },
        backgroundColor: const Color(0xff9880F7),
        mini: true,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
