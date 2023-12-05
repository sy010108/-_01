import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:kkn_/home/dto/home_dto.dart';
import 'package:kkn_/home/home_view.dart';
import 'package:logger/logger.dart';

import '../drawer/drawer.dart';

import 'camera_dto.dart';
import 'food_dto.dart';

class ImageRecognitionScreen extends StatefulWidget {
  const ImageRecognitionScreen({Key? key, required this.homeDto})
      : super(key: key);

  final HomeDto homeDto;

  @override
  State<ImageRecognitionScreen> createState() => _ImageRecognitionScreenState();
}

class _ImageRecognitionScreenState extends State<ImageRecognitionScreen> {
  File? _imageFile;

  final List<List<FoodRequest>> _foodList = [];

  final Logger logger = Logger();

  String saveMessage = '';

  CameraDto newcamera = CameraDto("", "");

  Future<void> uploadImage() async {
    final url = Uri.parse('http://172.29.201.185:8000/predict');

    final request = http.MultipartRequest('POST', url);
    request.files.add(http.MultipartFile(
      'image',
      _imageFile!.readAsBytes().asStream(),
      _imageFile!.lengthSync(),
      filename: _imageFile!.path.split('/').last,
    ));

    final streamResponse = await request.send();
    final response = await http.Response.fromStream(streamResponse);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.containsKey('classes')) {
        dynamic classNames = data['classes'];
        if (classNames is List<dynamic>) {
          final List<int> parsedClassNames = classNames
              .cast<double>()
              .map((value) => value.toInt())
              .toSet()
              .toList();
          classNames = parsedClassNames;
          logger.i(classNames);

          _foodList.clear();

          for (final className in classNames) {
            final numericPart = className.toString().split('.')[0];
            final foodResponse = await http.get(
              Uri.parse(
                'http://172.29.201.185:8080/food?foodcode=$numericPart',
              ),
            );
            if (foodResponse.statusCode == 200) {
              final foodData = jsonDecode(foodResponse.body);
              FoodRequest foodRequest = FoodRequest.fromJson(foodData);
              _foodList.add([foodRequest]);
            }
          }
          setState(() {
            saveMessage = '이미지 추론 완료';
          });
        }
      }
    } else {
      setState(() {
        saveMessage = '이미지 추론 실패';
      });
    }
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        saveMessage = '';
      });
    });
  }

  Future<void> calSave() async {
    final url = Uri.parse('http://172.29.201.185:8080/camera/create');
    final userid = widget.homeDto.userid;

    for (final foodRequests in _foodList) {
      dynamic calories = foodRequests.isNotEmpty ? foodRequests[0].calorie : 0;

      final requestData = CameraDto(userid, calories.toString());

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData.toJson()),
      );

      if (response.statusCode == 200) {
        widget.homeDto.consumeCalories =
            (double.parse(widget.homeDto.consumeCalories) +
                    double.parse(calories.toString()))
                .toString();
        logger.i('칼로리 저장 완료 : $calories');
        setState(() {
          saveMessage = '칼로리 저장 완료 : $calories';
        });
        toHome(widget.homeDto);
      } else {
        logger.e('칼로리 저장 실패: ${response.statusCode}');
        final error = response.body;
        logger.e(error);
        setState(() {
          saveMessage = '칼로리 저장 실패: ${response.statusCode}';
        });
      }
    }
  }

  void toHome(HomeDto homeDto) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => HomeView(homeDto: homeDto)));
  }

  Widget buildFoodItemCard(List<FoodRequest> foodRequests) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          for (final food in foodRequests)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    utf8.decode(food.foodname.runes.toList()),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/kcal.png', // Replace this with the path to your image asset
                    width: 36,
                    height: 36,
                  ),
                  title:
                      const Text('칼로리', style: TextStyle(color: Colors.black)),
                  subtitle: Text('${food.calorie}kal',
                      style: const TextStyle(color: Colors.black)),
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/bob.png', // Replace this with the path to your image asset
                    width: 36,
                    height: 36,
                  ),
                  title:
                      const Text('탄수화물', style: TextStyle(color: Colors.black)),
                  subtitle: Text('${food.carbohydrates}g',
                      style: const TextStyle(color: Colors.black)),
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/egg.png', // Replace this with the path to your image asset
                    width: 36,
                    height: 36,
                  ),
                  title:
                      const Text('단백질', style: TextStyle(color: Colors.black)),
                  subtitle: Text('${food.protein}g',
                      style: const TextStyle(color: Colors.black)),
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/meat.png', // Replace this with the path to your image asset
                    width: 36,
                    height: 36,
                  ),
                  title:
                      const Text('지방', style: TextStyle(color: Colors.black)),
                  subtitle: Text('${food.fat}g',
                      style: const TextStyle(color: Colors.black)),
                ),
              ],
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('식단 기록', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff9880F7),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Image.file(
                    _imageFile!,
                    width: 300,
                    height: 300,
                    fit: BoxFit.contain,
                  )
                : Image.asset(
                    'assets/upload.png', // Replace this with the path to your image asset
                    width: 300,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
            const SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final imagePicker = ImagePicker();
                    final pickedFile = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                      maxWidth: 600,
                      maxHeight: 600,
                    );

                    if (pickedFile != null) {
                      setState(() {
                        _imageFile = File(pickedFile.path);
                        _foodList.clear();
                        saveMessage = '이미지가 선택되었습니다.';
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff9880F7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          15), // Adjust the value to control the roundness
                    ),
                  ),
                  child: const Text(
                    '이미지 선택',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _imageFile != null ? uploadImage : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff9880F7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          15), // Adjust the value to control the roundness
                    ),
                  ),
                  child: const Text(
                    '이미지 추론',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: calSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff9880F7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          15), // Adjust the value to control the roundness
                    ),
                  ),
                  child: const Text(
                    '저장',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            if (_foodList.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _foodList.length,
                  itemBuilder: (context, index) {
                    return buildFoodItemCard(_foodList[index]);
                  },
                ),
              ),
            const SizedBox(height: 10),
            if (saveMessage.isNotEmpty)
              Text(
                saveMessage,
                style: TextStyle(
                    color:
                        saveMessage.contains('실패') ? Colors.red : Colors.black),
              ),
          ],
        ),
      ),
    );
  }
}
