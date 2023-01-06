import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_game_app/core/common/smooth_handle_error.dart';
import 'package:smooth_game_app/core/enums/game_enums.dart';
import 'package:smooth_game_app/core/models/smooth_game.dart';
import 'package:smooth_game_app/core/models/smooth_game_message.dart';
import 'package:smooth_game_app/core/services/smooth_game_message_service.dart';

class SmoothGameService {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  final String colName = "smoothGame";
  final String all = "all";

  String getNewId() {
    return _instance.collection(colName).doc().id;
  }

  bool createGame(SmoothGame game) {
    try {
      print("GAME LINE 17 - SMOOTHGAMESERVICE : ${game.toJson()}");
      _instance.collection(colName).doc(game.gameId).set(game.toJson());
      return true;
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(error: e, className: "SmoothGameService", line: 20);
      return false;
    }
  }

  void updateGame(SmoothGame game) {
    try {
      _instance.collection(colName).doc(game.gameId).update(game.toJson());
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(error: e, className: "SmoothGameService", line: 28);
    }
  }

  void deleteGame(String gameId) {
    try {
      _instance.collection(colName).doc(gameId).delete();
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(error: e, className: "SmoothGameService", line: 36);
    }
  }

  Stream<List<SmoothGame>>? allGames() {
    try {
      final allGames = _instance
          .collection(colName)
          .snapshots()
          .map((event) => event.docs.map((e) => SmoothGame.fromJson(e.data())).toList());
      return allGames;
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(error: e, className: "SmoothGameService", line: 44);
      return null;
    }
  }

  Stream<SmoothGame>? getGameById(String gameId) {
    try {
      return _instance
          .collection(colName)
          .where('gameId', isEqualTo: gameId)
          .snapshots()
          .map((value) => SmoothGame.fromJson(value.docs.first.data()));
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(error: e, className: "SmoothGameService", line: 44);
      return null;
    }
  }

  Stream<List<SmoothGame>>? allGamesByType(SmoothGameType type) {
    try {
      return _instance.collection(colName).snapshots().map((event) {
        List<SmoothGame> games = [];
        final list = event.docs.map((e) => SmoothGame.fromJson(e.data())).toList();
        for (var game in list) {
          if (game.gameType == type) {
            games.add(game);
          }
        }
        return games;
      });
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(error: e, className: "SmoothGameService", line: 62);
      return null;
    }
  }

  Stream<List<SmoothGame>>? allGamesByUser(String userId) {
    try {
      return _instance.collection(colName).snapshots().map((event) {
        List<SmoothGame> games = [];
        final list = event.docs.map((e) => SmoothGame.fromJson(e.data())).toList();
        for (var game in list) {
          if (game.createdBy == userId) {
            games.add(game);
          }
        }
        return games;
      });
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(error: e, className: "SmoothGameService", line: 80);
      return null;
    }
  }

  void startGame({
    required SGameState state,
    required SmoothGameMessageType to,
    required SmoothGame game,
  }) {
    try {
      var gameMessageService = SmoothGameMessageService();

      var gameMessage = SmoothGameMessage(
        id: '',
        state: SGameState.start,
        to: SmoothGameMessageType.broadcast,
        game: game,
      );
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(className: 'SmoothGameService', line: 100, error: e.message);
    }
  }
}
