import 'package:smooth_game_app/core/enums/game_enums.dart';
import 'package:smooth_game_app/core/models/smooth_card_game_model.dart';
import 'package:smooth_game_app/core/models/smooth_user.dart';

class SmoothGame {
  final String gameId;
  final String createdBy;
  final DateTime date;
  final SmoothGameType gameType;
  List<SmoothCardGameModel> deck;
  List<SmoothUser> playersList;
  List<String> readyPlayersIdsList;
  String gameSettingsId;
  List<SGameStep> steps;

  SmoothGame({
    required this.gameId,
    required this.createdBy,
    required this.date,
    required this.gameType,
    this.deck = const [],
    required this.playersList,
    required this.gameSettingsId,
    this.readyPlayersIdsList = const [],
    this.steps = const [],
  });

  factory SmoothGame.fromJson(Map<String, dynamic> map) {
    return SmoothGame(
      gameId: map['gameId'].toString(),
      createdBy: map['createdBy'].toString(),
      date: map['date'] != null ? DateTime.parse(map['date']) : DateTime.now(),
      gameType: smoothGameTypeFromString(map['gameType']),
      deck: (map['deck'] as List).map((e) => SmoothCardGameModel.fromJson(e)).toList(),
      playersList: (map['players'] as List).map((e) => SmoothUser.fromJson(e)).toList(),
      readyPlayersIdsList: map['readyPlayersIdsList'] != null
          ? (map['readyPlayersIdsList'] as List).map((e) => e.toString()).toList()
          : [],
      gameSettingsId: map['gameSettingsId'] != null ? map['gameSettingsId'].toString() : "",
      steps: map['steps'] != null
          ? (map['steps'] as List).map((e) => smoothGameStepTypeFromString(map['steps'])).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gameId': gameId,
      'createdBy': createdBy,
      'date': date.toString(),
      'gameType': gameType.name,
      'deck': deck.map((e) => e.toJson()).toList(),
      'players': playersList.map((e) => e.toJson()).toList(),
      'readyPlayersIdsList': readyPlayersIdsList.map((e) => e.toString()).toList(),
      'gameSettingsId': gameSettingsId,
      'steps': steps.map((e) => e.name).toList(),
    };
  }

  bool addPlayer(SmoothUser smoothUser) {
    if (!playersList.contains(smoothUser)) {
      playersList.add(smoothUser);
      return true;
    } else {
      return false;
    }
  }

  bool removePlayer(SmoothUser? currentUser) {
    playersList.removeWhere((element) => element.userId.contains(currentUser!.userId));
    readyPlayersIdsList.removeWhere((element) => element.contains(currentUser!.userId));
    return true;
  }

  void notReady(String userId) {
    if (readyPlayersIdsList.contains(userId)) {
      readyPlayersIdsList.removeWhere((element) => element.contains(userId));
    }
  }

  void ready(String userId) {
    if (!readyPlayersIdsList.contains(userId)) {
      readyPlayersIdsList.add(userId);
    }
  }
}
