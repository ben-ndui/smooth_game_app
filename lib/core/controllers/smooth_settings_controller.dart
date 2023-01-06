import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/loaders/decoders/json_decode_strategy.dart';

class SmoothSettingsController extends ChangeNotifier {
  late FlutterI18nDelegate flutterI18nDelegate;
  Locale defaultLocal = const Locale('fr');

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
}
