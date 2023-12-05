import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import 'package:kkn_/home/home_controller.dart';
import 'package:kkn_/home/dto/home_dto.dart';
import 'package:kkn_/home/dto/home_response_dto.dart';
import 'package:kkn_/mypage/mypage_controller.dart';
import 'package:kkn_/home/home_view.dart';
import 'package:kkn_/drawer/drawer.dart';
import 'package:kkn_/mypage/dto/mypage_dto.dart';

class MypageView extends StatefulWidget {
  const MypageView({Key? key, required this.homeDto, required this.myPageDto})
      : super(key: key);

  final HomeDto homeDto;
  final MypageDto myPageDto;

  @override
  State<MypageView> createState() => _MypageViewState();
}

class _MypageViewState extends State<MypageView> {
  MypageDto mypageDto = MypageDto("", "", "", "0", "", "");

  bool obscurePassword = true;
  String errorMessage = '';

  String encryptPassword(String? password) {
    if (password == null || password.isEmpty) {
      return '';
    }
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  void updateProcess() async {
    mypageDto.password = encryptPassword(mypageDto.password);

    errorMessage =
        await MypageController().memberupdate(mypageDto, widget.myPageDto);

    if (errorMessage.isEmpty) {
      homePrepareProcess(widget.homeDto.userid);
    } else {
      setState(() {});
    }
  }

  void homePrepareProcess(String userid) async {
    HomeController homeController = HomeController();

    HomeResponseDto homeResponseDto =
        await homeController.homeInformationLoad(userid);

    if (homeResponseDto.errorMessage.isEmpty) {
      toHome(homeResponseDto.homeDto!);
    } else {
      setState(() {
        errorMessage = homeResponseDto.errorMessage;
      });
    }
  }

  void toHome(HomeDto homeDto) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => HomeView(homeDto: homeDto)));
  }

  @override
  void initState() {
    super.initState();

    mypageDto.nickname = widget.myPageDto.nickname;
    mypageDto.email = widget.myPageDto.email;
    mypageDto.gender = widget.myPageDto.gender;
    mypageDto.age = widget.myPageDto.age;
    mypageDto.height = widget.myPageDto.height;
    mypageDto.weight = widget.myPageDto.weight;
    mypageDto.userid = widget.homeDto.userid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Page'),
        backgroundColor: const Color(0xff9880F7),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeView(homeDto: widget.homeDto)),
              );
            },
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      drawer: AppDrawer(homeDto: widget.homeDto),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 204, 205, 210)
                          .withOpacity(0.3),
                      blurRadius: 8, // 그림자의 흐림 정도
                      offset: const Offset(
                          0, 4), // 세로 오른쪽, 가로 아래쪽 방향으로만 그림자가 나오도록 설정
                    ),
                  ],
                ),
                child: TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    prefixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 10,
                          height: 100,
                        ),
                        const Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 25,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.homeDto.userid,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              child: TextFormField(
                controller: TextEditingController(text: mypageDto.password),
                onChanged: (value) {
                  mypageDto.password = value;
                },
                obscureText: obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: "암호",
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  prefixIcon: const Icon(
                    Icons.password_outlined,
                    color: Colors.black,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    icon: obscurePassword
                        ? const Icon(
                            Icons.visibility_outlined,
                            color: Colors.black,
                          )
                        : const Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.black,
                          ),
                  ),
                  // 선을 제거하기 위해 border 속성을 none으로 설정
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              child: TextFormField(
                controller: TextEditingController(text: mypageDto.nickname),
                onChanged: (value) {
                  mypageDto.nickname = value;
                },
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: '닉네임',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  prefixIcon: Icon(
                    Icons.person_pin,
                    color: Colors.black,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              child: TextFormField(
                controller: TextEditingController(text: mypageDto.email),
                onChanged: (value) {
                  mypageDto.email = value;
                },
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: '이메일',
                  labelStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(Icons.email_outlined, color: Colors.black),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              child: DropdownButtonFormField<String>(
                value: mypageDto.gender,
                decoration: const InputDecoration(
                  labelText: '성별',
                  labelStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(Icons.contact_emergency_outlined,
                      color: Colors.black),
                  border: InputBorder.none,
                ),
                items: const [
                  DropdownMenuItem<String>(
                    value: '0',
                    child: Text('남성'),
                  ),
                  DropdownMenuItem<String>(
                    value: '1',
                    child: Text('여성'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    mypageDto.gender = value!;
                  });
                },
                dropdownColor: Colors.white, // 드롭다운 메뉴의 배경색을 검정색으로 설정
                style: const TextStyle(color: Colors.black),
                iconEnabledColor: Colors.black,
                iconDisabledColor: Colors.black,
              ),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              child: TextFormField(
                controller: TextEditingController(text: mypageDto.height),
                onChanged: (value) {
                  mypageDto.height = value;
                },
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: '키',
                  labelStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(Icons.height, color: Colors.black),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              child: TextFormField(
                controller: TextEditingController(text: mypageDto.weight),
                onChanged: (value) {
                  mypageDto.weight = value;
                },
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: '몸무게',
                  labelStyle: TextStyle(color: Colors.black),
                  prefixIcon:
                      Icon(Icons.fitness_center_outlined, color: Colors.black),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              child: TextFormField(
                controller: TextEditingController(text: mypageDto.age),
                onChanged: (value) {
                  mypageDto.age = value;
                },
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: '나이',
                  labelStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(Icons.cake_outlined, color: Colors.black),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.black),
              ),
            const SizedBox(height: 13),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: updateProcess,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff9880F7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          15), // Adjust the value to control the roundness
                    ),
                    fixedSize: const Size(280, 40), // 가로 100, 세로 50 크기로 버튼 설정
                  ),
                  child: const Text('완료'),
                ),
              ],
            ),
            const SizedBox(height: 70.0),
          ],
        ),
      ),
    );
  }
}
