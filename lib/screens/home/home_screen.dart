import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:scandalo_radio/screens/home/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar con menú hamburguesa
      appBar: AppBar(
        backgroundColor: Color(0xFF9a0000),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),

      // Menú lateral con navegación GetX
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF9a0000)),
              child: Center(
                child: Column(
                  children: [
                    Image.asset("assets/images/logo.png", height: 75),
                    const Text(
                      "Radio Scandalo",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Inicio"),
              onTap: () {
                Get.back(); // cierra drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text("Contacto"),
              onTap: () {
                Get.dialog(
                  Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Contacto",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: const [
                              Icon(Icons.phone, color: Colors.green),
                              SizedBox(width: 8),
                              Text("0988687865"),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: const [
                              Icon(Icons.email, color: Color(0xFF9a0000)),
                              SizedBox(width: 8),
                              Text("ventasradioscandalo@gmail.com"),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => Get.back(),
                            child: const Text("Cerrar"),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Salir"),
              onTap: () {
                Get.back(); // cerrar drawer
              },
            ),
          ],
        ),
      ),

      // Fondo degradado
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: const BoxDecoration(
        //   gradient: RadialGradient(
        //     center: Alignment.center,
        //     radius: 1.0,
        //     colors: [
        //       Color(0xFFD42D5A), // oscuro centro
        //       Color(0xFFF080A0), // claro en el medio
        //       Color(0xFFD42D5A), // oscuro en bordes
        //     ],
        //     stops: [0.0, 0.5, 1.0],
        //   ),
        // ),
        color: const Color(0xFF9a0000),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo de la radio
              Image.asset("assets/images/logo.png", height: 300),
              const SizedBox(height: 30),
              // const Text(
              //   "Radio Scandalo",
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 28,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),

              // const SizedBox(height: 10),

              // // Eslogan
              // const Text(
              //   "¡La Mejor Música!",
              //   style: TextStyle(color: Colors.white70, fontSize: 18),
              // ),
              Obx(
                () => AudioWaveAnimation(
                  isPlaying: controller.isPlaying.value,
                  barCount: 25,
                  barWidth: 4,
                  maxHeight: 50,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              // Slider de volumen
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.volume_down,
                        color: Colors.white,
                        size: 40,
                      ),
                      onPressed: () {
                        double newVolume = (controller.volume.value - 0.1)
                            .clamp(0.0, 1.0);
                        controller.setVolume(newVolume);
                      },
                    ),
                    const SizedBox(width: 30),
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.black54,
                      child: IconButton(
                        icon: Icon(
                          controller.isPlaying.value
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: controller.togglePlay,
                      ),
                    ),
                    const SizedBox(width: 30),
                    IconButton(
                      icon: const Icon(
                        Icons.volume_up,
                        color: Colors.white,
                        size: 40,
                      ),
                      onPressed: () {
                        double newVolume = (controller.volume.value + 0.1)
                            .clamp(0.0, 1.0);
                        controller.setVolume(newVolume);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              //Slider de volumen
              Obx(
                () => SizedBox(
                  width: 300,
                  child: Slider(
                    value: controller.volume.value,
                    onChanged: controller.setVolume,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white30,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Botones sociales
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.facebook,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed:
                        () => controller.openUrl(
                          "https://www.facebook.com/LosManabasOficial",
                        ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.instagram,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed:
                        () => controller.openUrl(
                          "https://www.instagram.com/radioscandalo_/",
                        ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed:
                        () => controller.openWhatsApp(context, '0988687865'),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.tiktok,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed:
                        () => controller.openUrl(
                          "https://www.tiktok.com/@radioscandalo103.7?_t=ZM-8zyI5kc52Hj&_r=1",
                        ),
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

class AudioWaveAnimation extends StatefulWidget {
  final bool isPlaying;
  final Color color;
  final int barCount;
  final double barWidth;
  final double maxHeight;

  const AudioWaveAnimation({
    super.key,
    required this.isPlaying,
    this.color = Colors.white,
    this.barCount = 20,
    this.barWidth = 6,
    this.maxHeight = 60,
  });

  @override
  State<AudioWaveAnimation> createState() => _AudioWaveAnimationState();
}

class _AudioWaveAnimationState extends State<AudioWaveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  late List<double> _barHeights;

  @override
  void initState() {
    super.initState();
    _barHeights = List.generate(widget.barCount, (_) => _random.nextDouble());
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
      if (widget.isPlaying) {
        setState(() {
          _barHeights = List.generate(
            widget.barCount,
            (_) => _random.nextDouble(),
          );
        });
      }
    });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.maxHeight, // 🔒 fija la altura total
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(widget.barCount, (i) {
          final height =
              widget.isPlaying
                  ? _barHeights[i] * widget.maxHeight
                  : 8.0; // altura mínima cuando está pausado
          return AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: widget.barWidth,
            height: height,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(3),
            ),
          );
        }),
      ),
    );
  }
}
