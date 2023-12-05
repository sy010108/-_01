import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../home/dto/home_dto.dart';
import 'calendar_controller.dart';
import 'dto/calendar_dto.dart';
import 'dto/calendar_response_dto.dart';
import 'dto/calendar_send_dto.dart';

class ChartView extends StatefulWidget {
  final DateTime selectedDate;
  final HomeDto homeDto;

  const ChartView({Key? key, required this.selectedDate, required this.homeDto})
      : super(key: key);

  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  List<CalendarDto> previousDaysData = [];
  CalendarDto selectedDayCalendarDto = CalendarDto("", "", "", "");

  void daySelectProcess(DateTime selectedDay) async {
    CalendarController calendarController = CalendarController();

    List<CalendarDto> tempPreviousDaysData = [];

    for (int i = 0; i < 7; i++) {
      DateTime previousDay = selectedDay.subtract(Duration(days: i));
      CalendarResponseDto selectedDayCalendarResponseDto =
          await calendarController.selectedDayInformationLoad(CalendarSendDto(
              widget.homeDto.userid, previousDay.toString().split(" ")[0]));

      if (selectedDayCalendarResponseDto.errorMessage.isEmpty) {
        tempPreviousDaysData.add(selectedDayCalendarResponseDto.calendarDto!);
      }
    }

    setState(() {
      previousDaysData = tempPreviousDaysData.reversed.toList();
    });
  }

  @override
  void initState() {
    super.initState();

    daySelectProcess(widget.selectedDate);

    selectedDayCalendarDto = CalendarDto(
        widget.homeDto.consumeCalories,
        widget.homeDto.steps,
        widget.homeDto.waterInTake,
        widget.homeDto.distance);
  }

  List<FlSpot> getConsumeCaloriesChartData() {
    List<FlSpot> spots = [];

    for (int i = 0; i < previousDaysData.length; i++) {
      double consumeCalories =
          double.tryParse(previousDaysData[i].consumeCalories) ?? 0.0;

      // Print the value to debug
      print("Consume Calories at index $i: $consumeCalories");

      if (consumeCalories.isFinite) {
        // Check if the value is a valid finite number (not NaN or Infinity)
        spots.add(FlSpot(i.toDouble(), consumeCalories));
      }
    }

    return spots;
  }

  List<FlSpot> getStepsChartData() {
    List<FlSpot> spots = [];

    for (int i = 0; i < previousDaysData.length; i++) {
      double steps = double.tryParse(previousDaysData[i].steps) ?? 0.0;
      spots.add(FlSpot(i.toDouble(), steps));
    }

    return spots;
  }

  List<FlSpot> getTotalDistanceChartData() {
    List<FlSpot> spots = [];

    for (int i = 0; i < previousDaysData.length; i++) {
      double totalDistance =
          double.tryParse(previousDaysData[i].distance) ?? 0.0;
      spots.add(FlSpot(i.toDouble(), totalDistance));
    }

    return spots;
  }

  List<FlSpot> getWaterChartData() {
    List<FlSpot> spots = [];

    for (int i = 0; i < previousDaysData.length; i++) {
      double water = double.tryParse(previousDaysData[i].waterInTake) ?? 0.0;
      spots.add(FlSpot(i.toDouble(), water));
    }

    return spots;
  }

  List<Color> gradientColors1 = [
    const Color.fromARGB(255, 184, 239, 177),
    const Color.fromARGB(255, 24, 183, 51),
  ];

  List<Color> gradientColors2 = [
    const Color.fromARGB(255, 228, 205, 79),
    const Color.fromARGB(255, 213, 123, 20)
  ];

  List<Color> gradientColors3 = [
    const Color(0xFFFFB6C1),
    const Color.fromARGB(255, 126, 48, 142),
  ];

  List<Color> gradientColors4 = [
    const Color(0xff02d39a),
    const Color.fromARGB(255, 34, 76, 214),
  ];

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('yyyy년 MM월').format(widget.selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("건강기록 차트"),
            Text(
              formattedDate,
              style: const TextStyle(
                fontSize: 15,
              ),
            )
          ],
        ),
        backgroundColor: const Color(0xff9880F7),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 15),
                  const Text(
                    '섭취 칼로리',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: LineChart(
                          mainChart(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    '걸음수',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: LineChart(
                          consumeStepsChart(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    '총거리',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8), // 차트와 제목 사이에 간격 추가
                  AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: LineChart(
                          totalDistanceChart(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    '물 섭취량',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: LineChart(
                          waterChart(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8), // 차트와 제목 사이에 간격 추가
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData mainChart() {
    List<FlSpot> spots = getConsumeCaloriesChartData();
    if (spots.length < 2) {
      // If there are not enough data points to form a line, add some default points
      spots = [
        const FlSpot(0, 0),
        const FlSpot(1, 0),
      ];
    }
    return LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: false,
          colors: gradientColors1,
          barWidth: 5,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors1.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
      gridData: FlGridData(
          // ... other properties
          ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          margin: 8,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            if (value >= 0 && value < spots.length) {
              int day =
                  widget.selectedDate.day - (spots.length - 1 - value.toInt());
              return '$day일';
            }
            return '';
          },
        ),
        // ... other properties
      ),
      minX: 0,
      maxX: spots.length.toDouble() - 1,
      minY: 0,
    );
  }

  LineChartData consumeStepsChart() {
    List<FlSpot> spots = getStepsChartData();

    return LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: false,
          colors: gradientColors2,
          barWidth: 5,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors2.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
      gridData: FlGridData(
          // ... other properties
          ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          margin: 8,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            if (value >= 0 && value < previousDaysData.length) {
              int day = widget.selectedDate.day -
                  (previousDaysData.length - 1 - value.toInt());
              return '$day일';
            }
            return '';
          },
        ),
        // ... other properties
      ),
      minY: 0,
    );
  }

  LineChartData totalDistanceChart() {
    List<FlSpot> spots = getTotalDistanceChartData();

    return LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: false,
          colors: gradientColors3,
          barWidth: 5,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors3.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
      gridData: FlGridData(
          // ... other properties
          ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          margin: 8,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            if (value >= 0 && value < previousDaysData.length) {
              int day = widget.selectedDate.day -
                  (previousDaysData.length - 1 - value.toInt());
              return '$day일';
            }
            return '';
          },
        ),
        // ... other properties
      ),
      minY: 0,
    );
  }

  LineChartData waterChart() {
    List<FlSpot> spots = getWaterChartData();

    return LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          colors: gradientColors4,
          isCurved: false,
          barWidth: 5,
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors4.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
      gridData: FlGridData(
          // ... other properties
          ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          margin: 8,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            if (value >= 0 && value < previousDaysData.length) {
              int day = widget.selectedDate.day -
                  (previousDaysData.length - 1 - value.toInt());
              return '$day일';
            }
            return '';
          },
        ),
      ),
      minY: 0,
    );
  }
}
