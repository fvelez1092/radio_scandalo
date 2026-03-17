// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:scandalo_radio/screens/home/home_controller.dart';
// import 'package:scandalo_radio/screens/home/home_screen.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Get.put(HomeController()); // inyectar controlador
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Radio Scandalo',
//       home: const HomeScreen(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:scandalo_radio/screens/home/home_controller.dart';
import 'package:scandalo_radio/screens/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.radioscandalo.audio',
    androidNotificationChannelName: 'Radio Scandalo',
    androidNotificationOngoing: true,
  );

  Get.put(HomeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Radio Scandalo',
      home: const HomeScreen(),
    );
  }
}
