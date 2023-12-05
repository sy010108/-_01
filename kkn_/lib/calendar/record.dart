import 'package:flutter/material.dart';
import 'package:kkn_/calendar/dto/calendar_dto.dart';

class Record extends StatefulWidget {
  const Record({
    Key? key,
    required this.selectedDayCalendarDto,
    required this.name,
    required this.code,
    required this.imagePath,
    required this.isInverted,
    required this.order,
  }) : super(key: key);

  final CalendarDto selectedDayCalendarDto;

  final String name;
  final String code;
  final String imagePath;
  final bool isInverted;
  final int order;

  final _blackColor = const Color.fromARGB(255, 152, 128, 247);

  String amountSet() {
    switch (order) {
      case 0:
        return selectedDayCalendarDto.consumeCalories;
      case 1:
        return selectedDayCalendarDto.steps;
      case 2:
        return selectedDayCalendarDto.distance;
      case 3:
        return selectedDayCalendarDto.waterInTake;
    }

    return "";
  }

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  String amount = "";

  @override
  Widget build(BuildContext context) {
    amount = widget.amountSet();

    return Transform.translate(
      offset: Offset(0, widget.order * -20.0),
      child: GestureDetector(
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
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            color: widget.isInverted
                                ? widget._blackColor
                                : Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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
                                ? widget._blackColor
                                : Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.code,
                          style: TextStyle(
                            color: widget._blackColor,
                            fontSize: 20,
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
