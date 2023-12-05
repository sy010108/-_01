import 'package:flutter/material.dart';

import '../camera/camera_image.dart';
import 'home_controller.dart';
import 'dto/home_dto.dart';

class CurrencyCard extends StatefulWidget {
  const CurrencyCard({
    Key? key,
    required this.homeDto,
    required this.homeReloadFunction,
    required this.name,
    required this.code,
    required this.imagePath,
    required this.isInverted,
    required this.order,
  }) : super(key: key);

  final HomeDto homeDto;
  final Function homeReloadFunction;

  final String name;
  final String code;
  final String imagePath;
  final bool isInverted;
  final int order;

  @override
  State<CurrencyCard> createState() => _CurrencyCardState();
}

class _CurrencyCardState extends State<CurrencyCard> {
  String amount = "";

  String amountSet() {
    switch (widget.order) {
      case 1:
        return widget.homeDto.steps;
      case 2:
        return widget.homeDto.distance;
      case 3:
        return widget.homeDto.waterInTake;
    }

    return "";
  }

  void closeProcess() {
    switch (widget.order) {
      case 1:
        widget.homeDto.steps = amount;
        break;
      case 3:
        widget.homeDto.waterInTake = amount;
    }

    Navigator.of(context).pop();
  }

  void saveProcess() async {
    HomeController homeController = HomeController();

    String errorMessage =
        await homeController.homeInformationModify(widget.homeDto);

    if (errorMessage.isNotEmpty) {
      switch (widget.order) {
        case 1:
          widget.homeDto.steps = amount;
          break;
        case 3:
          widget.homeDto.waterInTake = amount;
      }
    } else {
      if (widget.order == 1) {
        widget.homeDto.distance =
            (int.parse(widget.homeDto.steps) * 0.00075).toString();
      }
    }

    widget.homeReloadFunction(errorMessage);
    windowClose();
  }

  void windowClose() {
    Navigator.of(context).pop();
  }

  void navigateToImageRecognitionScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageRecognitionScreen(homeDto: widget.homeDto),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    amount = amountSet();

    return Transform.translate(
      offset: Offset(0, widget.order * -20.0),
      child: GestureDetector(
        // 조건문을 사용하여 onTap 이벤트 설정
        onTap: widget.order == 1
            ? () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('걸음수 입력'),
                      content: TextField(
                        controller:
                            TextEditingController(text: widget.homeDto.steps),
                        onChanged: (String value) {
                          widget.homeDto.steps = value;
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: closeProcess,
                          child: const Text('닫기'),
                        ),
                        TextButton(
                          onPressed: saveProcess,
                          child: const Text('저장'),
                        ),
                      ],
                    );
                  },
                );
              }
            : widget.order == 3
                ? () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('마신 물 입력'),
                          content: TextField(
                            controller: TextEditingController(
                                text: widget.homeDto.waterInTake),
                            onChanged: (String value) {
                              widget.homeDto.waterInTake = value;
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: closeProcess,
                              child: const Text('닫기'),
                            ),
                            TextButton(
                              onPressed: saveProcess,
                              child: const Text('저장'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                : () {
                    navigateToImageRecognitionScreen();
                  },
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: widget.isInverted
                ? Colors.white
                : const Color(0xff9880F7).withOpacity(0.7),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 122, 148, 254).withOpacity(0.3),
                blurRadius: 8, // 그림자의 흐림 정도
                offset: const Offset(0, 4), // 세로 오른쪽, 가로 아래쪽 방향으로만 그림자가 나오도록 설정
              ),
            ],
          ),
          height: 130,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 30, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.name,
                      style: TextStyle(
                        color: widget.isInverted
                            ? const Color(0xff9880F7)
                            : Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          amount,
                          style: TextStyle(
                            color: widget.isInverted
                                ? const Color(0xff9880F7).withOpacity(0.7)
                                : Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.code,
                          style: TextStyle(
                            color: widget.isInverted
                                ? const Color(0xff9880F7).withOpacity(0.7)
                                : Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset(widget.imagePath),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
