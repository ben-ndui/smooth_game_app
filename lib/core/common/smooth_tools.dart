import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/loaders/decoders/json_decode_strategy.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:smooth_game_app/core/common/smooth_config.dart';
import 'package:smooth_game_app/core/widgets/smooth_container.dart';

class SmoothTools {
  File? image;

  late FlutterI18nDelegate flutterI18nDelegate;
  Locale defaultLocal = Locale('fr');

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      this.image = imageTemp;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  int currentLanguage = 1;

  Future<void> loadLocal(BuildContext context) async {
    flutterI18nDelegate = FlutterI18nDelegate(
      translationLoader: FileTranslationLoader(
        decodeStrategies: [JsonDecodeStrategy()],
        useCountryCode: false,
        fallbackFile: defaultLocal.languageCode,
        basePath: 'assets/lang',
      ),
    );
    await flutterI18nDelegate.load(defaultLocal);
  }

  String smoothTranslate({required BuildContext context, required String key}) {
    return FlutterI18n.translate(
      context,
      key,
    );
  }

  String formatStartTime(DateTime date) {
    return DateFormat('jm', 'fr_FR').format(date);
  }

  String getFormatGameCreatedDate(DateTime date) {
    final val = DateTime.now().difference(date);
    if (val.inHours <= 23) {
      return '${val.inHours} heures';
    } else if (val.inDays < 1 && val.inHours <= 23) {
      return '${val.inHours} heures';
    } else if (val.inDays >= 1) {
      return '${val.inDays} jours';
    } else if (val.inMinutes < 60 && val.inMinutes > 1) {
      return '${val.inMinutes} minutes';
    } else {
      return '${val.inSeconds} secondes';
    }
  }

  Widget buildBackground({required String path}) {
    return SmoothContainer(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            path,
            width: SmoothConfig.screenWidth,
            height: SmoothConfig.screenHeight,
            fit: BoxFit.cover,
          ),
          Container(
            width: SmoothConfig.screenWidth,
            height: SmoothConfig.screenHeight,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }
}
