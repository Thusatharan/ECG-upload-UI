import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pregnancy_stress_test/screens/details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imageList = [
    'assets/images/slider1.jpg',
    'assets/images/slider2.jpeg',
    'assets/images/slider3.png',
  ];

  File? selectedImage;
  bool? isImageUploaded = false;
  Future pickImage(ImageSource source) async {
    try {
      final selectedImage = await ImagePicker().pickImage(source: source);
      if (selectedImage == null) return;

      final imageTemporary = File(selectedImage.path);
      setState(() {
        this.selectedImage = imageTemporary;
        isImageUploaded = true;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Upload ECG'),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage("assets/images/pre2.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  width: double.infinity,
                  child: CarouselSlider(
                    items: imageList
                        .map((e) => ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.asset(
                                    e,
                                    width: 1050,
                                    height: 450,
                                    fit: BoxFit.cover,
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        autoPlay: true),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 280,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: selectedImage != null
                          ? Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              "assets/images/ecganim.gif",
                              fit: BoxFit.cover,
                            ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () => pickImage(ImageSource.gallery),
                      child: Text('Choose ECG Image from gallery'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.blue,
                          ),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 14))),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: selectedImage != null
                    ? ElevatedButton(
                        onPressed: isImageUploaded == true
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DetailsScreen()),
                                );
                              }
                            : null,
                        child: Text('Test Stress'),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                            textStyle: MaterialStateProperty.all(
                                TextStyle(fontSize: 14))),
                      )
                    : ElevatedButton(
                        onPressed: null,
                        child: Text('Select an ECG Image first'),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey),
                            textStyle: MaterialStateProperty.all(
                                TextStyle(fontSize: 14))),
                      ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
