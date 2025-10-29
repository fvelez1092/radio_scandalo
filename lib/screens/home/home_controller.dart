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

  Future<void> openWhatsApp({required String phone, String? message}) async {
    // Formato internacional sin + ni 0 inicial
    String cleanPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanPhone.startsWith('0')) {
      cleanPhone = '593${cleanPhone.substring(1)}'; // Ajusta Ecuador
    }

    final encodedMessage = message != null ? Uri.encodeComponent(message) : '';
    final uri = Uri.parse(
      'whatsapp://send?phone=$cleanPhone${encodedMessage.isNotEmpty ? '&text=$encodedMessage' : ''}',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('Error', 'WhatsApp no está instalado o no se puede abrir');
    }
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
