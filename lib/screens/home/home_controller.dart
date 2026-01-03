import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  final AudioPlayer player = AudioPlayer();

  // Estados reactivos
  final isPlaying = false.obs;
  final volume = 0.5.obs;

  @override
  void onInit() async {
    super.onInit();

    // Configura el URL y volumen inicial
    try {
      await player.setUrl(
        'https://radio.tramahosting.com/listen/radio_scandalo/radio.mp3',
      );
      player.setVolume(volume.value);
    } catch (e) {
      Get.snackbar("Error", "No se pudo cargar la radio");
    }

    // Escucha el estado del reproductor y actualiza isPlaying automáticamente
    player.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });
  }

  void setVolume(double value) {
    volume.value = value;
    player.setVolume(value);
  }

  // Reproducir / Pausar
  void togglePlay() {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
  }

  // Abrir URL externo
  Future<void> openUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        Get.snackbar("Error", "No se pudo abrir el enlace");
      }
    } catch (e) {
      Get.snackbar("Error", "URL inválido");
    }
  }

  Future<void> openWhatsApp(BuildContext context, String phone) async {
    String numero = phone.replaceAll(RegExp(r'[^0-9]'), '');

    // 🇪🇨 Ecuador: 09XXXXXXXX
    if (numero.startsWith('0')) {
      numero = '593${numero.substring(1)}';
    }

    // Validación mínima (593 + 9 dígitos)
    if (!numero.startsWith('593') || numero.length < 12) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Número de WhatsApp inválido')),
      );
      return;
    }

    final uri = Uri.parse('https://wa.me/$numero');

    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('WhatsApp no está disponible')),
      );
    }
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
