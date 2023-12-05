/*
  <앞으로 구현했으면 하는 기능>
  1. 회원가입 성공과 실패에 관한 메시지 출력
  2. ID 중복 확인
  3. e-mail 형식에 맞지 않게 쓰면 회원가입 거부
  4. height, weight의 값이 실수가 아니면 회원가입 거부
  5. age의 값이 정수가 아니면 회원가입 거부
  6. password 암호화
*/
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:kkn_/signup/signup_controller.dart';
import 'package:kkn_/signup/signup_dto.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  SignupDto newMember = SignupDto("", "", "", "", "0", "", "", "");

  bool obscurePassword = true;
  String errorMessage = "";

  String encryptPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);

    return digest.toString();
  }

  void signupProcess() async {
    SignupController signupController = SignupController();

    newMember.password = encryptPassword(newMember.password);
    errorMessage = await signupController.memberSignup(newMember);

    if (errorMessage.isEmpty) {
      toLogin();
    } else {
      setState(() {});
    }
  }

  void toLogin() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: 800,
          height: 800,
          decoration: const BoxDecoration(
            color: Color(0xff9880F7),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '회원가입',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.08,
                child: TextFormField(
                  controller: TextEditingController(text: newMember.userid),
                  onChanged: (value) {
                    newMember.userid = value;
                  },
                  keyboardType: TextInputType.name,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 6,
                  decoration: InputDecoration(
                    labelText: 'ID',
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon:
                        const Icon(Icons.person_outline, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.08,
                child: TextFormField(
                  controller: TextEditingController(text: newMember.password),
                  onChanged: (value) {
                    newMember.password = value;
                  },
                  obscureText: obscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "암호",
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
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.08,
                child: TextFormField(
                  controller: TextEditingController(text: newMember.nickname),
                  onChanged: (value) {
                    newMember.nickname = value;
                  },
                  keyboardType: TextInputType.name,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: '닉네임',
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon:
                        const Icon(Icons.person_pin, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.08,
                child: TextFormField(
                  controller: TextEditingController(text: newMember.email),
                  onChanged: (value) {
                    newMember.email = value;
                  },
                  keyboardType: TextInputType.name,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: '이메일',
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon:
                        const Icon(Icons.email_outlined, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: DropdownButtonFormField<String>(
                      value: newMember.gender,
                      decoration: InputDecoration(
                        labelText: '성별',
                        labelStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(Icons.contact_emergency_outlined,
                            color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.5),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem<String>(
                          value: '0',
                          child: Text(
                            'Male',
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: '1',
                          child: Text('Female'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          newMember.gender = value!;
                        });
                      },
                      dropdownColor: const Color(0xff9880F7),
                      style: const TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.white,
                      iconDisabledColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: TextFormField(
                      controller: TextEditingController(text: newMember.age),
                      onChanged: (value) {
                        newMember.age = value;
                      },
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: '나이',
                        labelStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(Icons.cake_outlined,
                            color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.08,
                child: TextFormField(
                  controller: TextEditingController(text: newMember.height),
                  onChanged: (value) {
                    newMember.height = value;
                  },
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: '키 (단위: cm)',
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(Icons.height, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.08,
                child: TextFormField(
                  controller: TextEditingController(text: newMember.weight),
                  onChanged: (value) {
                    newMember.weight = value;
                  },
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: '체중 (단위: kg)',
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(Icons.fitness_center_outlined,
                        color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.yellow),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: signupProcess,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff9880F7),
                    ),
                    child: const Text('회원가입'),
                  ),
                  const SizedBox(width: 50.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff9880F7),
                    ),
                    child: const Text('취소'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
