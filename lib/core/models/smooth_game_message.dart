import 'package:smooth_game_app/core/enums/game_enums.dart';
import 'package:smooth_game_app/core/models/smooth_game.dart';

class SmoothGameMessage {
  final String id;
  final SGameState state;
  final SmoothGameMessageType to;
  final SmoothGame game;
  final dynamic data;

  SmoothGameMessage(
      {required this.id, required this.state, required this.to, required this.game, this.data});

  factory SmoothGameMessage.fromJson(Map<String, dynamic> json) {
    return SmoothGameMessage(
      id: json['id'] != null ? json['id'].toString() : "",
      state: sGameStateFromString(json['state']),
      to: smoothGameMessageTypeFromString(json['to']),
      game: SmoothGame.fromJson(json),
      data: json['game'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'state': state.name,
      'to': to.name,
      'game': game.toJson(),
      'data': data.toString(),
    };
  }
}
