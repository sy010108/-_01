/*
  <앞으로 구현했으면 하는 기능>
  1. 걸음 수의 변경 값이 정수인지 섭취한 물의 양이 실수인지 확인하는 기능
*/

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kkn_/drawer/drawer.dart';

import 'button.dart';
import 'currency_card.dart';
import 'dto/home_dto.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.homeDto}) : super(key: key);

  final HomeDto homeDto;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String errorMessage = "";

  late String currentDate;

  void pageReload(String message) {
    setState(() {
      errorMessage = message;
    });
  }

  @override
  void initState() {
    super.initState();
    currentDate = DateFormat.yMMMMd().format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Image.asset(
            'assets/logo.png',
            width: 200,
            height: 200,
          ),
          backgroundColor: const Color(0xff9880F7),
          centerTitle: true),
      drawer: AppDrawer(homeDto: widget.homeDto),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 152, 128, 247)
                        .withOpacity(0.3),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color:
                            const Color(0xff9880F7).withOpacity(0.3), // 그림자 색상
                        blurRadius: 8, // 그림자의 흐림 정도
                        offset: const Offset(
                            0, 4), // 세로 오른쪽, 가로 아래쪽 방향으로만 그림자가 나오도록 설정
                      ),
                    ],
                  ),
                  height: 180,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Today's",
                              style: TextStyle(
                                fontSize: 22,
                                color: Color(0xff9880F7),
                              ),
                            ),
                            const SizedBox(width: 25),
                            Text(
                              '${(double.parse(widget.homeDto.consumeCalories)).toStringAsFixed(1)} Kcal',
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff9880F7),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Button(
                              text: '${widget.homeDto.recommandCalories} Kcal',
                              bgColor: Colors.white,
                              textColor: const Color(0xff9880F7),
                            ),
                            Button(
                                text:
                                    '${(((double.parse(widget.homeDto.recommandCalories) - double.parse(widget.homeDto.consumeCalories)).toStringAsFixed(1)))} Kcal',
                                bgColor: Colors.white,
                                textColor: const Color(0xff9880F7)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
          if (errorMessage.isNotEmpty)
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.yellow),
            ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CurrencyCard(
                    name: '식단 기록',
                    code: '',
                    imagePath: 'assets/record.png',
                    isInverted: true, // 컬러반전 시키기
                    order: 0,
                    homeDto: widget.homeDto,
                    homeReloadFunction: pageReload,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CurrencyCard(
                    name: '걸음수',
                    code: 'steps',
                    imagePath: 'assets/wake.png',
                    isInverted: true,
                    order: 1,
                    homeDto: widget.homeDto,
                    homeReloadFunction: pageReload,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CurrencyCard(
                    name: '총거리',
                    code: 'Km',
                    imagePath: 'assets/distance.png',
                    isInverted: true, // 컬러반전 시키기
                    order: 2,
                    homeDto: widget.homeDto,
                    homeReloadFunction: pageReload,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CurrencyCard(
                    name: '물 섭취량',
                    code: 'ml',
                    imagePath: 'assets/water.png',
                    isInverted: true,
                    order: 3,
                    homeDto: widget.homeDto,
                    homeReloadFunction: pageReload,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
