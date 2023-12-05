import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../home/home_controller.dart';
import '../home/dto/home_dto.dart';
import '../home/dto/home_response_dto.dart';
import '../home/home_view.dart';
import '../signup/signup_view.dart';
import 'login_controller.dart';
import 'login_input_dto.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginInputDto member = LoginInputDto("", "");

  bool obscurePassword = true;
  String errorMessage = "";

  void loginProcess() async {
    // 비밀번호를 암호화합니다
    var bytes = utf8.encode(member.password);
    var digest = sha256.convert(bytes);
    String encryptedPassword = digest.toString();
    // 암호화된 비밀번호를 서버에 전송합니다
    LoginInputDto encryptedMember =
        LoginInputDto(member.userid, encryptedPassword);
    Logger().i(encryptedPassword);
    LoginController loginController = LoginController();
    errorMessage = await loginController.memberLogin(encryptedMember);

    if (errorMessage.isEmpty) {
      homePrepareProcess(encryptedMember.userid);
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xff9880F7),
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage('assets/logo.png'),
                      width: 500,
                      height: 150,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: TextFormField(
                      controller: TextEditingController(text: member.userid),
                      onChanged: (value) {
                        member.userid = value;
                      },
                      keyboardType: TextInputType.name,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'ID',
                        labelStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(Icons.person_outline,
                            color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: TextFormField(
                      controller: TextEditingController(text: member.password),
                      onChanged: (value) {
                        member.password = value;
                      },
                      obscureText: obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(Icons.password_outlined,
                            color: Colors.white),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          icon: obscurePassword
                              ? const Icon(Icons.visibility_outlined,
                                  color: Colors.white)
                              : const Icon(Icons.visibility_off_outlined,
                                  color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  if (errorMessage.isNotEmpty)
                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.black),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: loginProcess,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff9880F7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                15), // Adjust the value to control the roundness
                          ),
                          fixedSize: const Size(90, 40),
                        ),
                        child: const Text('Login'),
                      ),
                      const SizedBox(width: 40.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupView()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff9880F7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          fixedSize: const Size(90, 40),
                        ),
                        child: const Text('SignUp'),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
