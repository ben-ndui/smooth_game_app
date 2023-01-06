import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_game_app/core/common/smooth_handle_error.dart';
import 'package:smooth_game_app/core/models/smooth_game_settings.dart';

class SmoothGameSettingsService {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  final String colName = "gameSettings";
  final String all = "all";

  String getNewId() {
    return _instance.collection(colName).doc().id;
  }

  void setSettings(SmoothGameSettings settings) {
    try {
      _instance.collection(colName).doc(settings.gameSettingsId).set(settings.toJson());
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(
          className: 'SmoothGameSettingsService', line: 19, error: e.message);
    }
  }

  void updateSettings(SmoothGameSettings settings) {
    try {
      _instance.collection(colName).doc(settings.gameSettingsId).update(settings.toJson());
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(
          className: 'SmoothGameSettingsService', line: 27, error: e.message);
    }
  }

  void deleteSettings(String settingsId) {
    try {
      _instance.collection(colName).doc(settingsId).delete();
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(
          className: 'SmoothGameSettingsService', line: 27, error: e.message);
    }
  }

  Stream<List<SmoothGameSettings>>? getAllSettings() {
    try {
      return _instance
          .collection(colName)
          .snapshots()
          .map((event) => event.docs.map((e) => SmoothGameSettings.fromJson(e.data())).toList());
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(
          className: 'SmoothGameSettingsService', line: 43, error: e.message);
      return null;
    }
  }

  Future<SmoothGameSettings>? getSettingsById(String settingsId) {
    try {
      return _instance
          .collection(colName)
          .doc(settingsId)
          .get()
          .then((value) => SmoothGameSettings.fromJson(value.data()));
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(
          className: 'SmoothGameSettingsService', line: 43, error: e.message);
      return null;
    }
  }
}
