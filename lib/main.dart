import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_loading/controllers/home_screen_controller.dart';
import 'package:flutter_image_loading/views/homeScreen/home_screen.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ControllerBinding().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.blueAccent,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Image Loading',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeScreenController(), permanent: true);
  }
}
