import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smooth_game_app/core/common/smooth_handle_error.dart';
import 'package:smooth_game_app/core/controllers/smooth_game_controller.dart';
import 'package:smooth_game_app/core/enums/game_enums.dart';
import 'package:smooth_game_app/core/models/smooth_game_message.dart';
import 'package:smooth_game_app/router/router.gr.dart';

class SmoothGameMessageService {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  final String colName = 'messages';
  final String all = 'all';

  Future<void> listen({required BuildContext context}) async {
    _instance.collection(colName).snapshots().listen((event) {
      if (event.size != 0) {
        var messages = event.docs.map((e) => SmoothGameMessage.fromJson(e.data())).toList();
        var gameController = context.read<SmoothGameController>();

        if (messages.isNotEmpty) {
          for (var message in messages) {
            switch (message.to) {
              case SmoothGameMessageType.broadcast:
                switch (message.state) {
                  case SGameState.start:
                    context.router.push(const Game());
                    break;
                  case SGameState.end:
                    gameController.leaveGame(context, message.game);
                    break;
                  default:
                }
                break;
              case SmoothGameMessageType.single:
                switch (message.state) {
                  case SGameState.play:
                    gameController.play(context: context, game: message.game, data: message.data);
                    break;
                  case SGameState.pass:
                    gameController.pass(context: context, game: message.game, data: message.data);
                    break;
                  default:
                    break;
                }
                break;
              default:
                break;
            }
          }
        }
      }
    });
  }

  String getNewId() {
    return _instance.collection(colName).doc().id;
  }

  Future<void> send({required SmoothGameMessage message}) async {
    try {
      await _instance.collection(colName).doc(message.id).set(message.toJson());
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(
        className: 'SmoothGameMessageService',
        line: 19,
        error: e.message,
      );
    }
  }

  Future<void> update({required SmoothGameMessage message}) async {
    try {
      await _instance.collection(colName).doc(message.id).update(message.toJson());
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(
        className: 'SmoothGameMessageService',
        line: 19,
        error: e.message,
      );
    }
  }

  Future<void> delete({required SmoothGameMessage message}) async {
    try {
      await _instance.collection(colName).doc(message.id).delete();
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(
        className: 'SmoothGameMessageService',
        line: 19,
        error: e.message,
      );
    }
  }
}
