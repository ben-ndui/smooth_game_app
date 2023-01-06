import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_game_app/core/common/smooth_handle_error.dart';
import 'package:smooth_game_app/core/models/smooth_card_game_model.dart';

class SmoothCardGameService {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  final String colName = "cards";
  final String all = "all";

  String getNewId() {
    return _instance.collection(colName).doc().id;
  }

  void saveCard(SmoothCardGameModel cardGameModel) {
    try {
      _instance.collection(colName).doc(cardGameModel.uid).set(cardGameModel.toJson());
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(error: e, className: "SmoothCardGameService", line: 19);
      return null;
    }
  }

  Stream<List<SmoothCardGameModel>>? getAllCards() {
    try {
      return _instance.collection(colName).snapshots().map((event) {
        return event.docs.map((e) => SmoothCardGameModel.fromJson(e)).toList();
      });
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(error: e, className: "SmoothCardGameService", line: 19);
      return null;
    }
  }
}
