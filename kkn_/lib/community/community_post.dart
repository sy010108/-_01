import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kkn_/community/community_controller.dart';
import 'package:kkn_/home/dto/home_dto.dart';
import 'package:kkn_/community/dto/post_save_dto.dart';
import 'package:kkn_/community/dto/post_dto.dart';
import 'package:kkn_/community/community_view.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:multi_image_picker/multi_image_picker.dart';

import '../like/dto/like_load_response_dto.dart';
import '../like/dto/like_load_send_dto.dart';
import '../like/like_controller.dart';

class Post extends StatefulWidget {
  const Post({Key? key, required this.homeDto}) : super(key: key);

  final HomeDto homeDto;

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  PostSaveDto community = PostSaveDto("", "", "", "0", "");

  String errorMessage = '';
  List<Asset> _images = [];

  void _pickImage() async {
    List<Asset> resultList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: _images,
        cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: const MaterialOptions(
          actionBarColor: "#9880F7",
          actionBarTitle: "Select Images",
          allViewTitle: "All",
          useDetailsView: true,
          selectCircleStrokeColor: "#9880F7",
        ),
      );
    } on Exception catch (e) {
      Logger().e(e);
    }

    if (resultList.isNotEmpty) {
      setState(() {
        _images = resultList;
      });
    } else {
      return;
    }
  }

  Future<String> _uploadImage(List<Asset> images) async {
    Logger().i('Inside _uploadImage function');

    if (images.isEmpty) {
      Logger().i('Image list is null or empty.');
      return '';
    }
    final uri = Uri.parse('http://172.29.201.185.204:8080/community/upload');
    final request = http.MultipartRequest('POST', uri);
    final userid = widget.homeDto.userid;

    for (Asset imageAsset in images) {
      ByteData byteData = await imageAsset.getByteData();
      List<int> imageData = byteData.buffer.asUint8List();

      http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
          'images', imageData,
          filename: 'image${DateTime.now().millisecondsSinceEpoch}.jpg');

      request.files.add(multipartFile);
    }
    request.fields['userid'] = userid;

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        Logger().i('Image upload success');
        final responseData = await response.stream.bytesToString();
        Logger().i(responseData);
        return responseData;
      } else {
        Logger().e('Image upload failed with code ${response.statusCode}');
      }
    } catch (error) {
      Logger().e('Error uploading image: ${error.toString()}');
    }
    return '';
  }

  void createProcess() async {
    String imageUrl = await _uploadImage(_images);
    if (imageUrl.isNotEmpty) {
      community.imageurl = imageUrl;
    } else {
      community.imageurl = '';
    }

    CommunityController communityController = CommunityController();
    errorMessage = await communityController.postCreate(community);

    if (errorMessage.isEmpty) {
      List<PostDto> postList = await communityController.postListLoad(
          DateTime.now().add(const Duration(seconds: 2)).toString());

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

  @override
  Widget build(BuildContext context) {
    community.userid = widget.homeDto.userid;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '새 포스트 작성',
        ),
        backgroundColor: const Color(0xff9880F7),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: TextEditingController(text: community.title),
              onChanged: (value) {
                community.title = value;
              },
              keyboardType: TextInputType.name,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: '제목',
                labelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              ),
            ),
          ),
          SizedBox(
            width: 300,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: TextFormField(
                controller: TextEditingController(text: community.content),
                onChanged: (value) {
                  community.content = value;
                },
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.black),
                maxLines: null,
                decoration: InputDecoration(
                  labelText: '내용',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 100),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _pickImage,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff9880F7),
            ),
            child: const Text(
              '이미지 업로드',
            ),
          ),
          if (_images.isNotEmpty)
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemCount: _images.length,
                itemBuilder: (BuildContext context, int index) {
                  Asset asset = _images[index];
                  return AssetThumb(
                    asset: asset,
                    width: 600,
                    height: 600,
                  );
                },
              ),
            ),
          const SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: createProcess,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff9880F7),
                ),
                child: const Text(
                  '등록',
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff9880F7),
                ),
                child: const Text(
                  '취소',
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
