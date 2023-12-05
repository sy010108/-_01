import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:kkn_/comment/comment_controller.dart';
import 'package:kkn_/comment/dto/comment_input_dto.dart';
import 'package:kkn_/comment/dto/comment_list_add_send_dto.dart';
import 'package:kkn_/comment/dto/comment_load_dto.dart';
import 'package:kkn_/home/dto/home_dto.dart';
import 'package:kkn_/community/community_controller.dart';
import 'package:kkn_/community/dto/post_save_dto.dart';
import 'package:kkn_/community/dto/post_dto.dart';
import 'package:kkn_/community/community_view.dart';
import 'package:kkn_/like/like_controller.dart';
import 'package:kkn_/like/dto/like_load_response_dto.dart';
import 'package:kkn_/like/dto/like_load_send_dto.dart';
import 'package:kkn_/like/dto/like_save_delete_send_dto.dart';

class PostCard extends StatefulWidget {
  const PostCard(
      {Key? key,
      required this.homeDto,
      required this.post,
      required this.isLike})
      : super(key: key);

  final HomeDto homeDto;
  final PostDto post;
  final bool isLike;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  PostSaveDto community = PostSaveDto("", "", "", "", "");
  CommentInputDto newComment = CommentInputDto("", "", "");

  String errorMessage = "";

  bool isLike = true;

  List<CommentLoadDto>? commentList;

  bool showMoreCommentsButton = true;

  void deleteProcess() async {
    CommunityController communityController = CommunityController();

    errorMessage = await communityController.postDelete(
        widget.homeDto.userid, widget.post.userid, int.parse(widget.post.num));

    if (errorMessage.isEmpty) {
      List<PostDto> postList =
          await communityController.postListLoad(DateTime.now().toString());

      List<int> postNumList = postNumSelect(postList);
      LikeLoadResponseDto likeLoadResponseDto = await LikeController()
          .likeCheckListLoad(
              LikeLoadSendDto(widget.homeDto.userid, postNumList));

      toCommunity(widget.homeDto, postList, likeLoadResponseDto.likeCheckList);
    } else {
      setState(() {});
    }
  }

  List<int> postNumSelect(List<PostDto> postList) {
    List<int> postNumList = [];
    for (PostDto post in postList) {
      postNumList.add(int.parse(post.num));
    }

    return postNumList;
  }

  void toCommunity(
      HomeDto homeDto, List<PostDto> postList, List<dynamic> likeCheckList) {
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

  void likeClickProcess() async {
    LikeController likeController = LikeController();

    LikeSaveDeleteSendDto likeSaveSendDto =
        LikeSaveDeleteSendDto(widget.homeDto.userid, widget.post.num);

    if (isLike) {
      errorMessage = await likeController.likeCheckListDelete(likeSaveSendDto);
    } else {
      errorMessage = await likeController.likeCheckListSave(likeSaveSendDto);
    }

    if (errorMessage.isEmpty) {
      setState(() {
        if (isLike) {
          widget.post.likes--;
          isLike = false;
        } else {
          widget.post.likes++;
          isLike = true;
        }
      });
    }
  }

  void commentCreate() async {
    CommentController commentController = CommentController();

    errorMessage = await commentController.commentSave(newComment);

    if (errorMessage.isEmpty) {
      CommunityController communityController = CommunityController();

      List<PostDto> postList =
          await communityController.postListLoad(DateTime.now().toString());

      List<int> postNumList = postNumSelect(postList);
      LikeLoadResponseDto likeLoadResponseDto = await LikeController()
          .likeCheckListLoad(
              LikeLoadSendDto(widget.homeDto.userid, postNumList));

      toCommunity(widget.homeDto, postList, likeLoadResponseDto.likeCheckList);
    }
  }

  void windowClose() {
    newComment.content = "";

    Navigator.of(context).pop();
  }

  void commentListAddProcess() async {
    List<CommentLoadDto> addCommentList = await CommentController()
        .commentListAddProcess(CommentListAddSendDto(widget.post.num,
            commentList![commentList!.length - 1].commentWriteTimeStamp));

    commentList!.addAll(addCommentList);
    if (commentList!.length < 2) {
      showMoreCommentsButton = true;
    } else {
      showMoreCommentsButton = false;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    isLike = widget.isLike;
    commentList = widget.post.commentList;
  }

  @override
  Widget build(BuildContext context) {
    newComment.postNum = widget.post.num;
    newComment.userid = widget.homeDto.userid;
    bool isMyPost = widget.post.userid == widget.homeDto.userid;
    bool showMoreCommentsButton = true;
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Colors.white,
        ),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 5),
                Text(
                  widget.post.nickname,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff9880F7),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ' ${widget.post.title}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  if (isMyPost)
                    TextButton(
                      onPressed: deleteProcess,
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                ],
              ),
            ),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.black),
              ),
            if (widget.post.imageBase64List != null &&
                widget.post.imageBase64List!.isNotEmpty)
              Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: widget.post.imageBase64List!.length,
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return Image.memory(
                        base64Decode(widget.post.imageBase64List![index]),
                        height: 600,
                        width: 600,
                        fit: BoxFit.cover,
                      );
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 1.0,
                      enableInfiniteScroll: false,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Row(
                children: [
                  Text(
                    widget.post.content,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: likeClickProcess,
                  icon: isLike
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border),
                  color: isLike ? Colors.red : Colors.red,
                ),
                Text(
                  widget.post.likes.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: const Text('댓글',
                              style: TextStyle(color: Colors.black)),
                          content: TextFormField(
                            controller:
                                TextEditingController(text: newComment.content),
                            onChanged: (value) {
                              newComment.content = value;
                            },
                            decoration: const InputDecoration(
                              hintText: '댓글을 작성하세요',
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: windowClose,
                              child: const Text(
                                '취소',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: commentCreate,
                              child: const Text(
                                '추가',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.comment),
                  color: Colors.black,
                ),
                const SizedBox(width: 130),
                if (showMoreCommentsButton && commentList!.length >= 2)
                  TextButton(
                    onPressed: commentListAddProcess,
                    child: const Text(
                      'more',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                  ),
              ],
            ),
            const Divider(color: Color(0xff9880F7), thickness: 2),
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (CommentLoadDto commentLoadDto in commentList!)
                      SizedBox(
                        width: 300,
                        child: Text(
                          '${commentLoadDto.nickname}: ${commentLoadDto.comments}',
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),
                      ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
